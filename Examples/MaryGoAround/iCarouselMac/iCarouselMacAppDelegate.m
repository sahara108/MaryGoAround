//
//  iCarouselMacAppDelegate.m
//  iCarouselMac
//
//  Created by Nick Lockwood on 11/06/2011.
//  Copyright 2011 Charcoal Design. All rights reserved.
//

#import "iCarouselMacAppDelegate.h"

@implementation iCarouselMacAppDelegate

@synthesize window, fullScreenWindow;
@synthesize windowController;
@synthesize fullView;


- (void) awakeFromNib {
	
	fullView = [window contentView];
	NSScreen *theScreen = [NSScreen mainScreen];
	
	GetSystemUIMode(&outMode, &outOptions);
	SetSystemUIMode(kUIModeAllSuppressed,kUIOptionAutoShowMenuBar);
	
	[window setDelegate:self];
	[window setAlphaValue:0.0];
	[self setFullScreenWindow:[[NSWindow alloc] 	
		initWithContentRect:[window contentRectForFrameRect:fullView.frame]	
		styleMask:NSBorderlessWindowMask	
		backing:NSBackingStoreBuffered	
		defer:YES	screen:theScreen]];
	[fullScreenWindow becomeFirstResponder];
	[fullScreenWindow setContentView:fullView];
	[fullScreenWindow makeKeyAndOrderFront:self];
	[[self fullScreenWindow] setFrame:[[self fullScreenWindow] frameRectForContentRect:theScreen.frame] display:YES animate:NO];
	[self fadeInDisplay:CGMainDisplayID() fadeTime:1.0];
	[window setAlphaValue:0.0]; //:nil];
}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
//	[self setFullScreenWindow:nil]; [self toggleFullscreen];    // Insert code here to initialize your application
}

- (BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}


- (void) toggleFullscreen {	
	[self fadeOutDisplay:CGMainDisplayID() fadeTime:1.0];
	if (fullScreenWindow != nil)	{		
		[fullScreenWindow setFrame:[window contentRectForFrameRect:[window frame]] display:YES animate:NO];
		[window setContentView:[fullScreenWindow contentView]];
		[window makeKeyAndOrderFront:nil];
		[fullScreenWindow close];
		[self setFullScreenWindow:nil];
		SetSystemUIMode(outMode, outOptions);
	} else {		
		GetSystemUIMode(&outMode, &outOptions);
		SetSystemUIMode(kUIModeAllSuppressed,kUIOptionAutoShowMenuBar);
		[self setFullScreenWindow:[[NSWindow alloc] initWithContentRect:[window contentRectForFrameRect:[window frame]]	styleMask:NSBorderlessWindowMask	backing:NSBackingStoreBuffered	defer:YES	screen:[window screen]]];
		[[self fullScreenWindow] setContentView:[window contentView]];
		[[self fullScreenWindow] makeKeyAndOrderFront:nil];
		[[self fullScreenWindow] setFrame:[[self fullScreenWindow] frameRectForContentRect:[[window screen] frame]] display:YES animate:NO];
	} /* end if */
	[window setAlphaValue:0.1];
	[self fadeInDisplay:CGMainDisplayID() fadeTime:1.0];
}

- (void) fadeOutDisplay:(CGDirectDisplayID)display fadeTime:(double)fadeTime {
	int		fadeSteps 		= 10;
	double 	fadeInterval	= (fadeTime / (double) fadeSteps);
	int 			step;
	double 			fade;
	CGGammaValue	redMin,   redMax,   redGamma, greenMin, greenMax, greenGamma, blueMin,  blueMax,  blueGamma;	
	CGGetDisplayTransferByFormula(display, &redMin,   &redMax,   &redGamma, &greenMin, &greenMax, &greenGamma, &blueMin,  &blueMax,  &blueGamma);
	for (step = 0; step < fadeSteps; step++) {
	    fade = 1.0 - (step * fadeInterval);
	    CGSetDisplayTransferByFormula(display, redMin,   fade*redMax,   redGamma, greenMin, fade*greenMax, greenGamma, blueMin,  fade*blueMax,  blueGamma);
		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:fadeInterval]];
	} /* end for */
} 
- (void) fadeInDisplay:(CGDirectDisplayID)display fadeTime:(double)fadeTime {
	int		fadeSteps 		= 256, 	step;
	double 	fadeInterval	= (fadeTime / (double) fadeSteps), fade;
	CGGammaValue	redMin,   redMax,   redGamma,
					greenMin, greenMax, greenGamma,
					blueMin,  blueMax,  blueGamma;
	CGGetDisplayTransferByFormula(display,  &redMin,   &redMax,   &redGamma,
											&greenMin, &greenMax, &greenGamma,
											&blueMin,  &blueMax,  &blueGamma);
	for (step = 0; step < fadeSteps; step++) {	fade = (step * fadeInterval);
        CGSetDisplayTransferByFormula(display,	redMin,   fade*redMax,  redGamma,
												greenMin, fade*greenMax, greenGamma,
												blueMin,  fade*blueMax,  blueGamma);
		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:fadeInterval]];
	} /* end for */
} 

@end
