---
layout: post
title: "Micro services, a developer's choice"
description: 
date: 2016-06-07 19:46:10
tags: 
assets: assets/posts/2016-06-07-micro-services-a-developers-choice
image: assets/posts/2016-06-07-micro-services-a-developers-choice/title.jpg

author: 
    name: Mikael Lundin
    email: hello@mikaellundin.name 
    web: http://mikaellundin.name
    twitter: mikaellundin
    github: miklund
    linkedin: miklund
---

_We only hear the benefits of micro services, but we never hear about the downsides. How is it that there is none contradicting developers lamantations that this is the silver bullet?

Here is a little long elaboration on developers have removed all reasonable doubt._

## The death of a DBA

Remember back about 10 years ago and think about how the IT landscape has changed. Remember when it was the business running IT and not IT running the business? Ok, that might be a slight overstatement, but back then IT was seen as a function that would deliver value to the business, and today IT is very much in the heart of most businesses.

If we go even further back, when business was running IT we had a different set of roles in the IT department. To the business the most important thing in IT was their data, and in order to protect and curate that data we had a DBA. The DBA was responsible for the business' data, to make sure it was backed up securely, to make sure its integrity would hold, making sure not to mix data that shouldn't be related  or the company could get some angry
men in black suits from the government knocking.

The DBA was also responsible for controlling access to that data, and this is where our story about the dying DBA starts. Because developers has during all time feared the DBA, the person that was controlling the most sacred thing of the business.

If you as a developer needed to access data, you would go to the DBA and say _'pretty please could I have some data'_ and the DBA would after careful consideration write a stored procedure, or a view, where that data could be accessed but still under total control of the DBA. It was a tiny window where you as a developer could access a piece of the database under strict surveillance.

---

I once had a DBA rush into the room where I was sitting, shouting _you did not just query the whole table!? are you insane?_. My access to the database was revoked and I was handed a view with only the dataset that I "needed".

---

No developer was ever happy with this setup because accessing data in a database could become a really hurtful process. It would take time and it would delay projects. _'What if we could read and write directly to the tables?'_, god forbid!

About 10 years ago something huge happened. The Internet had been around for a while, but 10 years ago businesses found out how they could make money by selling their products and services online. Before then the customers hadn't been ready, but now the online commerce exploded, and this changed the way IT operated in most organizations. Instead of being a function to the business, IT became a core part of the business, and with it developers were given a higher mandate.

Developers were put in high positions in the organisation and they slowly deprecated the old DBA role, because from their point of view the DBA was a disturbance to the future of IT. In order to use your fancy ORM frameworks, developers needed direct access to databases and with this the DBA could start looking for a new job.

The effect of this might have been in some cases that projects could be delivered more smoothly, but it also had a much worse effect. There was no longer a role that would protect the data, that would curate the data and be the expert on how the data should be handled. Developers have no interest in databases. All they want is to select and insert data, and this resulted in lots of suboptimized solutions because developers was not interesting in taking over tasks the DBA's previously
had owned, like indexing the database tables.

Today you only find DBAs in highly data centric enterprise organisations, but they are a dying brand. Only because developers came into power and thought DBAs to be dinosaurs. It makes me sad that so much knowledge and competence has been lost.

## Death of operations

As time goes by developers are taking over the IT department. If you hire a DBA guy, he should also be able to write code. You don't hire a manger without a developer background. Even the web master is assumed to know the ins and outs of HTML.

About couple of years ago there was a significant change in how developers percieve their work in contrary to the work of hosting. Traditionally the development department and IT operations have been two separate things. Developers create code packages that are delivered to IT operations who install these packages on the production servers with the attached instructions. This is very beneficial as developers can blame IT operations when things go wrong, and IT operations can blame
developers.

_And then there was a disturbance in the force._

As developers were taking over, they percived this new threat to their project deadlines. The threat of IT operations not being able to create magic on the servers fast enough. The threat of juggling code packages back and forth and having application reponsibility hinder the ability to debug code on live production servers.

This threat, the threat to project deadlines, was again made the highest priority of the business. When IT becomes business, as with e-commerce, the goal of the business becomes IT. If the developers in the development department says that operations got to go, then operations is in very bad trouble.

It started out with a small term called _continuous deployment_ which means that the development pipeline of checking in code to a code repository, also extends to the production environment. Any developer can with automization deliver code into production. The key selling point is agility, and being able to get code live fast. This is of course very compelling to the business as they always worry about getting features live fast enough.

