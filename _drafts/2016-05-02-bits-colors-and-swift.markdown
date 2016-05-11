---
layout: post 
title: Bits, Colors and Swift
date: 2016-05-02 08:47:33 
author: Skye Freeman 
categories: Programming
---

While persusing Apple's Swift language guide, I came across an interesting section regarding bit manipulation. Unbeknownst to me, Swift sports the same bitwise and bit shifting operators used by both C and Objective-C. Here's a recap:

**AND**

The Bitwise AND {% highlight swift %}&{% endhighlight %} operator combines the bits of two numbers, maintaining the value of 1 for each bit ONLY if they are both 1.

{% highlight swift %}
let firstAND: UInt8 = 0b11110000
let secondAND: UInt8 = 0b00001111
let thirdAND: UInt8 = 0b00000001

let firstANDsecond = firstAND & secondAND // 0b00000000
let secondANDthird = secondAND & thirdAND // 0b00000001
{% endhighlight %}

**OR**

The Bitwise OR {% highlight swift %}|{% endhighlight %} operator combines the bits of two numbers, maintaining a value of 1 for each bit that is 1 in EITHER of the pertaining numbers.

{% highlight swift %}
let firstOR: UInt8 =  0b01010101
let secondOR: UInt8 = 0b10101010
let thirdOR: UInt8 = 0b00000001

let firstORsecond: UInt8 = firstOR | secondOR // 0b11111111
let secondORthird: UInt8 = secondOR | thirdOR // 0b10101011
{% endhighlight %}

**XOR**

The Bitwise XOR {% highlight swift %}^{% endhighlight %} operator (more simply - 'exclusive or') combines the bits of two numbers, maintaining a value of 1 for each bit ONLY if the value is different between each number.

{% highlight swift %}
let firstXOR = 0b00000011
let secondXOR = 0b00000001

let firstXORsecond = firstXOR ^ secondXOR // 0b00000010
{% endhighlight %}

**NOT**

The Bitwise NOT {% highlight swift %}~{% endhighlight %} operator 'flips' each bit of the input number.

{% highlight swift %}
let beforeNOT: UInt8 = 0b00000000
let afterNOT = ~beforeNOT // 0b11111111
{% endhighlight %}

**Left Shift**

The Bitwise Left Shift {% highlight swift %}<<{% endhighlight %} operator does exactly what the name infers - shifts all bits to the left. Using the operator requires specification to how many spaces the numbers bits should be 'shifted'. A 'left shift' essentially doubles the current integer amount. An important tidbit (bit humor?) is that Swift does not allow an operator to overflow by default, meaning if bits are shifted beyond integer bounds a crash will occur.

{% highlight swift %}

let leftShift: UInt8 = 0b00000001

leftShift << 1 // 0b00000010
leftShift << 2 // 0b00000100
leftShift << 3 // 0b00001000
leftShift << 8 // error

{% endhighlight %}

**Right Shift**

The Bitwise Right Shift {% highlight swift %}>>{% endhighlight %} operator is just like its left counterpart, except that the input bits are shifted to the right. An important difference however is that a right shifted number will be capped at zero (if shifted beyond its bounds, the result will default to 0).

{% highlight swift %}
let rightShift: UInt8 = 0b00010000

rightShift >> 1 // 0b00001000
rightShift >> 2 // 0b00000100
rightShift >> 3 // 0b00000010
rightShift >> 4 // 0b00000001
rightShift >> 5 // 0b00000000
{% endhighlight %}

**Hexadecimal and Colors**

While working with a designer it is not uncommon to receive a color value represented in hexadecimal rather than RGB decimal format. Rather than converting these values using one of the numerous [conversion tools on google][color-conversions], lets instead utilize what we've learned about bit manipulation to create our own handy UIColor extension which converts these values for us.

{% highlight swift %}
extension UIColor {
    convenience init(hex: UInt32) {
        let redComponent = CGFloat((hex & 0xFF0000) >> 16)
        let greenComponent = CGFloat((hex & 0x00FF00) >> 8)
        let blueComponent = CGFloat((hex & 0x0000FF))
        self.init(red: redComponent/255.0, green: greenComponent/255.0, blue: blueComponent/255.0, alpha: 1.0)
    }
}
{% endhighlight %}

Here's a quick rundown of how it works. The [hexadecimal number system][hexadecimal] uses 16 distinct symbols to represent the values 0 - 15 (0-9 and A-F respectively). Each hexadecimal digit consists of 8 bits (a byte), which allows the representation of any number from 0 - 255. Using this information, we can extract each red, green and blue value by isolating its corresponding bits. Starting from the left, we isolate the red component by ANDing our hex number with the maximum possible number of bits (FF). Next we shift our value for red to the right 16 bits to make sure it resides in the 0-255 bounds.  The same process is used for both green and blue, with the exception of the number of bits required in the right shift step (8 and 0 respectively).  Each component is casted to a CGFloat to ensure the proper type, then used to initialize a UIColor using each respective RGB value. We can then create UIColor's like this:

{% highlight swift %}
let skyBlue = UIColor(hex: 0x86CAFF)
let grassGreen = UIColor(hex: 0x87DD65)
{% endhighlight %}

Another worthy addition to the toolbox!

[color-conversions]: https://www.google.com/search?client=safari&rls=en&q=color+rbg+or+hex&ie=UTF-8&oe=UTF-8#q=hex+to+rgb+converter
[hexadecimal]: https://en.wikipedia.org/wiki/Hexadecimal