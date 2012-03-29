//
//  iCarouselMacAppDelegate.h
//  iCarouselMac
//
//  Created by Nick Lockwood on 11/06/2011.
//  Copyright 2011 Charcoal Design. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>
#import "XYViewController.h"

@interface iCarouselMacAppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate>
{
	IBOutlet XYViewController *xyController;
    NSWindow *window, *fullScreenWindow;
	NSView *fullView;
    NSWindowController *windowController;
	SystemUIMode 	 outMode;
	SystemUIOptions	 outOptions;
}
@property (assign) NSWindow *fullScreenWindow;
@property (assign) IBOutlet NSWindow *window;
@property (assign) NSView *fullView;

@property (assign) IBOutlet NSWindowController *windowController;

@end
