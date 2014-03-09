shadow-generator
================

Shadow generator for your *.png* pictures. Useful utility for 2D games developers.

### What does it do with my picture?

1. Gets your picture by drag'n'drop.
2. Turns your picture to monochrome.
3. Applies blur to the result.
4. Saves this pretty cool shadow.

### Where can I found the result?

The resulting shadows are placed near the original images with **shadow** suffix in filename.

### What's special with filename?

If original filename includes **@2x** then **shadow** suffix will be added right before *@2x*.
Additionaly you can double blur radius for that pictures simply checking checkbox.

For *hero@2x.png* the result filename is *hero-shadow@2x.png*

If original filename includes **~** then **shadow** suffix will be added right before **~**.

For *hero~ipad.png* the result filename is *hero-shadow~ipad.png*. But for *hero@2x~ipad.png* the result filename is *hero-shadow@2x~ipad.png*

### Why don't generate shadows at runtime?

You definitely should try this. You can use code from [ShadowGenerator](https://github.com/win2l/shadow-generator/blob/master/ShadowGenerator/ShadowGenerator.m) class to turn the resulting **CGImageRef** to representation you need with very little changes. The transformation code should work on both iOS and OS X. 
