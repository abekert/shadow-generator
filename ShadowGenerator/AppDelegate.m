//
//  AppDelegate.m
//  ShadowGenerator
//
//  Created by Alexander Bekert on 22/01/14.
//  Copyright (c) 2014 Alexander Bekert. All rights reserved.
//

#define SHADOW_SUFFIX @"-shadow"

#define ORIGINAL_CONTROL 0
#define SHADOW_CONTROL 1

#import "AppDelegate.h"
#import "ShadowGenerator.h"

@implementation AppDelegate

@synthesize dragAndDropLabel, segmentedControl, imageView, blurSlider, blurLabel, doubleCheckBox;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    segmentedControl.enabled = NO;
    segmentedControl.hidden = YES;
    dragAndDropLabel.hidden = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNewImages:) name:@"Dragged new images" object:nil];
}

- (IBAction)segmentedControlPerformedClick:(id)sender
{
    if (segmentedControl.selectedSegment == ORIGINAL_CONTROL) {
        imageView.image = original;
    }
    else
    {
        imageView.image = shadow;
    }
}

- (void)blurSliderMoved:(id)sender
{
    [blurLabel setStringValue:[blurSlider stringValue]];
}

- (void)receivedNewImages:(NSNotification *)notification
{
    segmentedControl.enabled = YES;
    segmentedControl.hidden = NO;
    dragAndDropLabel.hidden = YES;
    
    NSArray *urls = notification.object;
    
    for (NSURL *url in urls) {
        original = [[NSImage alloc] initWithContentsOfURL:url];
        CGFloat blurRadius = [self blurRadiusForUrl:url];
        NSURL *shadowURL = [self shadowUrlForUrl:url];

        [ShadowGenerator shadowImageFromURL:url toURL:shadowURL withBlurRadius:blurRadius];
    }
    
    NSURL *lastUrl = urls.lastObject;
    NSURL *lastShadowUrl = [self shadowUrlForUrl:lastUrl];
    
    original = [[NSImage alloc] initWithContentsOfURL:lastUrl];
    shadow = [[NSImage alloc] initWithContentsOfURL:lastShadowUrl];
    
    segmentedControl.selectedSegment = 1;
    imageView.image = shadow;
}

- (CGFloat)blurRadiusForUrl:(NSURL *)url
{
    CGFloat radius = [blurSlider floatValue];
    if (doubleCheckBox.state == NSOffState) {
        return radius;
    }
    
    NSString *filename = url.lastPathComponent;
    NSRange retinaRange = [filename rangeOfString:@"@2x"];
    BOOL isRetina = retinaRange.location != NSNotFound;
    
    if (isRetina) {
        radius *= 2;
    }
    
    return radius;
}

- (NSURL *)shadowUrlForUrl:(NSURL *)url
{
    NSInteger extensionLength = [[url pathExtension] length];
    NSString *filename = url.lastPathComponent;
    filename = [filename substringToIndex:(filename.length - extensionLength - 1)];
    
    NSString *shadowFilename = [self shadowFilenameForFilename:filename];
    shadowFilename = [shadowFilename stringByAppendingString:@".png"];
    
    NSMutableArray *shadowPathComponents = [NSMutableArray arrayWithArray:url.pathComponents];
    [shadowPathComponents removeLastObject];
    [shadowPathComponents addObject:shadowFilename];
    NSURL *shadowURL = [NSURL fileURLWithPathComponents:shadowPathComponents];

    return shadowURL;
}

- (NSString *)shadowFilenameForFilename:(NSString *)filename
{
    NSString *shadowFilename = @"";
    
    NSRange retinaRange = [filename rangeOfString:@"@2x"];
    if (retinaRange.location != NSNotFound) {
        shadowFilename = [self stringByInsertingSubstring:SHADOW_SUFFIX toString:filename intoIndex:retinaRange.location];

        return shadowFilename;
    }
    
    NSRange tildaRange = [filename rangeOfString:@"~"];
    if (tildaRange.location != NSNotFound) {
        shadowFilename = [self stringByInsertingSubstring:SHADOW_SUFFIX toString:filename intoIndex:tildaRange.location];
        
        return shadowFilename;
    }
    
    shadowFilename = [filename stringByAppendingString:SHADOW_SUFFIX];
    
    return shadowFilename;
}

- (NSString *)stringByInsertingSubstring:(NSString *)substring toString:(NSString *)string intoIndex:(NSUInteger)index
{
    NSString *outputString;
    
    outputString = [string substringToIndex:index];
    outputString = [outputString stringByAppendingString:substring];
    outputString = [outputString stringByAppendingString:[string substringFromIndex:index]];
    
    return outputString;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
