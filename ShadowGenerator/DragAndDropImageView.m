//
//  DragAndDropImageView.m
//  ShadowGenerator
//
//  Created by Alexander Bekert on 23/01/14.
//  Copyright (c) 2014 Alexander Bekert. All rights reserved.
//

#import "DragAndDropImageView.h"

@implementation DragAndDropImageView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

#pragma mark - Drag and Drop

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask]) == NSDragOperationGeneric) {
        return NSDragOperationGeneric;
    }
    else
    {
        return NSDragOperationNone;
    }
}

- (void)draggingExited:(id<NSDraggingInfo>)sender
{
    
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{
    NSPasteboard *pasteboard = [sender draggingPasteboard];
    
    if ([[pasteboard types] containsObject:NSURLPboardType]) {
        
        NSArray *urls = [pasteboard readObjectsForClasses:@[[NSURL class]] options:nil];
        NSMutableArray *photoUrls = [[NSMutableArray alloc] initWithCapacity:urls.count];
        
        for (NSURL *url in urls) {
//            NSLog(@"%@\n", url.path);
            NSString *pathExtension = [url pathExtension];
            if ([[NSImage imageFileTypes] containsObject:pathExtension])
                [photoUrls addObject:url];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Dragged new images" object:urls];
        
        return YES;
    }
    
    return NO;
}

@end
