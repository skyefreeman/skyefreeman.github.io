---
layout: post 
title: "" 
date: 2016-01-17 23:24:50 
author: Skye Freeman 
categories: 
---

Swift offer's some cool support for the use of emoji's through standard Unicode character's.  You can even write code using emoji characters!  While cool, it's rather impractical.  However, what if you wanted to use various emoji pictures within your projects?  That is, not within your code, but within some feature of your project?  You could lookup one of the many online resources finding the emoji in question, and copy paste the unicode character that it pertains to.  This is probably fine for all your emoji needs, but for fun I wanted to make it even easier.

As a Sunday hack, I built a small code generator that loops through every haxadecimal range of emoji's that I could find, packing them into a comprensive dictionary value.  Which is then written to a .swift file as a String extension after a little formatting, creating a full list of emoji's accessible through their descriptive name value.  Here's a little more on the nitty gritty of how I did it.


Each emoji chararacter that is represented by unicode has a descriptive name value.