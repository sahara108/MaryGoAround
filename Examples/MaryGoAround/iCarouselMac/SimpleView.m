//
//  SimpleView.m
//  NSViewAnimation Test
//
//  Created by Matt Gemmell on 08/11/2006.
//  Copyright 2006 Magic Aubergine. All rights reserved.
//

#import "SimpleView.h"

//#import "TrackingView.h"

//@synthesize aView;

//- (void)loadSecondNib {	NSLog(@"Loading NIB …");    if (![NSBundle loadNibNamed:@"Tracker" owner:self])    { NSLog(@"Warning! Could not load myNib file.\n");   }
//}
//
//
//-(void)tracker:(NSPoint)atPoint {
////	[self loadSecondNib];
//	TrackingView *v = [[TrackingView alloc] init];
//	NSWindow *window = [[NSWindow alloc] initWithContentRect:v.frame styleMask:NSBorderlessWindowMask backing:NSWindowBackingLocationDefault defer:YES screen:[NSScreen mainScreen]];
//	NSBeep();
////	[window setAlphaValue:0.4];
////	[window setContentView:v];
//	[window setFrameOrigin:atPoint];
//	[window display];
////	[window setFrame:v.frame display:YES animate:YES];
//	
//	//	[self.superview addSubview:v];// positioned:NSAboveTop relativeTo:self];
//	NSLog(@"tried to add tracking menu");	
//}
//
//@end
@implementation SimpleView
@synthesize tag, backgroundColor;


- (id)initWithFrame:(NSRect)frame{
	if (self = [super initWithFrame:frame]) {
		if (!backgroundColor) [self setBackgroundColor:[NSColor blueColor]];
		tag = [self unique];
	}
	return self;
}


- (void)drawRect:(NSRect)rect {
   
	[[self backgroundColor] set];
    NSRectFill(rect);
}

-(int) unique {
	return [[NSString stringWithFormat:@"%i%i%i",self.backgroundColor.redComponent,self.backgroundColor.blueComponent, self.backgroundColor.greenComponent] intValue];
}


-(void)updateTrackingAreas {
    if(trackingArea != nil) {
        [self removeTrackingArea:trackingArea];
    }
    int opts = (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways);
    trackingArea = [ [NSTrackingArea alloc] initWithRect:[self bounds]
												 options:opts
												   owner:self
												userInfo:nil];
    [self addTrackingArea:trackingArea];
}
-(void)mouseEntered:(NSEvent *)theEvent {
	tag = [self unique];	NSLog(@"Mouse entered %i", tag);
}

-(void)mouseUp:(NSEvent *)theEvent {
    
//	NSViewController *theDetailViewController = [NSViewController new];
//    [theDetailViewController initWithNibName:@"Tracker" bundle:nil];
//    NSView *splitRightView = [[self superview] objectAtIndex:1];
	
//    NSView *splitRightView = [[theSplitView subviews] objectAtIndex:1];
	NSRect re = NSMakeRect(0,0,200,400);
//    TrackingView *aDetailView = [[ TrackingView alloc]initWithFrame:re];//NSMakeRect(0,0,200,400)];
//	SimpleView *sim =[[SimpleView alloc]initWithFrame:re];
//	
	//, <#CGFloat y#>, <#CGFloat w#>, <#CGFloat h#>)[splitRightView bounds]];
//    [aDetailView setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];
//    [self.superview addSubview:aDetailView];
	[self.superview setNeedsDisplay:YES];
//	[aDetailView setNeedsDisplay:YES];
//	[aDetailView release];
    NSLog(@"%@",(NSString *)self.superview);


//	[super addSubview:aDetailView];//
//	wc = [[WC alloc] initWithNibName:@"Tracker" bundle:nil];
//	[wc view];
	//	wc = [[wc alloc] initWithNibName:@"MyView" bundle:[NSBundle mainBundle]];
//
//	[wc tracker:self.frame.origin];
//	NSLog(@"tried to add tracking menu. %@ with frame %f %f %f %f", aDetailView, aDetailView.frame.origin.x,aDetailView.frame.origin.y, aDetailView.frame.size.width, aDetailView.frame.size.height);	
}
-(void)mouseExited:(NSEvent *)theEvent {
	NSPoint point;
	point = self.frame.origin;
	NSLog(@"left box with origin %f, %f", self.frame.origin.x,self.frame.origin.y );
}

- (void)animateOneFrame {

	float rand_max = RAND_MAX;
	float red = rand() / rand_max;
	float green = rand() / rand_max;
	float blue = rand() / rand_max;
	NSColor* color = [NSColor colorWithCalibratedRed:red green:green blue:blue alpha:1.0];
	
	NSBezierPath *path;		NSRect rect;	NSSize size;	
	float red, green, blue, alpha;			int shapeType;
	size = [[self superview] bounds].size;
	
	// Calculate random width and height
	rect.size = NSMakeSize( SSRandomFloatBetween( size.width / 100.0, size.width / 10.0 ), SSRandomFloatBetween( size.height / 100.0, size.height / 10.0 ));
	
	// Calculate random origin point
	rect.origin = NSRandomPointForSizeWithinRect( rect.size, [self bounds] );
	
	// Decide what kind of shape to draw
	shapeType = SSRandomIntBetween( 0, 2 );
	
	switch (shapeType)
	{
		case 0: // rect
			path = [NSBezierPath bezierPathWithRect:rect];
			break;
			
		case 1: // oval
			path = [NSBezierPath bezierPathWithOvalInRect:rect];
			break;
			
		case 2: // arc
		default:
		{
			float startAngle, endAngle, radius;
			NSPoint point;
			
			startAngle = SSRandomFloatBetween( 0.0, 360.0 );
			endAngle = SSRandomFloatBetween( startAngle, 360.0 + startAngle );
			
			// Use the smallest value for the radius (either width or height)
			radius = rect.size.width <= rect.size.height ? rect.size.width / 2 : rect.size.height / 2;
			
			// Calculate our center point
			point = NSMakePoint( rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2 );
			
			// Construct the path
			path = [NSBezierPath bezierPath];
			
			[path appendBezierPathWithArcWithCenter:point radius:radius startAngle:startAngle endAngle:endAngle clockwise:SSRandomIntBetween( 0, 1 )];
		}
			break;
	}
	
	// Calculate a random color
	red = SSRandomFloatBetween( 0.0, 255.0 ) / 255.0;
	green = SSRandomFloatBetween( 0.0, 255.0 ) / 255.0;
	blue = SSRandomFloatBetween( 0.0, 255.0 ) / 255.0;
	alpha = SSRandomFloatBetween( 0.0, 255.0 ) / 255.0;
	
	color = [NSColor colorWithCalibratedRed:red green:green blue:blue alpha:alpha];
	
	[color set];
	
	// And finally draw it
	defaults = [ScreenSaverDefaults defaultsForModuleWithName:MyModuleName];
	
	if ([defaults boolForKey:@"DrawBoth"])
	{
		if (SSRandomIntBetween( 0, 1 ) == 0)
			[path fill];
		else
			[path stroke];
	}
	else if ([defaults boolForKey:@"DrawFilledShapes"])
		[path fill];
	else
		[path stroke];
}


@end
