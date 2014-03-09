#import <Quartz/Quartz.h>

@interface ShadowGenerator : NSObject

+ (void)shadowImageFromURL:(NSURL *)url toURL:(NSURL *)outputUrl withBlurRadius:(CGFloat)blurRadius;

@end
