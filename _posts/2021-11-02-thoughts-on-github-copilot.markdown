---
layout: post
title: "Thoughts on Github Copilot"
description: "A preview on Github Copilot and the workflow of tomorrow."
date: 2021-11-02 07:34:02
tags: development
assets: assets/posts/2021-11-02-thoughts-on-github-copilot
image: assets/posts/2021-11-02-thoughts-on-github-copilot/title.png

author:
  name: Mikael Lundin
  email: hello@mikaellundin.name
  web: http://mikaellundin.name
  twitter: mikaellundin
  github: miklund
  linkedin: miklund
---

Github Copilot is a new service from Github that is currently in preview, and I’ve had the opportunity to take it for a spin. This service integrates with your IDE, helping you to write code by giving suggestions. It does this with the use of AI, which gives context sensitive, and very accurate results.

Go here and read about it to learn more.

## My Experience

I was writing some elaborate text transformation logic and decided to try out Copilot. The quality of the suggestions were good enough that I didn’t had to write much code at all. I wrote some function signatures and could tab myself through the development. What I was expecting to take several evenings of coding, was done in 30 minutes. The productivity boost was enormous.

In short what happened during this time

- My workflow changed from writing code to directing Copilot to write the correct code for me
- The generated code took advantage of the code I already written
- There was very little need for adjustments or fixing the code that was generated
- The generated code was working as expected on the first run
- I didn’t spend time unit testing, discovering my solution, because it was generated code

## The Implications

I’m thinking about what will happen if this way of programming becomes the norm.

- Productivity will sky rocket. Every developer will produce much more code.
- Instead of writing code, workflow will focus around generating the code that you want
- There is no need to understand the code you generate as long as it works
- Systems will become less maintainable, focus will shift to rewrite since its cheaper
- Manually writing code, will be considered as writing assembly without a compiler today

The big paradigm    shift will be that system developers will drive the code generation to do what they want, instead of writing all the code as we do today.

What do you think?
