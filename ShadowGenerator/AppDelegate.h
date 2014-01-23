//
//  AppDelegate.h
//  ShadowGenerator
//
//  Created by Alexander Bekert on 22/01/14.
//  Copyright (c) 2014 Alexander Bekert. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    NSImage *original;
    NSImage *shadow;
}

@property (assign) IBOutlet NSWindow *window;

@property IBOutlet NSTextField *dragAndDropLabel;
@property IBOutlet NSSegmentedControl *segmentedControl;
@property IBOutlet NSImageView *imageView;
@property IBOutlet NSSlider *blurSlider;
@property IBOutlet NSTextField *blurLabel;
@property IBOutlet NSButton *doubleCheckBox;

- (IBAction)segmentedControlPerformedClick:(id)sender;
- (IBAction)blurSliderMoved:(id)sender;

@end
