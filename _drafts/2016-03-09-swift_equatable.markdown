---
layout: post 
title: Swift: Equatable
date: 2016-03-09 21:37:40 
author: Skye Freeman 
categories: Programming
---

Operators in Swift are just functions with special names. They generally inherate from mathamatical notation so that their use is logically obvious.  For example, the '==' operator tests equality between two types.

{% highlight swift %}
let a = 10
let b = 10
let c = 2

a == b // true
a == c // false
{% endhighlight %}

Let me revise my previous definition of '=='. It more specifically tests equality to two types that conform to the 'Equatable' protocol.  In the example above we define 3 constants of type Int, which conforms to Equatable.  Some other Equatable conforming types defined in Swifts standard library are Float's, Double's and String's [(There are many, many more)][equatable-link].

Let's see what would happen were we to check equality between two instances of a custom defined type.

{% highlight swift %}
struct Cat {
    let name: String
    let breed: String
}

let rex = Cat(name: "Rex", breed: "American Wirehair")
let belle = Cat(name: "Belle", breed: "American Shorthair")

rex == belle // error
{% endhighlight %}

This snippet doesn't even compile.  This is because our custom Car struct hasn't told the compiler how two instances should be tested for equality.  Let's make Cat conform to the Equatable protocal.

{% highlight swift %}
struct Cat {
    let name: String
    let breed: String
}

func ==(firstCat: Cat, secondCat: Cat) -> Bool {
    return (firstCat.name == secondCat.name) && (firstCat.breed == secondCat.breed)
}
{% endhighlight %}

We now define the rule for '==' between two Cat's to return true only if both the name and breed of the both Cat instances are the same.  Let's test '==' on our two cats one more time.

{% highlight swift %}
let rex = Cat(name: "Rex", breed: "American Wirehair")
let new_rex = Cat(name: "Rex", breed: "American Wirehair")
let belle = Cat(name: "Belle", breed: "American Shorthair")

rex == belle // false
rex == new_rex // true
{% endhighlight %}

Adopting the Equatable protocol on your custom types and objects is a great way to make your code more readable and intuitive.  Don't abuse it though, the rule defined for a Equatable conforming type needs to make sense.  For instance, it's very possible that two different cats have the same name and breed.  Our definition of '==' would then be ambiguous under more complicated use cases.  It's important to make sure that two types compare logically to avoid confusion during a projects evolution.

[equatable-link]: https://developer.apple.com/library/tvos/documentation/Swift/Reference/Swift_Equatable_Protocol/index.html#//apple_ref/swift/intf/s:PSs9Equatable