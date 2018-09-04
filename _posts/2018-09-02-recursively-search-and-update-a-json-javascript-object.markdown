---
layout: post
title: "Recursively Search and Update a JSON/JavaScript Object"
description: How to use javascript to read an object and update it recursively.
date: 2018-09-02 12:15:32
tags: node, json, inRiver
assets: assets/posts/2018-09-02-recursively-search-and-update-a-json-javascript-object
image: 

author: 
    name: Mikael Lundin
    email: hello@mikaellundin.name 
    web: http://mikaellundin.name
    twitter: mikaellundin
    github: miklund
    linkedin: miklund
---

Hello my blog. Sorry I haven't updated you in a while, but I've been busy. However it seems like I have a reason to start writing again, so here we go.

The other day I came across the following problem.

> I have a JSON export of a data schema from inRiver, and I have a CSV file with translations for each property in inRiver. The only thing I need to do is to update the JSON export with the values from the CSV file.

Easy! Or not so easy. I quickly figured out that C# was not the language for this task. I would be better off using a dynamic language like javascript.

The gist here is not about reading or parsing CSV or JSON, but rather how to search and update a big javascript object. If it were XML, [I would just have used XSLT](/2008/12/15/xml-future-of-the-past.html) and be done in a snap.

Let's look at the end result.

{% gist miklund/4def343a5938c13c9af4d7bb353857c0 update.js %}

This code will recurse through an object graph, looking for an object with matching ID property. If it finds it, it will run the update function on that object.

The important thing to notice in this code is that javascript is always copy by value. We cannot just recurse down to the part we want to change and update it, because then we would update a copy of the object. Instead we need to make sure that we write back each recursion to the object graph to get the change in the end.

This is how we use it!

{% gist miklund/4def343a5938c13c9af4d7bb353857c0 usage.js %}

Happy Coding!