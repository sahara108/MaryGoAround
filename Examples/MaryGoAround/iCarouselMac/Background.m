//
//  Background.m
//  LBProgressBar
//
//  Created by Laurin Brandner on 05.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Background.h"

#define backgroundColor [NSColor colorWithCalibratedRed:32.0/255.0 green:36.0/255.0 blue:41.0/255.0 alpha:1.0]

@implementation Background

-(void)drawRect:(NSRect)dirtyRect {
//    NSGradient* gradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedWhite:0.2 alpha:1.0] endingColor:backgroundColor];
//    [gradient drawInRect:self.bounds relativeCenterPosition:NSZeroPoint];
	
	
//	or
	NSColor* gradientBottom = [NSColor colorWithCalibratedWhite:0.10 alpha:1.0];
    NSColor* gradientTop    = [NSColor colorWithCalibratedWhite:0.35 alpha:1.0];
    
	NSGradient* gradient = [[NSGradient alloc] initWithStartingColor:gradientBottom
                                                         endingColor:gradientTop];
    [gradient drawInRect:self.bounds angle:90.0];

}

@end
