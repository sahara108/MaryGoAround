//
//  SimpleView.h
//  NSViewAnimation Test
//
//  Created by Matt Gemmell on 08/11/2006.
//  Copyright 2006 Magic Aubergine. All rights reserved.
//

#import <Cocoa/Cocoa.h>
//#import "TrackingView.h"


//@interface WC : NSViewController
////@property (strong) IBOutlet NSView *aView;
// {
////These would just be custom views included in the main nib file that serve
////as placeholders for where to insert the views coming from other nibs
//	IBOutlet NSView* topView;
//	IBOutlet NSView* contentView;
////	AppController* topViewController;
////	ContentViewController* contentViewController;
////-(void)tracker:(NSPoint)atPoint;
//}
//@end

@class TrackingView;
@interface SimpleView : NSView {
@private
    NSTrackingArea * trackingArea;
//	IBOutlet TrackingView *trackingView;
}
@property (assign) int tag;
@property (strong) NSColor *backgroundColor;
@end
