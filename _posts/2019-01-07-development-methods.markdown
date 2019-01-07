---
layout: post
title: "Development Methods"
description: "Considering how we go from nothing to an implemented feature. What kind of development methods, explicit or implicit are there?"
date: 2019-01-07 19:57:02
tags: tdd 
assets: assets/posts/2019-01-07-development-methods
image: 

author: 
    name: Mikael Lundin
    email: hello@mikaellundin.name 
    web: http://mikaellundin.name
    twitter: mikaellundin
    github: miklund
    linkedin: miklund
---

I'm a TDD practitioner, in the sense that I write my tests first. I am a test first developer, a red-green-refactor cultist. I'm very open about it and it offends people. They want to discuss tests with me, tell me that they've tried this unit test thing and it doesn't work, and they want me to convince them that unit testing is the only way so they can complain later about my dogmatism.

It's just like being a vegetarian.

But this was not intended to be a rant. Instead an observation that people seem to think I practice TDD because of testing, while I see unit tests as a byproduct of the way I work. The same people look horrified when I tell them to delete tests that doesn't work. The purpose of TDD is not to build a test suite. It is to provide a method of developing software.

Starting from a blank IDE. How do you start implementing a feature? What is your method to go from nothing to something?

In TDD we start with a test, or rather, we start with thinking.
- What do I want this code to do?
- Then I implement a test that verify it
- Then I implement code to satisfy the test
- Then I refactor
- And then I start thinking again what I want this code to do.

It is a development method that provides very well thought programs. And it provides a test suite. But if you tell me that the test suite cost more to maintain than the value we get through regression, I will gladly delete it. But I will add a new test again for the next feature that is being developed.

This is the development method that I prefer. How do other people do it? How do they go from zero to something? 

Most people I asked this question to doesn't know how they do it, they can't articulate it. But if you sit and observe what they do, you start to notice that they do have a method. Here are some methods that I've observed.

## Design Up Front Development

I once were in a team that made every piece of code in UML before they started writing it. There was an architect that would draft out sequence diagrams and hand over to the developers. The developers would then take a look at the sequence diagram and base their implementation on that.

There was no requirement that the sequence diagram had to be implemented exactly as specified in the UML to code. Most often the coder would find things the sequence diagram was missing and fill in the blanks. The sequence diagram was never treated as a source of truth. After the implementation it was pretty much thrown away.

The UML was just a way to think about the problem before putting it on paper, in code. Big Design Up Front has been so criticised in the industry for a long time, but this way of communicating the problem and the solution worked very well.

# Top Down Development

Developers that are very UI oriented tend to use expressive programming like HTML to implement the user interface first. After they have the inputs, the buttons, the navigation structure, they start working themselves down to the code that is going to provide the data. I call this top-down-development. You start from the UI and the interactions and you write code to satisfy it. Adobe Flash was the pinnacle of Top Down Development.

Solutions that are implemented top-down are always very user oriented, and they often run into trouble where they do not consider how the backing services expect data to be managed. You'll have beautifully implemented frontends that are slow, unmaintainable because of the lacking backends.

## Bottom Up Development

You tell a bottom-up developer to integrate the e-commerce solution with a payment provider. He will study the e-commerce interface in detail and he will map that exactly onto the payment provider so it fits in a beautiful way. However he will never along the way ask how it's supposed to be used.

This is when you get UIs that looks like a Google Form on top of a Microsoft Access database. All the fields are there and you can almost sense the database table structure from the way that input fields are positioned.

Combining a top-down developer with a bottom-up developer is of course a very good idea. A lot of interesting things will happen when they try to interface to one another.

## Code Fix Development

One of the most common way of developing software I see when I meet other developers is the code-fix development. They rarely realise they are practicing a development method but they do.

First they write up a draft of a program that they think will work. Then they run it. The program will most often crash, or not do what it was supposed to do, so they fix the problem and run it again. The program will fail on a different thing and they will fix it again. This will go on until they are satisfied with the result.

Depending on how much thinking is involved in this process, you will get different results. This is what managers mean when they say _good developers_ and _bad developers_.

I think we can agree that this way of developing software by trial and error is not a very good one, but it is incredibly common. There will always be issues left with the code that reaches production. I get the sense that the code is never quite _done_. There is always one more fix needed.

## Debug Driven Development

In .NET the debug tools has become so powerful that you can use them all the time, and it is very common for .NET developers to write code with the debugger. It works like this.

1. Write some code
2. Debug it and make sure it did what it was supposed to do
3. Rinse and repeat

This is a much more thorough development method than code-fix development, because you actually stop and analyse what your code does before you try to run it, but it is also a very slow process, and neither does it provide a step for thinking or refactoring your code.

The risk that the debug-driven developer run into is that they feel they need to refactor in the middle of debugging, so they start refactor the code before they've finished what they were doing. Feature changes and refactoring intermingles in an uncontrolled way, which is often obvious looking at the commit history.

I know many developers that write code this way and it works well for small solutions, but as soon as the code grows big it will have tons of technical debt because thinking is not a required step and neither is refactoring.

# Summary

These are the development methods that I've observed in the wild. What development methods do you practice or observed?

