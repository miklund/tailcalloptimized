---
layout: post
title: "Create a redirection site using Amazon S3"
description: How I utilize Amazon S3 to create a redirection site that is cheaper than using the old website on Azure.
date: 2016-01-24 12:48:11
tags: s3, bucket, blogging
assets: assets/posts/2016-01-24-create-a-redirection-site-using-amazon-s3
image: assets/posts/2016-01-24-create-a-redirection-site-using-amazon-s3/title.png

author: 
    name: Mikael Lundin
    email: hello@mikaellundin.name 
    web: http://mikaellundin.name
    twitter: mikaellundin
    github: miklund
    linkedin: miklund
---

Previously I chose to move all my posts from my old blog at litemedia.info to this blog, and shutdown that site. It was mainly because that site was malfunctioning and I wanted to make the content more accessible on mobile.

After I migrated every blog post, I created the following Web.config in order to redirect all the old URLs to the new domain.

{% gist rubriks/a6cad6dc74f36c339a8c Web.config.xml %}

This works great, the Azure website is redirecting all the old URLs to their target URLs in the new website. However I'm now paying $10 a month for a bunch of HTTP 301, and that doesn't really seem worth it. After doing some thinking I made the conclusion that there are much easier solutions for doing 301 redirects rather than using a Web.config in an Azure website.

## S3 bucket

You can host a website from an S3 bucket and it is just a fraction of the cost of an Azure website. By serving content with the HTTP header `x-amz-website-redirect-location` you can individually redirect each old URL to a new URL[^1].

![redirection can also be done from the bucket configuration](/assets/posts/2016-01-24-create-a-redirection-site-using-amazon-s3/redirect.png)

Create a new bucket in Amazon S3 and name it exactly like your domain you want to redirect from. Make sure that you set both index and error in the website settings. By redirecting the error page to the new domain, you will be able to have a _catch all_ scenario where all URLs you have not redirected individually will end up at the root of the new webpage.

![when you setup the static website do not use specify redirection at this point](/assets/posts/2016-01-24-create-a-redirection-site-using-amazon-s3/website_configuration.png)

You can choose to redirect the whole website at this point, but I would like to customize redirection for individual URLs and redirecting all requests to a target URL is not what I intend to do.

## Setup redirection

Instead I want to create a file for each old URL and upload that file with the HTTP header that redirects to the new URL that I specify. I will do this by using the [AWS Command Line Interface](https://aws.amazon.com/cli/).

```bash
touch asserting-with-exceptions
aws s3 cp asserting-with-exceptions s3://litemedia.info/ --website-redirect //blog.mikaellundin.name/2009/04/21/asserting-with-exceptions.html
```

First I create an empty file called `asserting-with-exceptions` which was the URL for this post on my previous site. Then I upload this file with the HTTP header to redirect to the new URL. Luckily I had a quite flat URL hierarchy at litemedia.info.

After making this file public, I can test it by browsing to the bucket URL [http://litemedia.info.s3-website-eu-west-1.amazonaws.com/asserting-with-exceptions](http://litemedia.info.s3-website-eu-west-1.amazonaws.com/asserting-with-exceptions) and verify that I get redirected to [http://blog.mikaellundin.name/2009/04/21/asserting-with-exceptions.html](http://blog.mikaellundin.name/2009/04/21/asserting-with-exceptions.html).

I don't want to do this manually to all 250 URLs so what I did was transform the XML with the URLs that I had, using the following XSL.

{% gist rubriks/a6cad6dc74f36c339a8c transform.xsl %}

And with some minor adjustments turned the data with the URLs into a runnable script.

{% gist rubriks/a6cad6dc74f36c339a8c upload.sh %}

What is interesting here is that I choose to redirect also index and error, meaning I will catch the root address `http://litemedia.info` and also any unknown URL with error.

## Move the domain to Amazon Route 53

After you've verified that the redirection is working with the bucket url[^2] you're ready to point the domain to that bucket. If the domain is a subdomain then you can just [create a CNAME record to the bucket](http://docs.aws.amazon.com/AmazonS3/latest/dev/VirtualHosting.html#VirtualHostingCustomURLs) and it will work all magically.

In my case I wanted to point the whole litemedia.info to the newly created S3 bucket, and that is not possible using a CNAME. Instead we need to use an Amazon service called [Route 53](https://console.aws.amazon.com/route53/)[^3].

![create a hosted zone for your domain](/assets/posts/2016-01-24-create-a-redirection-site-using-amazon-s3/hostedzone.png)

In this zone you shall create an alias that will point to your bucket.

![create an alias that will point at your bucket](/assets/posts/2016-01-24-create-a-redirection-site-using-amazon-s3/hostedzonealias.png)

Now Amazon Route 53 knows that requests coming to litemedia.info should be routed to the bucket. In the last step we need to tell our domain registrar to use the Amazon nameservers.

![find the nameservers by inspecting the hosted zone](/assets/posts/2016-01-24-create-a-redirection-site-using-amazon-s3/hostedzonenameservers.png)

You find the nameservers by inspecting the hosted zone that you've created.

I have this domain registered with a registrar called [Binero](http://www.binero.se) and they allow me to change nameservers from their own to Amazon by a form.

![I can use the form at my registrar to update nameservers](/assets/posts/2016-01-24-create-a-redirection-site-using-amazon-s3/binero.png)

And after 24 hours the change had gone through and I would get the Amazon nameserver when querying with nslookup.

![nslookup returns Amazon as authorative nameserver](/assets/posts/2016-01-24-create-a-redirection-site-using-amazon-s3/nslookup.png)

When testing it I can now see that every URL on litemedia.info is redirecting to the corresponding URL on blog.mikaellundin.name.

_Mission Accomplished!_

---
**Footnotes**

[^1]: You can also setup redirect rules if your redirects follow a specific format. This is not applicable in my case, but if it works for you, [please see the following url for more info](https://docs.aws.amazon.com/AmazonS3/latest/dev/HowDoIWebsiteConfiguration.html)

[^2]: My bucket URL is http://litemedia.info.s3-website-eu-west-1.amazonaws.com

[^3]: I found [this guide](http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/MigratingDNS.html) to be immensly helpful for setting up Amazon Route 53.
