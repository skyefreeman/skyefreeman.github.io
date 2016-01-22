---
layout: post 
title: "Strings, Emoji's and Generator's"
date: 2016-01-17 23:24:50 
author: Skye Freeman 
categories: 
---

A core feature of any programming languages is the ability to model and manipulate text.  When defining a variable that represents text, we traditionally call it a string. In Swift,  strings are a series of encoding-independant unicode characters.  This means that any character can be accessed directly by their unicode representation and vice-versa. For example, the hexadecimal unicode representation for the capital letter 'A' is '0x41', which can be accessed in a Swift string like so:

var unicodeLetterA = "\u{41}"
var regularLetterA = "A"

unicodeLetterA == regularLetterA 
// true

This same functionality extends to all unicode characters, including emoji's. You can even define variables in Swift using emoji characters! Not necessarily useful, but fun none the less. Now how does one find unicode emoji representations without looking them up manually?  Doing a few searches online, you can find that there are a couple of distinct ranges of unicode hex values that pertain to emoji characters.  This is what I came up with:

0x1F601 -- 0x1F64F
0x2702  -- 0x27B0
0x1F680 -- 0x1F6C0
0x1F600 -- 0x1F636
0x1F681 -- 0x1F6C5
0x1F30D -- 0x1F567

Armed with these values, I set out to build a code generator that spits out a Swift struct of all emoji characters retrievable by their corresponding name value. My goal was to be able to retrieve an emoji string like this:

Emoji.wearyCatFace

Before I could do this however, I first needed to build a way to parse all the emoji characters.