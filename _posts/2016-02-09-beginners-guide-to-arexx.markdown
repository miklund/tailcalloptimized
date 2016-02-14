---
layout: post
title: "Beginners guide to Arexx"
description: In 1990 with the release of AmigaOS 2.0 the Amiga Basic language was deprecated and exchanged with Arexx. This is an introduction to the Arexx scripting language.
date: 2016-02-09 14:54:09
tags: arexx, amiga
assets: assets/posts/2016-02-09-beginners-guide-to-arexx
image: assets/posts/2016-02-09-beginners-guide-to-arexx/title.gif

author: 
    name: Mikael Lundin
    email: hello@mikaellundin.name 
    web: http://mikaellundin.name
    twitter: mikaellundin
    github: miklund
    linkedin: miklund
---

[Amiga Basic](/2016/02/03/beginners-guide-to-amiga-basic.html "Beginners guide to Amiga Basic") was deprecated by the release of AmigaOS 2.0. Both due to compability problems with the OS, but also because Amiga Basic pulled some trick that made it impossible to get working on 32-bit CPUs. I assume that Microsoft could've fixed that problem but we can assume that the partnership between Commodore and Microsoft went cold, and that made Commodore to implement their own version of IBM Rexx to the Amiga.

Arexx is an intepreted language just like Amiga Basic, but the focus is quite different. Where Amiga Basic was a language you could use to write small applications and games, Arexx is a tool for automation. In modern language terms I would compare Amiga Basic with Python and Arexx with PowerShell. That is exactly how different these languages are to each other.

![Start the Arexx intepreter](/assets/posts/2016-02-09-beginners-guide-to-arexx/arexx1.png)

Before you start writing code and execute programs you need to start the Arexx intepreter. You do this by opening SYS:System/ directory and run the RexxMast program that is there. If you want Arexx to be a part of your day-to-day work cycle, you can add this to user-startup.

```
SYS:System/RexxMast >NIL:
```

I'm using the micro emacs (MEMACS) that comes with the Amiga to edit Arexx files, but I'm sure there is a better editor out there that will provide syntax highlighting and other tooling.

![Opening an Arexx file in memacs](/assets/posts/2016-02-09-beginners-guide-to-arexx/arexx2.png)

## Hello World!

Our first program is as usual _Hello World_, and already at this small and simple program we have a few caveats we need to deal with.

{% gist miklund/d248791e2957f5c0db89 HelloWorld.rexx %}

The first is that every Arexx source file needs to start with a comment, or the RexxMast intepretator will not recognize this as a program. The second is that `SAY` is the equivalent of the Amiga Basic `PRINT`, but in Amiga Basic `SAY` means something completely different. When you use the `SAY` command in Amiga Basic, it will invoke the Amiga speech synthesizer and audibly speak the words through the audio interface.

You run the program from the command line.

```
rx HelloWorld
```

This will look for a HelloWorld.rexx file in REXX: which is the same as SYS:S. If it can't find a matching script file there, it will instead look in the current working directory.

![Executing Arexx Hello World in a CLI window](/assets/posts/2016-02-09-beginners-guide-to-arexx/arexx3.png)

If you specify an icon for your Arexx program you can also specify default tool as SYS:C/Rx which will make it runnable directly from Workbench. Rx will start RexxMast if it's not already started making these scripts quite suitable for tasks like "Harddrive installation" where the user just want to click an icon and have the program installed for them.

## Variables

In Arexx variables are not declared as in Amiga Basic. Instead, variables are just used, and will be garbage collected when they fall out of scope. This is a huge step forward from Amiga Basic.

{% gist miklund/d248791e2957f5c0db89 Variables.rexx %}

Just like Amiga Basic, Arexx will output variables with one space as padding.

![A classic program asking for input and outputting it back to the user](/assets/posts/2016-02-09-beginners-guide-to-arexx/arexx4.png)

## Control Flow

Arexx has loops and conditional statements like any other language but they look a bit different. The `DO` statement is in the center of looping, and you can use it in different ways to achieve what you want.

This is a game that will ask you to guess a number.

{% gist miklund/d248791e2957f5c0db89 GuessTheNumber.rexx %}

This code is pretty straigt forward. There are some things to note.

* RANDOM() will give you a random number between low and high arguments, but it will not work with a high argument more than 1000. If you want to random generate a number higher than 1000 you need to use the RANDU() function that returns a random float between 0-1.

* The `~=` operator is actually the NOT operator seen as `!=` or `<>` in other languages. You can use tilde `~` to negate several other operators like `~>` not larger than or `~<` not less than.

![Small game in Arexx where we ask the user to guess a random number.](/assets/posts/2016-02-09-beginners-guide-to-arexx/arexx5.png)

A wierd aspect of the previous sample is that I never specify if the `guess` I pull from the user is an integer of a string. It is pulled as a string and then compared to an integer, so we could assume that it is an integer - but it is really Schrödinger's cat until we start using it.

Types in Arexx is a bit javascripty in that sense. Here is a short program to demonstrate what seven is or not is.

{% gist miklund/d248791e2957f5c0db89 Types.rexx %}

One equal sign `=` means _equals_ and double equal signs `==` means _exactly equals_. Let's see what the output is.

![Arexx has very little regards to types and you need to do trickery in order to understand what is what](/assets/posts/2016-02-09-beginners-guide-to-arexx/arexx6.png)

This means that "7" is exactly equal to 7 and also equal to 7.0000000001, but not exactly. A tiny bit confusing perhaps.

## For-loop

