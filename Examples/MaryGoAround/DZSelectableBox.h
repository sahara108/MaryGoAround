//
//  DZSelectableBox.h
//  SelectedBox
//
//  Created by unixo <unixo@devzero.it> on 13/12/09.
//  Copyright 2009 Ferruccio Vitale. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSColor+Additions.h"

#define	DZSelectableBoxNotification		@"DZSelectableBoxNotification"

@interface DZSelectableBox : NSView 
{
	NSColor *selectedColor;
	NSColor *fillColor;
	BOOL selected;
@private
	float _borderWidth;
	float _radius;
}

@property (nonatomic, retain) NSColor *fillColor;
@property (nonatomic, retain) NSColor *selectedBgColor;
@property (assign) BOOL selected;

//- (void) _setDefaultValues;
@end
