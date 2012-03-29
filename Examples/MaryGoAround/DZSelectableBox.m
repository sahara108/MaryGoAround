//
//  DZSelectableBox.m
//  SelectedBox
//
//  Created by unixo <unixo@devzero.it> on 13/12/09.
//  Copyright 2009 Ferruccio Vitale. All rights reserved.
//

#import "DZSelectableBox.h"


@implementation DZSelectableBox

@synthesize selectedBgColor, selected, fillColor;

- (id) init
{
	if ((self = [super init])) {
		selected = NO;
		fillColor = [NSColor randomColor];
		_borderWidth = 0;
		_radius = 0.0;
//		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_update:) name:DZSelectableBoxNotification object:nil];
	}	return self;
}

- (void)drawRect:(NSRect)dirtyRect
{		
	[super drawRect:dirtyRect];
	
	if (selected) {
		NSRect bgRect = [self bounds];
		NSBezierPath *bgPath = [NSBezierPath bezierPathWithRoundedRect:bgRect 
															   xRadius:_radius 
															   yRadius:_radius];
		[selectedBgColor set];
		[bgPath fill];		
		[bgPath setLineWidth:2.0];
		[bgPath stroke];		
	}
}


- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	fillColor = nil;
	selectedBgColor = nil;
}
- (BOOL)preservesContentDuringLiveResize
{
    return YES;
}

//
//- (void) _update:(NSNotification *)aNotification
//{
//	// If this notification was originated by this box or if this box is not part of any radio group, ignore it!
//	if (([aNotification object] == self))
//		return;
//	
//	// Check if radio group contained in notification user info is equal to our
//	NSNumber *num = [[aNotification userInfo] valueForKey:@"radioGroup"];
//	if ([num intValue] != [self.radioGroup intValue])
//		return;
//	
//	if (selected) {
//		selected = NO;
//		[self setNeedsDisplay:YES];
//	}
//}
//
//- (void) _notifyRadioGroup
//{
//	NSDictionary *userInfo = [NSDictionary dictionaryWithObject:self.radioGroup 
//														 forKey:@"radioGroup"];
//	[[NSNotificationCenter defaultCenter] postNotificationName:DZSelectableBoxNotification
//														object:self
//													  userInfo:userInfo];
//}

//- (BOOL) selected
//{
//	return selected;
//}
//
//- (void) setSelected:(BOOL)aValue
//{
//	BOOL oldValue = selected;
//	selected = aValue;
//	if (oldValue != aValue) {
//		[self setNeedsDisplay:YES];
////		[self _notifyRadioGroup];
//	}		
//}

- (void) toggleState
{
//	if ([radioGroup intValue] >= 0) {
		if (selected)
			NSBeep();
			NSLog(@"%@ was selected", self);
			[self setNeedsDisplay:YES];
//				? self.selected = NO : 
			return;
//	}
//	selected = !selected;
//	[self _notifyRadioGroup];
}

- (void)mouseDown:(NSEvent *)theEvent
{
	[self toggleState];
	[super mouseDown:theEvent];
}

@end
