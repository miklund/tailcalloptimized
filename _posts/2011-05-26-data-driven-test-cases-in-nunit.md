---
layout: post
title: "Data driven test cases in NUnit"
description: How to use an external data source to feed your unit tests with test data.
tags: unit testing, nunit, test data
date: 2011-05-26 05:12:41
assets: assets/posts/2011-05-26-data-driven-test-cases-in-nunit
image: 
author:
    name: Mikael Lundin
    email: hello@mikaellundin.name
    web: http://mikaellundin.name
    twitter: mikaellundin
    github: miklund
    linkedin: miklund
---

When you want to create thousands of test cases you don't use the [TestCase] attribute in NUnit. :) But did you know that there is a "TestCaseSource" attribute that specifies a method that will generate test case data? Look at this.

{% gist miklund/5d94934a6b7b1b83c0fd ShouldLogin.cs %}

It is an integration test that will try to login a massive amount of users. This is the kind of test where you take a huge diversity of data and try to find out if there is anything that will make it break.  But  where does the data come from? The magic string "MassiveAmountOfUsers" holds the answer.

{% gist miklund/5d94934a6b7b1b83c0fd GetMassiveAmountOfUsers.cs %}

Test cases will be generated by the framework calling the property MassiveAmountOfUsers. This should return an IEnumerable of an array of arguments. We create that array of arguments by reading an XML file. To enable using different types, string and bools, as arguments we create an untyped array of objects. As long as we put strongly typed members into the array, we can use strong types in the test function.  What the xml looks like, is unimportant, but in my test case like this.

{% gist miklund/5d94934a6b7b1b83c0fd Users.xml %}

You could get the test data from anywhere, the database if you want to. Testing your code with an massive amount of real data, really gives you confidence with your code.  Running this in the NUnit test runner looks pretty much like any [TestCase] suite, but the test cases are generated when the test assembly is loaded.

![nunit gui](http://litemedia.info/media/Default/Mint/nunit-gui.png "Running data driven tests in NUnit gui")