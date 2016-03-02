Shadow Generator
================

Shadow generator for your **.png** pictures. The utility was created to acheive the parallax effect, but you can use it whatever you would like to.

![Parallax](http://i64.tinypic.com/2uizyg1.gif "Parallax")

### What does it exactly do with my picture?

![Process](http://i63.tinypic.com/35lcjuq.png "Process")

1. Gets your picture by drag'n'drop.
2. Turns your picture to monochrome.
3. Applies blur to the result.
4. Saves this pretty cool shadow.

### Where can I found the result?

The resulting shadows are placed near the original images with **shadow** suffix in filename.

### What's special about filename?

Application is pretty intelligent with detecting picture's target device by its [filename](http://stackoverflow.com/a/19475728/1322703).
So you can generate shadows for your original pictures and put them together to your app bundle.
When you need to load your picture and shadow, you should look your app bundle for **picture** and **picture-shadow**. Automatic blur radius doubling provides equal results for retina and non-retina images.

#### How does it exactly work?

If the original filename includes **@2x** then **shadow** suffix will be added right before **@2x**.
Additionaly you can double blur radius for that pictures simply checking checkbox.

For **hero@2x<span></span>.png** the result filename is **hero-shadow@2x<span></span>.png**

If the original filename includes **~** then **shadow** suffix will be added right before **~**.

For **hero~ipad.png** the result filename is **hero-shadow~ipad.png**. But for **hero@2x~ipad.png** the result filename is **hero-shadow@2x~ipad.png**

In other cases **shadow** suffix will be appended to the filename.

For **hero.png** the result filename is **hero-shadow.png**


### Why don't generate shadows at runtime?

You definitely should try this. You can use code from [ShadowGenerator](https://github.com/win2l/shadow-generator/blob/master/ShadowGenerator/ShadowGenerator.m) class to turn the resulting **CGImageRef** to representation you need with very little changes. The transformation code should work on both iOS and OS X. 
