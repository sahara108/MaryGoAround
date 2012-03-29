//
//  MEOverlayController.h
//  MEOverlayView
//
//  Created by Mikkel Eide Eriksen on 25/01/12.
//  Copyright (c) 2012 Mikkel Eide Eriksen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Carbon/Carbon.h>
#import "DBXInit.h"

@class MEOverlayView;
@interface MEOverlayController : NSObject {
    IBOutlet MEOverlayView *overlayView;

	DBXInit				*dbx;

//	NSWorkspace	 		*ws;
	NSMutableArray		*content;
//	NSArray 			*appArray;
//	float 				idealWidth;
//	NSUInteger 			totalItems;
//	NSUInteger 			columns;
//	NSUInteger 			rows;
}
- (IBAction)logCurrentOverlays:(id)sender;
- (IBAction)changeState:(id)sender;

//@property (assign) NSUInteger totalItems;
//@property (assign) NSUInteger rows;
//@property (assign) NSUInteger columns;

//@property (assign) float idealWidth;

@property (strong) NSMutableArray *overlays;

@end
