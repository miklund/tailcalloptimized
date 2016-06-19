---
layout: post
title: "Creating a WebAssembly binary and running it in a browser"
description: Introduction to the WebAssembly binary format
date: 2016-06-19 12:47:32
tags: wasm, WebAssembly, assembler, javascript
assets: assets/posts/2016-06-19-creating-a-webassembly-binary-and-running-it-in-a-browser
image:

author: 
    name: Mikael Lundin
    email: hello@mikaellundin.name 
    web: http://mikaellundin.name
    twitter: mikaellundin
    github: miklund
    linkedin: miklund
---

[WebAssembly](https://github.com/WebAssembly/), is the promise of an intermediate language of the web, or [JavaScript as an Assembly langauge](http://www.hanselman.com/blog/JavaScriptIsAssemblyLanguageForTheWebSematicMarkupIsDeadCleanVsMachinecodedHTML.aspx "Scott Hanselman - JavaScript is Assembly Language for the Web: Sematic Markup is Dead! Clean vs. Machine-coded HTML") if you want to. It really came from the AsmJS initiative, where a static subset of javascript was found to run much much faster than the full dynamic language. WebAssembly is the next iteration of that where a new assembler language has been designed to run on top of the javascript engine. This comes with a couple of promises

1. It will run faster than ordinary JavaScript
2. It will load faster than AsmJS because it doesn't have to be interpreted from text
3. It has a binary format that will be smaller than anything text based
4. It will, in the future, also be debuggable in the browser

The most uses we have seen of asmjs so far has been compiling C/C++ into asmjs in order to run these in the browser. We have all seen the Unity 3D demos and been impressed. For me, WebAssembly is the assembler language of the web, and this provides a unique opportunity to create new languages that will target the web and compile to a real IL language, instead of compiling to the less efficient javascript.

This blog post will take a look at the binary format of WebAssembly, how to read it, write it and run it.

## WebAssembly text syntax

In order to better understand the WebAssembly (from now on called wasm) we're going to take a look at the sample module for this blog post.

```
(module
  (type $0 (func (param i32 i32) (result i32)))
  (export "add" $add)
  (func $add (type $0) (param $var$0 i32) (param $var$1 i32) (result i32)
    (i32.add
      (get_local $var$0)
      (get_local $var$1)
    )
  )
)
```

This looks a little bit like LISP syntax. It is the [textual representation](https://github.com/WebAssembly/design/blob/master/TextFormat.md) of the module in an [s-expression](https://en.wikipedia.org/wiki/S-expression) syntax. The module exports one function called add, that will add two integer numbers together.

* The **type** section contains any function definition that are used in our module. It will be referenced to later.
* The **export** section contains any functions that should be exported, and able to be called from outside this module.
* The **code** section starts with a function declaration. This is the declaration of our function "add". It will only accept types of i32 (32 bit integer) and will add them together by the operator i32.add.

WAsm only has 4 types.

* i32 (32 bit integer)
* i64 (64 bit integer)
* f32 (32 bit float)
* f64 (64 bit float)

Any other type will need to be constructed artificially by reading and writing raw memory, but this is out of scope for this blog post.

## Reading the Wasm binary format

By going through the [specification of the binary format](https://github.com/WebAssembly/design/blob/master/BinaryEncoding.md) I have written a wasm binary from scratch. You don't have to do this, there are excellent libraries like [binaryen](https://github.com/WebAssembly/binaryen) that can help you transform a S-expression syntax directly to wasm binary. However, I wanted to do this from javascript and in that the tools are scarse.

Here's our program.

```
00000000  00 61 73 6d 0b 00 00 00  04 74 79 70 65 87 80 80  |.asm.....type...|
00000010  80 00 01 40 02 01 01 01  01 08 66 75 6e 63 74 69  |...@......functi|
00000020  6f 6e 82 80 80 80 00 01  00 06 6d 65 6d 6f 72 79  |on........memory|
00000030  85 80 80 80 00 80 02 80  02 01 06 65 78 70 6f 72  |...........expor|
00000040  74 86 80 80 80 00 01 00  03 61 64 64 04 63 6f 64  |t........add.cod|
00000050  65 8c 80 80 80 00 01 86  80 80 80 00 00 14 00 14  |e...............|
00000060  01 40 04 6e 61 6d 65 86  80 80 80 00 01 03 61 64  |.@.name.......ad|
00000070  64 00                                             |d.|
```

It has a preamble and 6  sections as we can see in the clear text representation.

* preamble
* type
* function
* memory
* export
* code
* name

Each section starts with the name of that section and a count on how many bytes long the section is in total.

### Preamble

![wasm preamble](/assets/posts/2016-06-19-creating-a-webassembly-binary-and-running-it-in-a-browser/preamble.png)

The preamble is the first 8 bytes of the file. The first 4 bytes is a uint32 'magic number' `0x6d736100` that spells out '\0asm' in ASCII. The point of this magic number is to quickly determine if this file is a wasm module or not.

The next four bytes is a uint32 number that represents the version of the wasm specification this file was constructed with. In this case it is version 11, or 0x0000000b in hex.

### Type section

All sections are optional, so when they appear they need to be correctly labeled. We start with the type section.

![wasm type section](/assets/posts/2016-06-19-creating-a-webassembly-binary-and-running-it-in-a-browser/type.png)

The first byte 0x04 tells the intepreter that the name of this section is the next 4 bytes. So `0x74 0x79 0x70 0x65` are not surprisingly the ASCII codes for the word _type_. Following that is a varuint32 telling how many bytes this section is, and by some reason I haven't figured out, (maybe because I'm reading the specs for version 10 and this file format is version 11) this varuint32 in [LEB128](https://en.wikipedia.org/wiki/LEB128) format is padded to all 4 bytes and an extra byte for the sign `0x0080808087`. The translation
of this to pure English is that the type section is 7 bytes long.

The type section is defined as follows

* `0x01` There is one type defined in this section
* `0x40` This is a function type that is defined
* `0x02` The function type has two parameters
* `0x01` First parameter is of type i32
* `0x01` Second parameter is of type i32
* `0x01` The function returns a result
* `0x01` The result is of type i32

What we're doing here is registering the function signature of `i32 add(arg1 : i32, arg2 : i32)` in the type section of the wasm binary.

This section is now complete and the next section follows directly there after.

### Function section

![wasm function section](/assets/posts/2016-06-19-creating-a-webassembly-binary-and-running-it-in-a-browser/function.png)

Again the starting `0x08` tells us the identifier of this section is 8 characters and the following bytes `0x66 0x75 0x6e 0x63 0x74 0x69 0x6f 0x6e` spells out the word _function_. The following varuint32 value `0x0080808082` tells us that this section is two bytes long.

* `0x01` There is one function we want to aknowledge.
* `0x00` The function of interest has index 0 in the type section.

That's it. We point out the function signature from the type section.

### Memory section

![wasm memory section](/assets/posts/2016-06-19-creating-a-webassembly-binary-and-running-it-in-a-browser/memory.png)

The memory section starts with `0x06` that specifies that this section's identifier is the next six characters `0x06 0x6d 0x65 0x6d 0x6f 0x72 0x79`. Those spell out the name _memory_.

The following varuint32 value `0x0080808085` tells us that this section is 5 bytes long.

* `0x0280` Tells the intepreter that the initial size of memory allocated by this module should be 256 pages of 64KiB memory. That is 16 MB memory.
* `0x0280` Tells the intepreter that the maximun size of memory this module is allowed to allocate is 256 pages of 64KiB memory.
* `0x01` Specifies that this memory is exported and visible outside the module.

I'm not so sure about this section and I need to play around with it more to find out the implications of the different settings here. These settings were just something I came up with for default until I've figured it out.

### Export section

![wasm export section](/assets/posts/2016-06-19-creating-a-webassembly-binary-and-running-it-in-a-browser/export.png)

The export section starts with `0x06` that specifies that the following identifier is six characters long `0x65 0x78 0x70 0x6f 0x72 0x74` spelling out _export_. The following varuint32 value `0x0080808086` tells us that this section is 6 bytes long.

* `0x01` Specifies how many exports there will be
* `0x00` Specifies the index of the first export in the function table
* `0x03` The identifier of the exported function is 3 bytes long
* `0x61 0x64 0x64` Is the name of the exported function in ASCII, meaning _add_

This section makes the add function visible outside this module by exporting it. It is through this exported interface that we will call the add function from javascript.

### Code section

This is the fun section.

![wasm code section](/assets/posts/2016-06-19-creating-a-webassembly-binary-and-running-it-in-a-browser/code.png)

The code section starts with `0x04` that specifies that the identifier for this section is four characters `0x63 0x6f 0x64 0x65` and it spells out _code_. The following varuint32 value `0x008080808c` tells us that this section is 12 bytes long.

It might be good to revisit that AST of our program now.

```
(module
  (type $0 (func (param i32 i32) (result i32)))
  (export "add" $add)
  (func $add (type $0) (param $var$0 i32) (param $var$1 i32) (result i32)
    (i32.add
      (get_local $var$0)
      (get_local $var$1)
    )
  )
)
```

Everything except the body of the $add function has already been written down. The code section will contain the body part. Each function call has its own [HEX opcode](), that you'll be aware of. But most importantly, this is binary coded post-order, so that first the left node is written, then right now, and last the parent node.

Let's take a look

* `0x01` There is one function body.
* `0x0080808086` This first function body is 6 bytes long
* `0x00` There are 0 local variables
* `0x14` The opcode for the left get\_local call
* `0x00` Get the 0 index parameter to this function
* `0x14` The opcode for the right get\_local call
* `0x01` Get the 1 index parameter to this function
* `0x40` The opcode for i32.add

As you can see the code is almost written backward. This is the effect of rendering the AST post-order.

### Name section

![wasm name section](/assets/posts/2016-06-19-creating-a-webassembly-binary-and-running-it-in-a-browser/name.png)

The name section starts with `0x04` indicating that the identifier is 4 characters long, namely `0x6e 0x61 0x6d 0x65` which is the word _name_ translated from ASCII.

The following varuint32 value `0x0080808086` specify that the length of this section is 6 bytes.

* `0x01` There is 1 name entry
* `0x03` The first name is 3 characters long
* `0x61 0x64 0x64` The name _add_
* `0x00` There are 0 local names defined

I'm not really sure what a local name is, but I guess I will find out. And with this we have written all 114 bytes that conclude our simple wasm module.

## Writing a WebAssembly binary module

I did not write this WebAssembly by hand in an HEX editor. I wrote me some javascript to generate the code for me, but before I did that I took a look at what data types are used in this format.

* uint8 - single-byte unsigned integer
* uint32 - four-byte little endian unsigned integer
* varint32 - singed LEB128 variable-length integer, limited to int32 values
* varuint1 - unsigned LEB128 variable-length integer, limited to values 0 or 1
* varuint7 - unsigned LEB128 variable-length integer, limited to values 0 to 127
* varuint32 - unsigned LEB128 variable-length integer limited to uint32 values
* varint64 - signed LEB128 variable length integer, limited to int64 values
* value\_type - single-byte unsigned integer encoded as [1, i32; 2, i64; 3, f32; 4, f64]

My first reaction to this was _this ain't too bad_ and the second was _what is an LEB128?_. It is a special type of encoding that you can use for compressing unused binary space. If you have an int32 and store a value less than 256, you only need one byte of that integer. The three other bytes are excessive. LEB128 let's you encode that binary so you only have to store the bytes you're using of the data type.

{% gist miklund/79c1f3eb129ea5689c03c41d17922c14 leb128.js %}

With the unsignedLEB128 I had to append a padding, for the values that define length of a section. I hope I can remove this in the future.

With this in place, it was pretty easy to define the data types.

{% gist miklund/79c1f3eb129ea5689c03c41d17922c14 dataTypes.js %}

And with the data types in place it was straight forward creating the binary code. It is however heavily commented and it repeats itself, but this is because I did it as a learning excercise. I would extract some methods if I were to make it formal and use it as a library.

{% gist miklund/79c1f3eb129ea5689c03c41d17922c14 buildBinary.js %}

With this, all we need to do is to write the binary array to hdd.

{% gist miklund/79c1f3eb129ea5689c03c41d17922c14 writeFile.js %}

## Testing the WebAssembly binary in a browser

We have created a binary wasm file, but how do we test it? The information on this was pretty scarse until I found [this](http://webassembly.github.io/demo/ "WebAssembly demo page") demo page. You can currently run wasm files in experimental modes on following browsers

* Chrome Canary, open chrome://flags/#enable-webassembly
* Firefox Nightly, open about:config and set javascript.options.wasm to true
* Download preview of Microsoft Edge

If you have a wasm enabled browser you can go [here](/assets/posts/2016-06-19-creating-a-webassembly-binary-and-running-it-in-a-browser/test.html) and use the following [binary](/assets/posts/2016-06-19-creating-a-webassembly-binary-and-running-it-in-a-browser/out.wasm) to try it out.

![wasm test page](/assets/posts/2016-06-19-creating-a-webassembly-binary-and-running-it-in-a-browser/test.png)

The source for loading and running the wasm module is pretty straight forward.

{% gist miklund/79c1f3eb129ea5689c03c41d17922c14 test.html %}

