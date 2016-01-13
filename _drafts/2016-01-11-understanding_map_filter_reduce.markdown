---
layout: post 
title: "Understanding Swift's SequenceType" 
date: 2016-01-11 23:36:38 
author: Skye Freeman 
categories: Programming
---

One of the great features of Swift's collection implementation is the first party support of various "higher order" functions like map, filter and reduce.  When Objective-C still reigned supreme, the iOS open-source community created there own abstractions in an attempt to make Objective-C more functional.  While the community did a wonderful job of making a verbose language more terse, it never really felt like the Objective-C was meant for it.  This time around however, Swift gives us built in support through the SequenceType protocol.  The Swift Developer Library defines SequenceType as being any 'type that can be iterated with a for...in loop.'  This means that any collection that can be iterated over (i.e. Array, Set) can adopt the SequenceType protocol, gaining access to its useful instance methods.  You can even adopt SequenceType within your own custom collections!

The SequenceType protocol aims to solve a number of common problems in a functional and expressive way, making your code more readable and succinct. Here's a rundown of what SequenceType has to offer:

Say we start with a standard Swift array like so.

{% highlight swift %}
var numbers = [10,2,60,100]
// [10,2,60,100]
{% endhighlight %}

After passing this collection around our app, we need to manipulate it by adding a '$' sign before each number.  Easy, let's use Map.

{% highlight swift %}
numbers.map({"$\($0)"})  
{% endhighlight %}

What's happening here is that the 'numbers' array is iterated on from index 0..3 , appending each number into a string along with a '$' sign.  The '$0' is shorthand in Swift for the first argument to this closure.  Let's contrast this to what it would look like without map.

{% highlight swift %}
var money = [String]()
for number in numbers {
    money.append("$\(number)")
}
{% endhighlight %}

Way more verbose.  While this is still very understandable and standard code, I don't like the thought process of it.  This naive approach I tend to read as "Initialize an array called money that accepts String types, then iterate over each number in the numbers array appending a string that concatenates $ and number". Bleh.  The Map version on the other hand can be read "for each number in numbers, map $ and number to a string".

Our goal while programming should always be to write code that is easily understood. The Map function lets us easily do this by clearly conveying intent, while still remaining as succinct as possible. Lets take a look at the other instance methods of SequenceType.

Need to "filter" your array by a comparator?  Use Filter.

{% highlight swift %}
numbers.filter({$0 > 10})
// [60, 100]
{% endhighlight %}

What about "reducing" each number in my array to a single sum?  Go use Reduce.

{% highlight swift %}
numbers.reduce(0, combine: {$0 + $1})
// 172 (ie. 10 + 2 + 60 + 100)
{% endhighlight %}

This can even be further "reduced" since operators are also methods in Swift.

{% highlight swift %}
numbers.reduce(0, combine: +)
// 172 (ie. 10 + 2 + 60 + 100)
{% endhighlight %}

Lets drop the first number in numbers

{% highlight swift %}
numbers.dropFirst()
// [2, 60, 100]
{% endhighlight %}

Wooops, I meant the last.

{% highlight swift %}
numbers.dropLast()
// [10, 2, 60]
{% endhighlight %}

Nevermind, the first two actually

{% highlight swift %}
numbers.dropFirst(2)
// [60, 100]
{% endhighlight %}

Can we check if the number two exists in the array? Sure.

{% highlight swift %}
numbers.contains(2)
// true
{% endhighlight %}

What about 10000?

{% highlight swift %}
numbers.contains(10000)
// false
{% endhighlight %}

Darn, lets check to see if this other array matches our good old number array.

{% highlight swift %}
numbers.elementsEqual([10,2, 60, 100])
// true
{% endhighlight %}

Woo! What about this array?

{% highlight swift %}
numbers.elementsEqual([10])
// false
{% endhighlight %}

Shucks. Can we "join" all of our numbers together into one String?  Sure, but only if they are Strings in the first place.

{% highlight swift %}
let numberStrings = numbers.map({"\($0)"})
numberStrings.joinWithSeparator(" | ")
// "10 | 2 | 60 | 100"
{% endhighlight %}

You know what, lets just print all of our numbers out, since SequenceType functions don't overwrite our mutable data.

{% highlight swift %}
numbers.enumerate()
// Outputs:
// 0 : 10
// 1 : 2
// 2 : 60
// 3 : 100
{% endhighlight %}

[junganewlink]: http://junganew.com