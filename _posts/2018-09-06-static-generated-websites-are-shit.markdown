---
layout: post
title: "Static Generated Websites are Shit"
description: Another blog post about rebooting my blog and how to deal with aging technologies.
date: 2018-09-06 05:34:35
tags: Jekyll, Docker, Cloudfare, Amazon S3, meta blog
assets: assets/posts/2018-09-06-static-generated-websites-are-shit
image: assets/posts/2018-09-06-static-generated-websites-are-shit/title.jpeg

author: 
    name: Mikael Lundin
    email: hello@mikaellundin.name 
    web: http://mikaellundin.name
    twitter: mikaellundin
    github: miklund
    linkedin: miklund
---

Maybe I missed a 'the' in the title, maybe I didn't.

My blog is old. It dates back to 2007 when I started it on Wordpress. One great thing about a blog platform like Wordpress is that even if the CMS platform will age and become harder and harder to update, the application will keep on working. You will still be able to update with content even if your PHP is 3 major versions behind.

I moved off Wordpress because the platform didn't feel secure. It kept nagging me about updates and it was hard to make changes the way I wanted to.

So I moved the whole thing over to Orchard CMS. That was a fun project because I was learning a new CMS and it was my first adventure on Azure. However it turned out that Azure was way too expensive for my small little blog, and Orchard CMS was a pain to keep updated.

My last move to Jekyll was great! Finally! No database, only markdown files. However similiar problems started to appear a year after the initial release. I had reinstalled my computer and didn't have the whole Jekyll setup. I found out the painful way that finding and installing old Jekyll dependencies was a real pain. It would take a whole day to setup an environment to start blogging, every time I would reinstall my system. So for long periods of time had no setup where I was able to update the blog.

It struck me that I need to script the setup. I don't want a blog virtual machine. I want to be able to write blog posts on both of my Macs, but I really don't want to install Ruby on any of them. So I concluded that I need to create a Docker container that have all the dependencies to generate my blog.

It did take a week, but here is my Dockerfile.

{% gist miklund/3d5511daecfefb1bbccd85430b5c39ba Dockerfile %}

All this crap are things that I would need to figure out every time I'd setup a new environment for my blog. Now I can just run the following command 

```
docker build -t miklund/tailcalloptimized:1.0 .
```

..and I have a complete environment for developing, writing and deploying. That is pretty neat.

## Cloudfare

Another thing that has happened during my absense is that Google's now punishing you in the search result for hosting over HTTP.

I'm all for security, but I have not prioritized hosting my static content over HTTPS because there is no real threat here. The only plausable thing I can see happening is that a router infected with malware could inject links/ads into my content. That might concern me if my blog had thousands of visits per month, or representing a legitimate business, but not really for my rants about javascript.

Anyway, being punished in the search result for hosting over HTTP does concern me, but at the time of setting up my static blog the only option was jumping through a lot of hoops at Amazon which would require an investment that wasn't worth it by a long shot.

Today [Cloudfare](https://www.cloudflare.com/) is offering a service for websites where they proxy your content and serve it over HTTPS. That is pretty great, and since I don't have any high requirements I get away with their free plan (but I would be willing to pay $5 for their service if they start charging).

## Google Analytics

When I created the Jekyll blog I added Google Analytics. Why do you add GA to a site? Well, to get some insight on how many users you have.

In the passing years Google has become more and more evil. They collect all information they can about every person on the internet in order to target advertisement and sell the information to the highest bidder. It is services like Google Analytics that allow them follow and collect everything you do around the internet. I don't want to be a part of that problem, so I'm removing Google Analytics from my site.

I'd rather be blind on my site's statistics, than intruding you my visitors' privacy.

To protect yourself on the internet, remember to

* Browse Twitter, Google, Facebook in incognito mode
* Regularly clear browser history/cache/cookies
* [Use a VPN](https://www.mullvad.net), always
* [Don't use Google Chrome](https://www.getfirefox.com)
* Search the internet with an [engine that doesn't track you](https://www.duckduckgo.com)

Cheers!