Let's call it DevOps, the merger between development and operations where developers and operations can gather around common processes, workflows and tools. So IT operations are quickly reduced to only caring for the servers, and not for the applications running on the servers. They lose application responsibility. Not that developers are interested in having application responsibility, they only want to remove operations from their deployment pipeline in order to
speed up things.

The next big punch from developers to the IT operations is _cloud_, and developers have the perfect elevator pitch that the business will want to hear.

> Cloud will let you **save money** by only pay for hosting of the services you require. You can **scale up on capacity** when interest of our services is high, and **scale down on cost** when interest is low.

We no longer need an IT operations department that manage servers. Another big cost saver, is that we can scale down on the number of employees. Software will be installed as a service, and servers will be managed in the cloud. It will not be mentioned that virtual machines are going to need the same kind maintenance the physical had, but mission is accomplished. IT operations is no longer needed in the organization. 

There are still battles on the front lines, where the latest weapon is called Amazon Lambda. Developers send code to an automated system that will setup a service and make it immediatly available. It is what developers call a serverless infrastructure.

> There is no cloud, just someone elses machine.

## Developers in the house

It doesn't stop there. Developers have been undermining testers the last decade by claiming they can automate the testing procedure. To the business this sounds like one less mouth to feed, but they don't realize they're missing out on some really important functions of a product team. Developers see testers as another annoyance hindering their code to reach production and the project its deadline. 

There have been tries to remove the project manager from the projects by proposing agile and foremost self managing teams. Any team member can become a scrum master, and in that case the need of a project manager is mute. This is explained to the business that lots of hours could be put into development instead, but from where I've looked the businesses has yet to fall for this. They still want a plan, a budget and price of what they buy. How would they otherwise
calculate return of investment and figure out if the investment is worth doing?

## Micro services, what are they good for?

Developers have become major decision makers in our organizations. As other roles have been pushed out, more developers have been coming in to taking over. With this we finally reach the topic of this blog post.

**Micro services is a developer's utopia, and it goes like this**

* Every business function is divided into a service, and developers love services, because services is the core of the development domain.

* Every service has its own data store. The need for bringing up and tearing down databases by automations is a must have.

* Every service should be contained. Either by using containers on a larger server, or by utilizing cloud SaaS solutions.

* Experimentation should be a defining factor, where you can bring up and tear down experiments within the domain, and measure the result rather than testing it up front.

What most developers really love about this is the way each service will provide a small secluded world where everything is simple. Each service will have high cohesion, meaning it will do one thing and do it well. It will have low coupling by providing a well defined API to other services.

**How are micro services sold to the business?**

* It come's will built in scalability, you can place a copy of each service on different hardware

* Each service is simple and easy to manage

* It enables diversity in the system landscape by allowing many different techniques for each service

* It come's with fault tolerance, when a service is failing a copy of that service can handle the requests

* It enables experimentation, where you can deploy experiments and measure the result

**And what are the problems that none is talking about?**

* A service oriented solution is very very slow. A network call to a service is about the slowest I/O operation you can make

* A service oriented solution is very complex, as every added service increases the complexity exponetially

* Service versioning is hard. Finding a common protocol for you services is harder. Monitoring and debugging is very very hard. Troubleshooting and finding out what went wrong can be near impossible

* Automation is the key to managing development and deployment of a service oriented system. Managing that automation is a lot of work

* Enabling a service to be duplicated without any side effects requires a lot of considerations

* Developing different services with different techniques/languages will be costly and even further increase complexity. You will need to manage your knowledgebase of all techniques and languages used

I am a developer. I am very intrigued by micro services architecture, but I am also aware of what kind of investment it would require to pull it off. I'm not so sure that investment will be returned.

## But then, why micro services?

Best guess it's just that, a nice separation of concerns. Developers see the good parts and turn a blind eye for the bad parts thinking, _I can fix that_. The small picture looks good for any developer, and you're not around long enough to feel the pains of the big picture.

On a more grander scale, there is an essential shift happening here. The complexity between services hides the business domain that only developers are capable enough to understand, to measure and to change. Having that kind of complexity gives you power, and it gives the development department power within the organisation. This is what happens because

* Only developers have the data on what's going on

* Only developers are able to run the experiments and measure output

* Developers have a mandate to tell if a feature is elegible or too expensive for development

This slowly but surely pulls some business decisions into the hands of developers and it forces every business analyst to be a developer if he wants to be on game.

_Another advance on the front lines, to make sure that none will go without code, and the developers will end up in total control._