DO is the framework for looping constructs, so you use it also to create a traditional FOR-loop. This program will paint a pyramid on the screen.


{% gist miklund/d248791e2957f5c0db89 Pyramid.rexx %}

We use the `||` operator to concatenate strings. This is called an abuttal concatenation, which is a first one for me.

![FOR statements are similiar in Arexx as they are in other languages](/assets/posts/2016-02-09-beginners-guide-to-arexx/arexx7.png)

As with most languages the DO can also count down, instead of up.

{% gist miklund/d248791e2957f5c0db89 Factorial.rexx %}

You can also do the following looping constructs with DO.

* `DO until seven = actualSeven` which is the opposite to `while`
* `DO forever` will loop until it reaches a `leave` clause
* `DO 3` will loop three times without a counter
* `DO even=2 to 16 by 2` will increment even by 2 every iteration until it reaches 16
* `DO quarter=0.25 to 1.0 by 0.25` will iterate on 0.25, 0.5, 0.75 and 1.0
* `DO while lines( ) > 0` is useful for reading files

![Painting a pyramid in Arexx](/assets/posts/2016-02-09-beginners-guide-to-arexx/arexx8.png)

## String manipulation

Arexx has built-in functions for string manipulations as getting substrings, padding strings and retrieving ascii values.

Here is a simple ceasar cipher implemented in Arexx.

{% gist miklund/d248791e2957f5c0db89 Cipher.rexx %}

There are a few things to take note of here.

* C2D() will convert a character to a digit. `C2D("A")` will return the number 65.
* D2C() is the opposite of C2D() as it will convert a number to a character. `D2C(65)` becomes "A".
* LEFT(data, 1) will get 1 character from the left of `data`
* RIGHT(data, LENGTH(data) - 1) will therefor return the string except the leftmost character.
* `//` is almost the modulus operator in Arexx, with the difference that it also works on negative numbers.


![String manipulation in Arexx implementing a simple ceasar cipher](/assets/posts/2016-02-09-beginners-guide-to-arexx/arexx9.png)

## Arrays and Compound Variables

Arexx has something called _compund variables_ that works a little like javascript. You can without declaring anything write something looking like this.

```rexx
days.monday = "No appointments"
```

And it will work just fine. The field is called `days` and it has a tail called `monday`. You can have several levels of tails.

If you instead of writing an identifier for tail, you use a number, you can index into a compound variable as if it were an array.

{% gist miklund/d248791e2957f5c0db89 Fibonacci.rexx %}

The exciting thing here is that we're using numbers as tail, and instead of writing `fibonacci.1` we can access the same value with `fibonacci.i` when i is equal to 1. This makes for some really readable code.

![Calculating Fibonacci sequence with Arexx](/assets/posts/2016-02-09-beginners-guide-to-arexx/arexx10.png)

## Procedures

Creating a procedure in Arexx is as easy as writing a label and ending it with return statement.

{% gist miklund/d248791e2957f5c0db89 Procedures.rexx %}

But if you take a close look it looks more like a GOTO statement than anything else. The variables from the main program is shared with the procedures.

![Typing out the Arexx message on the command line](/assets/posts/2016-02-09-beginners-guide-to-arexx/arexx11.png)

You can fix this in a few ways.

{% gist miklund/d248791e2957f5c0db89 BubbleSort.rexx %}

When we use the keyword `procedure` the scope of the subroutine becomes private and it can no longer access fields defined outside of its scope. We can go around this by exposing fields in a whitelist that we want accessible from inside the procedure.

This is not good, but it is ok.

* `swap` accepts two input arguments that defines what values in the array should be swapped, these are imported into the subroutine with `ARG` command

![Sorting an array of number with Arexx and bubble sort](/assets/posts/2016-02-09-beginners-guide-to-arexx/arexx12.png)

## Functions and recursion

What defines a function in Arexx is that it returns a value, and you need to take care of that value.

Here is a recursive version of a binary search algorithm.

{% gist miklund/d248791e2957f5c0db89 Find.rexx %}

And this way we can build recursive algorithms that are using functions in Arexx.

![A recursive binary search implemented in Arexx](/assets/posts/2016-02-09-beginners-guide-to-arexx/arexx13.png)

## Inter process communication

In Arexx there is a clipboard that you can use to communicate between processes. This can be seen as a global key/value store on the operating system level.

{% gist miklund/d248791e2957f5c0db89 Communication.rexx %}

Here I display how you can build a simple selection menu using the `SELECT` statement, and also how to interop with the clipboard using `SETCLIP` AND `GETCLIP`.

![A program to demonstrate inter process communication in Arexx](/assets/posts/2016-02-09-beginners-guide-to-arexx/arexx14.png)

It is not that complicated.

## Summary

When starting out writing this tutorial I had a small distaste of Arexx from previous attempts at understanding the language. As a young boy I never managed to get an Arexx program to run, because I thought the introduction comment was only ceremonial and could be skipped. It surely is one strange feature that you require all programs to start with a comment, but when I come to think of it, it might not be such a bad idea.

When working with the language you start to sense that everything is very losely coupled, where you don't need to define any variables or their types. Actually the Arexx manual goes to the length of declaring that there is not types, but I ran into some troubles when I wanted to do mathematical operations and the underlying type were string.

I can sense that this is a truely productivity language where you can get easy things done fast. You write your scripts to automate what you otherwise would do manually in Workbench, and it work very well for that. So for automation this is a nice language to work with.

I would not want to create something bigger and more complicated as the language doesn't support modules or namespacing. You can import external libraries but these needs all to be specially designed for Arexx.
