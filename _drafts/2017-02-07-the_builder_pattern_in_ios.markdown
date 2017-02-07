---
layout: post 
title: "iOS: The Builder Pattern"
date: 2017-02-07 08:49:02 
author: Skye Freeman 
categories: Programming
---

Trimming down your controllers with builders.

Some of the most involved and repetetive code we write while building an application is the instantiation and setup of our objects.

If we are lucky, we simply set a variable to an initializer and move on.  Early in a development cycle this is common, however what do we do when our objects become gradually more complicated and fragmented?

Abstract away instantiation and setup behind a builder object.

For example, a common point of repetition in an iOS app is the instantiation of a UITableView.  While the initializer interface is simple, there are a slew of public variables that inevitably are required as our table view evolves over time. Data sources need to be set, delegates need to be adopted, cells need to be registered, all before we even worry about styling.  Easily just by setting up our table view we could be writing 10 + lines of code - that will eventually need to remain consistent in other parts of our app.

One solution to this problem could be subclassing - align all of our intracate variable setting behind a new object name.  While inheritance might be a solution, it tends to be a slippery slope, adding a whole layer of long term complexity to your application.

Introducing a "UITableViewBuilder" for this situation ensures each variation of table view is contained in a single place, while also making sure setup occurs in exactly the same way - every time. This minimizes duplication, enforces consistency, and leaves flexibility for the future.

What if we want to add a slight variation of UITableView to our application? Just add a new function within the builder object, leaving the original intact.

So, what are some signs a builder might be right for your situtation?

- An class has a large and obfuscated interface.
- An object is instantiated in pieces, multiple times, in various locations.
- There is a considerable amount of instantiation code around your controllers.
- A specific instance of an object needs a better name.

The beauty in builders is that they can be as flexible or as rigid as you want. They can lead to a tremendous reduction in repetition in your code base. 