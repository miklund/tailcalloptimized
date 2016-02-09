---
layout: post
title: "Beginners guide to Arexx"
description: 
date: 2016-02-09 14:54:09
tags: 
assets: assets/posts/2016-02-09-beginners-guide-to-arexx
image: assets/posts/2016-02-09-beginners-guide-to-arexx/title.jpg

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

![Opening an Arexx file in memacs](/assets/posts/2016-02-09-beginners-guide-to-arexx2.png)

## Hello World!

Our first program is as usual _Hello World_, and already at this small and simple program we have a few caveats we need to deal with.

{% gist miklund/d248791e2957f5c0db89 HelloWorld.rexx %}

The first is that every Arexx source file needs to start with a comment, or the RexxMast intepretator will not recognize this as a program. The second is that `SAY` is the equivalent of the Amiga Basic `PRINT`, but in Amiga Basic `SAY` means something completely different. When you use the `SAY` command in Amiga Basic, it will invoke the Amiga speech synthesizer and audibly speak the words through the audio interface.

You run the program from the command line.

```
rx HelloWorld
```

This will look for a HelloWorld.rexx file in REXX: which is the same as SYS:S. If it can't find a matching script file there, it will instead look in the current working directory.

![Executing Arexx Hello World in a CLI window](/assets/posts/2016-02-09-beginners-guide-to-arexx3.png)

If you specify an icon for your Arexx program you can also specify default tool as SYS:C/Rx which will make it runnable directly from Workbench. Rx will start RexxMast if it's not already started making these scripts quite suitable for tasks like "Harddrive installation" where the user just want to click an icon and have the program installed for them.

## Variables

In Arexx variables are not declared as in Amiga Basic. Instead, variables are just used, and will be garbage collected when they fall out of scope. This is a huge step forward from Amiga Basic.

```rexx
/* This program asks the user for name and shoe size */
SAY "What is your name?"
PULL name
SAY "What is your shoe size?"
PULL size

SAY "Hello" name "your shoe size is" size
```

Just like Amiga Basic, Arexx will output variables with one space as padding.

![A classic program asking for input and outputting it back to the user](/assets/posts/2016-02-09-beginners-guide-to-arexx4.png)


## Control Flow



