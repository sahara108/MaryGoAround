//
//  MEOverlayController.m
//  MEOverlayView
//
//  Created by Mikkel Eide Eriksen on 25/01/12.
//  Copyright (c) 2012 Mikkel Eide Eriksen. All rights reserved.
//

#import "MEOverlayController.h"
#import "MEOverlayView.h"
#import "NSColor+Additions.h"

@implementation MEOverlayController {
    NSMutableArray *_overlays;
}

#pragma mark Initialization

- (id) init
{
    self = [super init];
    
    if (self) {
		
        NSUInteger overlayCount = 5;
		dbx = [[DBXInit alloc]init];
//		appArray = [self rollCall];
//		totalItems = appArray.count;
        _overlays = [NSMutableArray arrayWithCapacity:overlayCount];
				
			
		NSRect windowFrame = [[NSScreen mainScreen]frame];
//		CGFloat winW = windowFrame.size.width;
		CGFloat winH = windowFrame.size.height;
		float itemWidth = dbx.idealWidth.floatValue;
		int columns = dbx.columns.intValue;
		NSLog(@"itemwidth: %f  Columns: %i",itemWidth, columns);
		overlayCount = dbx.totalItems.intValue;        

		float 	yFromTop = 0.0,
				yOff = (winH - itemWidth - yFromTop),
				xOff = 0.0;
		int columnState = 0;
		while ( overlayCount > 0 ) {
			if ((columnState <= columns)) {
				NSRect rect = NSMakeRect( xOff, yOff,itemWidth, itemWidth);
				[_overlays addObject:[NSValue valueWithRect:rect]];
				xOff += itemWidth;
				columnState++;
				overlayCount--;
				NSLog(@"Overlay at %i.%i : %i x %i", (int)rect.origin.x, (int)rect.origin.y, (int)rect.size.width, (int)rect.size.height);
			} else {
				columnState = 0; xOff = 0.0; yOff -= itemWidth;
				NSLog(@"COLUMN SHIFT!");
			}
		}
	}			
//		if ((columnState == 0) || (columnState == columns)) {
//		 NSLog(@"Total items: %i", totalItems);
//			shrinker += 120.0;
//		}   
//        NSLog(@"Created rects: %@", _overlays);

    
    return self;
}

- (void)awakeFromNib
{
    
    //some examples -- try changing them to see how they work.
    NSString *imgURL = [[NSBundle mainBundle] pathForImageResource:@"royalty-free-food-image-cabbage.jpg"];
    [overlayView setImageWithURL:[NSURL fileURLWithPath:imgURL]];
    
    CGColorRef ofColor = CGColorCreateGenericRGB(0.0f, 0.0f, 1.0f, 0.5f);
    [overlayView setOverlayFillColor:ofColor];//[[NSColor randomColor]CGColor]];// ofColor];
    CGColorRelease(ofColor);
    
    CGColorRef obColor = CGColorCreateGenericRGB(0.0f, 0.0f, 1.0f, 1.0f);
    [overlayView setOverlayBorderColor:obColor];
    CGColorRelease(obColor);
    
    CGColorRef osfColor = CGColorCreateGenericRGB(1.0f, 0.0f, 0.0f, 0.5f);
    [overlayView setOverlaySelectionFillColor:osfColor];
    CGColorRelease(osfColor);
    
    CGColorRef osbColor = CGColorCreateGenericRGB(1.0f, 0.0f, 0.0f, 1.0f);
    [overlayView setOverlaySelectionBorderColor:osbColor];
    CGColorRelease(osbColor);
    
    [overlayView setOverlayBorderWidth:3.0f];
    
    [overlayView setAllowsCreatingOverlays:YES];
    [overlayView setAllowsModifyingOverlays:YES];
    [overlayView setAllowsDeletingOverlays:YES];
    [overlayView setAllowsOverlappingOverlays:NO];
    
    [overlayView setTarget:self];
    [overlayView setAction:@selector(singleClick)];
    [overlayView setDoubleAction:@selector(doubleClick)];
    [overlayView setRightAction:@selector(rightClick)];
    
    [overlayView setAllowsOverlaySelection:YES];
    [overlayView setAllowsEmptyOverlaySelection:NO];
    [overlayView setAllowsMultipleOverlaySelection:YES];
    
    [overlayView bind:@"contents" toObject:self withKeyPath:@"overlays" options:nil];
}

#pragma mark MEOverlayViewDataSource

- (NSUInteger)numberOfOverlaysInOverlayView:(MEOverlayView *)anOverlayView
{
    return [_overlays count];
}

- (id)overlayView:(MEOverlayView *)anOverlayView overlayObjectAtIndex:(NSUInteger)num
{
    return [_overlays objectAtIndex:num];
}

#pragma mark MEOverlayViewDelegate

- (void)overlayView:(MEOverlayView *)anOverlayView didCreateOverlay:(NSRect)rect
{
    NSLog(@"overlay created: %@", NSStringFromRect(rect));
    [_overlays addObject:[NSValue valueWithRect:rect]];
    
    /*
     Do whatever else you feel like here... 
     */
    [overlayView reloadData];
}

- (void)overlayView:(MEOverlayView *)anOverlayView didModifyOverlay:(id)overlayObject newRect:(NSRect)rect
{
    NSLog(@"overlay %@ got new rectangle %@", overlayObject, NSStringFromRect(rect));
    [_overlays removeObject:overlayObject];
    [_overlays addObject:[NSValue valueWithRect:rect]];
    
    /*
     Do whatever else you feel like here... 
     In reality you wouldn't delete/replace, but modify the actual object you're given. 
     I'm just doing it like this here because I'm using NSValues in the example.
     In this case it also causes the overlay to lose its selection if modified, since it is no longer the same object.
     */
    [overlayView reloadData];
}

- (void)overlayView:(MEOverlayView *)anOverlayView didDeleteOverlay:(id)overlayObject
{
    NSLog(@"overlay %@ deleted", overlayObject);
    [_overlays removeObject:overlayObject];
    
    /*
     Do whatever else you feel like here... 
     Naturally you can run some extra logic and decide not to delete the object if you want/need to.
     */
    [overlayView reloadData];
}

- (void)overlaySelectionDidChange:(NSNotification *)aNotification
{
    NSLog(@"notification: %@", aNotification);
}

- (void)singleClick
{
    NSLog(@"singleClick: %ld", [overlayView clickedOverlay]);
}

- (void)doubleClick
{
    NSLog(@"doubleClick: %ld", [overlayView clickedOverlay]);
}

- (void)rightClick
{
    NSLog(@"rightClick: %ld", [overlayView clickedOverlay]);
}

#pragma mark User interface

- (IBAction)logCurrentOverlays:(id)sender
{
    NSLog(@"overlays: %@", _overlays);
}

- (IBAction)changeState:(id)sender
{
    [overlayView enterState:[sender selectedSegment]];
}


- (void) applicationDidFinishLaunching:(NSNotification *)aNotification {
//	[self setFullScreenWindow:nil];	[self toggleFullscreen:self];
}
//- (void) applicationWillTerminate:(NSNotification *)notification {	[self toggleFullscreen:self];	[window setAlphaValue:0]; }

@synthesize overlays = _overlays;
//@synthesize idealWidth, columns, totalItems, rows;

@end
