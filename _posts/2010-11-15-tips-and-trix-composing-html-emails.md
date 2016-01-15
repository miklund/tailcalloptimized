---
layout: post
title: "Tips and trix composing HTML emails"
description: Composing HTML e-mails is not as easy as it sounds like. You need to go back 20 years in HTML development and design with HTML3 and table layouts. Here are some tips and tricks.
tags: HTML e-mail, HTML3, table layout
date: 2010-11-15 20:58:20
assets: assets/posts/2010-11-15-tips-and-trix-composing-html-emails
image: 
---

So you need to create an HTML e-mail and you don't want it to be caught in every spam filter of the web. You also would like if it looked almost the same in different readers. Here's some stuff I've learned.

## Reverse PTR Record

If you want people getting your e-mail you should really consider [Reverse PTR Record](http://aplawrence.com/Blog/B961.html). This is set up by your ISP and will confirm that e-mail that you send actually belongs to the domain it was originated from.

## HTML 3.2

What happened in Outlook 2000 was that Microsoft decided to use Word for rendering HTML e-mails. No, I'm not kidding. This is still the case, and that's why we have to write HTML 3.2 for our e-mails, with table layout and no styles. _Don't end your `<BR>` tags._

## No background images

Background images is a big no-no in most HTML e-mail clients and that is why you should avoid them at any cost. Try to exchange any background images with an `<IMG>` tag and use background colors to make up for missing image elements.

## Use plain text fallback

When sending HTML e-mails you should send both HTML part and plain text. This will make it easier to pass through spam filters and it will give primitive HTML clients some clue of what you're selling.

## Test test test

Some e-mail clients will center your table text by default. Some will not display that image. Others will make everything look like crap. You have to test with different e-mail readers and the cheapest way is to invest in a tool like [http://litmus.com/](http://litmus.com/)
