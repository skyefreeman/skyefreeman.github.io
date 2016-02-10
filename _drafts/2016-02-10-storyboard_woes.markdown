---
layout: post
title: Storyboard Woes
date: 2016-02-10 15:51:04
author: Skye Freeman
categories: Programming
---

  Since their introduction, Storyboards have been a hot topic in the iOS community. Some people love them, some don't.  I've gone through stints Storyboard use, but generally have          come to avoid them.

  When starting a new project you get a Storyboard by default, a new View Controller is set up and ready to go. Before you know it you've laid out a UI with little to no code. Next, you change gears and build out the functionality of your app. All is well until one day you need to customize the UI. More advanced customizations like corner rounding, gradients, layer manipulations are generally easier to perform through code.  Great, so naturally you create a subclassed view object that handles this. Now you have aspects of your view layer split across files.

  This trend inevitably continues until your view layer is laid out using the Storyboard, and styled through code.  Once a project reaches a certain size, most of the benefits of using storyboards tend to diminish by an order of magnitude.  Fixing broken constraints becomes a nightmare.  Version control becomes a hassle.  XCode slows down to a crawl.  Fixing anything requires a mouse.  It's all just too slow for me.

  I generally despise any mouse usage in my developer workflow.  Working with text is just infinitely far more pleasant in my opinion.  Changing a piece of coded functionality is as simple as searching and replacing.  If I wanted to change an objects property defined in a Storyboard, I'm going to have to search through a pile of cruft that's accumulated through the course of a project...with a mouse.

  Laying out a view in a nib or Storyboard gets rid of a ton of boilerplate NSLayoutConstraint code.  But even this benefit goes out the window as soon as you need to debug a constraint that breaks at run time.  On many occasions I've thrown in the towel and just ended up re-laying out the whole view.  It's times like this that I wish I'd just laid out the view programmatically from the start.

  Now, I've started making great use of libraries like Masonry or SnapKit (depending on if I'm writing Objective-C or Swift) to greatly reduce the burden of writing layout code. The initial investment in time tends to pay off tremendously over the course of a projects evolution. It's easier to debug.  I can reuse layouts. I can keep my fingers on my keyboard.  While its not feasible to say I'll never use a Storyboard again, I'll probably just reserve is as a tool for prototyping.
