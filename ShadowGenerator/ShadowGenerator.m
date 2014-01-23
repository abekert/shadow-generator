#import "ShadowGenerator.h"

@implementation ShadowGenerator

+ (void)shadowImageFromURL:(NSURL *)url toURL:(NSURL *)outputUrl withBlurRadius:(CGFloat)blurRadius
{
    CIImage *input = [CIImage imageWithContentsOfURL:url];
    
    //1) mono color
    CIFilter *monochrome = [CIFilter filterWithName:@"CIColorMatrix"];
    [monochrome setDefaults];
    [monochrome setValue:[CIVector vectorWithX:0 Y:0 Z:0 W:0] forKey:@"inputRVector"];
    [monochrome setValue:[CIVector vectorWithX:0 Y:0 Z:0 W:0] forKey:@"inputGVector"];
    [monochrome setValue:[CIVector vectorWithX:0 Y:0 Z:0 W:0] forKey:@"inputBVector"];
    [monochrome setValue:[CIVector vectorWithX:0 Y:0 Z:0 W:1] forKey:@"inputAVector"];
    
    [monochrome setValue:input forKey:@"inputImage"];
    CIImage *outputCIImage = [monochrome valueForKey:@"outputImage"];
    
    //2) blur
    CIFilter *blur = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blur setDefaults];
    [blur setValue:outputCIImage forKey:@"inputImage"];
    [blur setValue:blurRadius ? @(blurRadius) : @10.0 forKey:@"inputRadius"];
    outputCIImage = [blur valueForKey:@"outputImage"];
    
    //Create a CIContext
    CIContext* context = [[CIContext alloc] init];
    
    //Create an CGImageRef from the output CIImage
    CGImageRef imgRef = [context createCGImage:outputCIImage fromRect:outputCIImage.extent];
    
    //Write to disk
    CGImageWriteToFile(imgRef, outputUrl);
    
    //Emty the memory
    CGImageRelease(imgRef);
}

void CGImageWriteToFile(CGImageRef image, NSURL *nsurl) {
    CFURLRef url = (__bridge CFURLRef)nsurl;
    CGImageDestinationRef destination = CGImageDestinationCreateWithURL(url, kUTTypePNG, 1, NULL);
    CGImageDestinationAddImage(destination, image, nil);
    
    if (!CGImageDestinationFinalize(destination)) {
        NSLog(@"Failed to write image to %@", nsurl.path);
    }
    
    CFRelease(destination);
}


@end



