//
//  iCarouselWindowController.h
//  iCarouselMac
//
//  Created by Nick Lockwood on 11/06/2011.
//  Copyright 2011 Charcoal Design. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "iCarousel.h"
#import "DBXInit.h"
#import "NSColor+Hex.h"
#import "LetterLayer.h"
#import "NSColor+Additions.h"
#import "XYPieChart.h"
#import "SimpleView.h"
#import "AMDarkButtonCell.h"

@interface iCarouselWindowController : NSWindowController  <iCarouselDataSource, iCarouselDelegate> {

	IBOutlet NSWindow *window;
	IBOutlet NSView *mainC;
	NSRect screen;
	IBOutlet CALayer *rootLayer;
	
	IBOutlet NSView *colorBar, *arrivalBar;
	IBOutlet CALayer *colorBarLayer, *arrivalBarLayer;
	NSRect colorBarRect, arrivalBarRect;

	NSMutableArray *letterLayers;
	int textIndex;
	
@public
	iCarousel *carousel;
    NSUInteger numberOfVisibleItemsInCarousel;
	NSUInteger numberOfItemsInCarousel;
    BOOL wrap;
    NSMutableArray *items;
	
	DBXInit *dbx;
	
//arrival
	
//	XYPieChart *pieChart;
//	CALayer *draggingLayer;	
//	IBOutlet NSDictionaryController *dockCon;		
				

}
//@property (nonatomic, retain) IBOutlet NSSlider *arcSlider;
//@property (nonatomic, retain) IBOutlet NSSlider *radiusSlider;
//@property (nonatomic, retain) IBOutlet NSSlider *tiltSlider;
//@property (nonatomic, retain) IBOutlet NSSlider *spacingSlider;

- (IBAction)reloadCarousel:(id) sender;

@property (assign) NSUInteger numberOfVisibleItemsInCarousel;
@property (assign) NSUInteger numberOfItemsInCarousel;

@property (assign) NSRect screen;
@property (nonatomic, readonly) NSInteger currentItemIndex;
@property (nonatomic, retain) IBOutlet iCarousel *carousel;


//@property (strong, nonatomic) XYPieChart *pieChart;
//@property (assign) NSUInteger *numOfSlices;
//@property (assign) NSUInteger *indexOfSlices;
//@property(nonatomic, strong) NSMutableArray *slices;
//@property(nonatomic, strong) NSArray *sliceColors;

- (IBAction)switchCarouselType:(id)sender;
- (IBAction)toggleVertical:(id)sender;
- (IBAction)toggleWrap:(id)sender;
- (IBAction)insertItem:(id)sender;
- (IBAction)removeItem:(id)sender;

- (void)carouselCurrentItemIndexUpdated:(iCarousel *)_carousel;
- (void)updateViewpointOffset:(float)slider;
- (void)updateContentOffset:(float)slider;


//arrival

- (void)spellItOut:(NSString *)text;
- (void)setInstantText:(NSString *)text;

// XYPie

//- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart;
//- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index;
//- (NSColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index;	//optional

- (void)pieChart:(XYPieChart *)pieChart willSelectSliceAtIndex:(NSUInteger)index;
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index;
- (void)pieChart:(XYPieChart *)pieChart willDeselectSliceAtIndex:(NSUInteger)index;
- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index;


@end