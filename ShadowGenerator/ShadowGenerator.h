#import <Quartz/Quartz.h>
#import <ImageIO/ImageIO.h>
#import <CoreServices/CoreServices.h>

@interface ShadowGenerator : NSObject

+ (void)shadowImageFromURL:(NSURL *)url toURL:(NSURL *)outputUrl withBlurRadius:(CGFloat)blurRadius;

@end
