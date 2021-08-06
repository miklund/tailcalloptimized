---
layout: post
title: "Cloud PC Development Environment - Windows365 Review"
description: "Moving that virtual machine for windows development to the cloud."
date: 2021-08-06 20:34:02
tags: development
assets: assets/posts/2021-08-06-cloud-pc-development-environment-windows365-review
image: assets/posts/2021-08-06-cloud-pc-development-environment-windows365-review/title.png

author:
  name: Mikael Lundin
  email: hello@mikaellundin.name
  web: http://mikaellundin.name
  twitter: mikaellundin
  github: miklund
  linkedin: miklund
---

I've been using virtual machines for development since 2012. It started as an experiment, but I kept at it because I could easily see the benefits.

1. I could isolate each customer in a separate virtual machine
2. I could install customer specific software, like VPN clients, without screwing up my host
3. I could easily archive a customer development environment and resume it later
4. I could experiment with the development environment and easily roll back to a snapshot taken before the experiment

The downside of working in virtual machines are

1. They are slow, especially the Windows ones
2. They take up a lot of harddrive space, and they need to stay on the SSD for speed
3. They also make the host OS slow as they consume a lot of resources when they run

I’ve been looking a while for remote development environments suitable for development, and I did experiment with coding over RDP during 2013-2014. It worked okay, but it wasn't a game changer.

Running remote Linux environments has been mainstream for quite some time, but getting it to work well with X has been quirky at best. I still prefer to have my development Linux as a local virtual machine.

## Windows365

In July Microsoft announced their Windows365, Cloud PC access on a subscription model like Office365. Their goal is to make it easy for enterprises to hand out a virtual machine sin the cloud to employees where you have the Office suite and Teams already installed.

I think it's a great idea, and it could really revolutionize remote working. But I’m not looking at it to write my e-mails. I want to use it for Visual Studio.

For this they have the following offering.

> 4 vCPU  
> 16 GB RAM  
> 128 GB Storage  
> **$66.00 user/month**

This is enough for running Visual Studio. If you want to, you can increase it with more cores, RAM and Storage, but it’ll soon get quite pricey. This was the machine configuration that I chose.

## Review

I’ve been using this cloud machine as my primary development environment for the entire week and I’m positively surprised.

It was very easy to setup to get started. It took only a couple of minutes before the machine was created, and I could connect with a RDP profile that I easily downloaded for Microsoft Remote Desktop.

With Windows365 you can also connect with iPhone, iPad or just a browser. I tried the browser option just to get the feel of it, but I really want to use multiple screens, so Microsoft Remote Desktop is the client for me.

The Cloud PC is very fast. Installing Visual Studio was a breeze and quicker than ever. I rarely feel that the environment is slow. It is much more performant than my local virtual machines ever been.

I was expecting input lag from working over the Internet, and I did notice it on Monday when the service was new and everyone was trying it out at the same time. Since then it has become much better and I honestly forget that the computer I’m working on is not here in front of me, but in a data center somewhere else. It's actually that good.

I work with docker containers, and I had problems of running docker inside virtual machines before, however this was not a problem at all in my Cloud PC. Running Docker in Ubuntu WSL2 on Windows works like a charm. And the Docker Desktop for Windows also seems to be working as expected.

What strikes me is that I don’t need to carry around a machine anymore. If I'd go into an office, I could just connect to my development environment from any crappy office computer there. That would never happen since I love my MacBook Pro M1 too much, but the idea of it feels very liberating.

## Downsides

It doesn’t replace all the functionality that I had with virtual machines. I can’t

- Take snapshots and roll back
- Archive an environment in order to return to it later

I actually have no idea how backups work, as I can’t see anything about it in the Windows365 control panel. What happens if I screw things up and want to roll back?

I would love the ability to just pause my Cloud PC and it would stop costing me money, but as it is now you need to remove the Windows365 license from your user which means that everything is gone and deleted.

There is a feature to reset your Cloud PC, but that would mean reinstalling all software and configure it from scratch. With local virtual machines I had the option of creating a template, that I’d use to quickly setup new machines. I could delete a development environment and setup a new one in 10 minutes.

These features are probably stuff that they will add later on.

My last complaint is about the price. I think the $66/month is a bit high and it means that I will remove my Cloud PC when I’m not using it. If you turn that coin, there is no large upfront cost like buying a physical PC, and the ability to cancel your subscription means that you can pick a higher end configuration and just cancel it those months you don’t need it, and still get a cheaper deal compared to buying a PC.

I will keep using my new Cloud PC. It really feels like the future to me. My MacBook Pro thanks me as well, as I haven't heard its fans for the whole week. :)
