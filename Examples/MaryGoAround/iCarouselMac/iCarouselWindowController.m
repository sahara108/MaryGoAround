//  iCarouselWindowController.m
#import "DBXObject.h"
#import "iCarouselWindowController.h"
//#define NUMBER_OF_ITEMS 19 //#define NUMBER_OF_VISIBLE_ITEMS 19
#define ITEM_SPACING 128
#define INCLUDE_PLACEHOLDERS NO

@interface iCarouselWindowController ()
@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, retain) NSMutableArray *items;
@end

@implementation iCarouselWindowController
@synthesize numberOfVisibleItemsInCarousel, numberOfItemsInCarousel, carousel, wrap, items;
@synthesize currentItemIndex, screen;//, indexOfSlices, numOfSlices;


- (id)initWithWindow:(NSWindow *)awindow {    if ((self = [super initWithWindow:window])) { //set up data

	wrap = YES;    	
	dbx = [DBXObject sharedInstance]; // BXInit alloc]initWithIconSize:100];
	items = [NSMutableArray arrayWithArray:dbx.appArray];
	[self setNumberOfItemsInCarousel:[dbx.appArray count]];
	[self setNumberOfVisibleItemsInCarousel:[dbx.appArray count]];
	screen = [[NSScreen mainScreen]frame];
	CGFloat screenX = screen.size.width; 
	//colorbar
	colorBarRect = NSMakeRect(0.0, 0.0, screenX, 50.0);
	colorBar = [[NSView alloc] initWithFrame:colorBarRect];
	[colorBar setWantsLayer: YES];	colorBarLayer = colorBar.layer;
	colorBarLayer.frame = NSRectToCGRect(colorBarRect);
	[mainC addSubview:colorBar];
	//arrivalBar
	arrivalBarRect = NSMakeRect(0.0, (screen.size.height - 100.0), screen.size.width, 100.0);	
	arrivalBar = [[NSView alloc] initWithFrame:arrivalBarRect];
	[arrivalBar setWantsLayer: YES];	arrivalBarLayer = arrivalBar.layer;
	for (int i=0; i<26; i++) {
		LetterLayer *l = [LetterLayer layer];
		[arrivalBarLayer addSublayer:l];
		[letterLayers addObject:l];
	}
	[mainC addSubview:arrivalBar];


	//	CGColorRef blackColor = CGColorCreateGenericGray(0, 1); rootLayer.backgroundColor = blackColor; CGColorRelease(blackColor);
	//	[rootLayer setBackgroundColor:[[NSColor colorWithDeviceRed:0.0 green:0.0 blue:0.0 alpha:0.0]CGColor]];
	
	//    [self updateSliders];
	[self setInstantText:[NSString stringWithFormat:@"Items: %i", [dbx.appArray count]]];
	[window setInitialFirstResponder:carousel.contentView];

	} return self;
}

//-(void) displayColorsForApp:(DBXApp *)app {		
//		
//	int totes, eligibleBachelors = 0;
//	for (NSNumber *aNumber in app.counts) {		if (aNumber.intValue < 40) continue;	else {	totes += aNumber.intValue;	eligibleBachelors++; 
//	}
//	float buttWidth = (screen.size.width / eligibleBachelors);
//	NSLog(@"ButtonWidth: %f", buttWidth);
//	NSRect wellFrame =	NSMakeRect(0.0,0.0,buttWidth, 50.0);
//	for ( int k = 0; k < eligibleBachelors; k++) {	
//		NSView *new = [[NSView alloc] initWithFrame:wellFrame];
//		CALayer *swatch = [CALayer layer];
//		swatch.frame = NSRectToCGRect(wellFrame);
//		[swatch setBackgroundColor:[app cgColorAtIndex:k]];
//		[new setLayer:swatch];	[new setWantsLayer:YES];
//		[colorBar addSubview:new];
////		NSLog(@"Computed cgcolor %@ from %@", [app cgColorAtIndex:k], [app.hexes objectAtIndex:k]);
//		wellFrame.origin.x += buttWidth;
//	}
//	[colorBarLayer setNeedsDisplay];
//	}
//}

- (void)carouselCurrentItemIndexUpdated:(iCarousel *)_carousel{
	
	DBXApp *app = [dbx.appArray objectAtIndex:_carousel.currentItemIndex];
//	[self spellItOut:app.cuteName];
//	[self displayColorsForApp:app];
}	
//	NSLog(@"Carousel index %ld: %@, view: %@. subvies: %@, layer...%@ abd sublayers..%@", _carousel.currentItemIndex, app.cuteName, mainC, mainC.subviews, mainC.layer, mainC.layer.sublayers);	
//	NSDictionary *diction = [NSDictionary dictionaryWithObjectsAndKeys:
//	[NSNumber numberWithInt:_carousel.currentItemIndex], @"index",
//	app.cuteName, @"cuteName",
//	mainC, @"mainC",
//	mainC.subviews, @"mainCsubViews",
//	mainC.layer, @"mainClayer",
//	mainC.layer.sublayers, @"sublayers", nil];	
	
//	[dockCon setContent:diction];
	
//	NSColor *thisColor = [NSColor colorFromHexRGB:[app.color stringByReplacingOccurrencesOfString:@"#" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [app.color length]) ]];
//	if (visibleLabel) [visibleLabel removeFromSuperview]; visibleLabel = [[[NSTextField alloc] init] autorelease];
//	[visibleLabel setBackgroundColor:thisColor];//[NSColor randomColor]];
//	[visibleLabel setBordered:YES];	[visibleLabel setSelectable:YES];
//	[visibleLabel setAlignment:NSCenterTextAlignment];
//	[visibleLabel setFont:[NSFont fontWithName:@"Monaco" size:50]];
//	[visibleLabel setStringValue:app.cuteName];	[visibleLabel sizeToFit];
//	
//	[visibleLabel setFrameOrigin:NSMakePoint(40.,40.)];
//	//	//(([self.window contentView].bounds.size.width - visibleLabel.frame.size.width)/2.0),self.view.bounds.origin.y ) ];
//	[[self.window contentView] addSubview:visibleLabel];
//	}	NSLog(@"primary color: %@  aka %@ maincSuBS: %@", app.color, thisColor , [mainC.layer.sublayers count]);//carousel.layer);
//	}
//	[rootLayer setOpaque:NO];


//	NSUInteger it; it = [self numberOfSlicesInPieChart:pieChart];
//	NSLog(@"Number of slices: %@", it);
	//	int minitotal = 0;
	//	int j, i; 
	//	CGFloat offsetAccumulator; offsetAccumulator = 0.0;
	//	for ( i = 0; i < 10; i++) {		if ( ( [app.hexes count] < 10 ) ) continue; 
	//		minitotal += [[app.counts objectAtIndex:i]intValue]; 
	//	}
	//	for (j=0; j < 10; j++) {
	//		NSString *gex =[app.hexes objectAtIndex:j];
	////		NSLog(@"calcing percent:  %f / %i", divisor, minitotal);
	//		float percent = (float)([[app.counts objectAtIndex:j]floatValue] / minitotal);
	//		NSLog(@"Window: $@", [[[self.window ] frame] size].height);
	//	CGFloat pixels = (float)(self.window.frame.size.height * percent);
	//	NSLog(@"%i %@ with %f pixels %f", minitotal, gex, percent, pixels);
	//	CGFloat offsetAccumulator = ( (j == 0) ? 0.0 : (offsetAccumulator + pixels) );
//}
//}
//	if (visibleLabel) [visibleLabel removeFromSuperview]; visibleLabel = [[[NSTextField alloc] init] autorelease];
//	[visibleLabel setBackgroundColor:[NSColor randomColor]];
//	[visibleLabel setBordered:YES];	[visibleLabel setSelectable:YES];
//	[visibleLabel setAlignment:NSCenterTextAlignment];
//	[visibleLabel setFont:[NSFont fontWithName:@"Monaco" size:50]];
//	[visibleLabel setStringValue:app.cuteName];	[visibleLabel sizeToFit];
//	
//	[visibleLabel setFrameOrigin:NSMakePoint(40.,40.)];
//	//	//(([self.window contentView].bounds.size.width - visibleLabel.frame.size.width)/2.0),self.view.bounds.origin.y ) ];
//	[[self.window contentView] addSubview:visibleLabel];

//- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)aPieChart{
//	NSUInteger it; it = [[aPieChart slices]count];
//	return it;
//}
//- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index;
//- (NSColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index;	//optional



- (void)awakeFromNib
{
	carousel.type = iCarouselTypeCylinder;
	carousel.bounces = YES;
/**This property is used to adjust the offset of the carousel item views relative to the center of the carousel. It defaults to CGSizeZero, meaning that the carousel items are centered. Changing this value moves the carousel items without changing their perspective, i.e. the vanishing point moves with the carousel items, so if you move the carousel items down, it does not appear as if you are looking down on the carousel.*/
	carousel.contentOffset = CGSizeMake(0.,-200.0);
/**This property is used to adjust the user viewpoint relative to the carousel items. It has the opposite effect to adjusting the contentOffset, i.e. if you move the viewpoint up then the carousel appears to move down. Unlike the contentOffset, moving the viewpoint also changes the perspective vanishing point relative to the carousel items, so if you move the viewpoint up, it will appear as if you are looking down on the carousel.*/
	carousel.viewpointOffset = CGSizeMake(0., -200.);
/**Used to tweak the perspective foreshortening effect for the various 3D carousel views. Should be a negative value, less than 0 and greater than -0.01. Values outside of this range will yield very strange results. The default is -1/500, or -0.005;*/
	carousel.perspective = -1.0f/500.0f;
	carousel.scrollSpeed = 2.0f;
	carousel.ignorePerpendicularSwipes = YES;
//	[carousel valueF iCarouselTranformOptionAngle = 44;	carousel.acceptsFirstResponder; // AcceptsFirstResponder:YES];
//	carousel.decelerationRate = 0.95f;	carousel.scrollEnabled = YES; 	carousel.scrollOffset = 0.0f;
//	carousel.offsetMultiplier = 1.0f;	carousel.shouldWrap = YES;
//	carousel.bounceDistance = 1.0f;	carousel.toggle = 0.0f;	carousel.stopAtItemBoundary = YES; 
//	carousel.scrollToItemBoundary = YES;	carousel.useDisplayLink = YES;
	
	[NSApp activateIgnoringOtherApps:YES];
}

	
	//	carousel.//iCarouselTypeCoverFlow2;
//    [self.window makeFirstResponder:carousel];
	
//	textIndex = -1;
//	[window setBackgroundColor:[NSColor colorWithPatternImage:[NSImage imageNamed:@"background"]]];
//	NSView *legend = [[NSView alloc] initWithFrame:NSMakeRect(0.,(screen.size.height /2),(screen.size.height /2),(screen.size.height /2))];
//	legend.wantsLayer = YES;
//	CALayer *legendLayer = legend.layer;
//	[dbx makeGridInView:legend];
	
//	feedURL = [[[NSUserDefaults standardUserDefaults] stringForKey:@"feedURL"] retain];
//	feedTitles = [NSMutableArray new];
//	feed = [[PSFeed alloc] initWithURL:[NSURL URLWithString:feedURL]];
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(feedChanged:) name:PSFeedEntriesChangedNotification object:feed];
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(feedChanged:) name:PSFeedRefreshingNotification object:feed];
//	[feed refresh:NULL];
//	feedTimer = [NSTimer scheduledTimerWithTimeInterval:300 target:self selector:@selector(updateFeed:) userInfo:nil repeats:YES];
//	cycleTimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(showNextEntry:) userInfo:nil repeats:YES];
//	[backButton setWantsLayer:YES];
//	[forwardButton setWantsLayer:YES];
//	[linkButton setWantsLayer:YES];
//	[prefButton setWantsLayer:YES];
//	CIFilter *filter = [CIFilter filterWithName:@"CIBloom"];
//	[filter setDefaults];
//	[filter setValue:[NSNumber numberWithFloat: 5.0] forKey:@"inputRadius"];
//	[filter setName:@"glowFilter"];
//	[[forwardButton layer] setFilters:[NSArray arrayWithObject:filter]];
//	CABasicAnimation *glowAnimation = [CABasicAnimation animationWithKeyPath:@"filters.glowFilter.inputIntensity"];
//	glowAnimation.fromValue = [NSNumber numberWithFloat:0.35];
//	glowAnimation.toValue = [NSNumber numberWithFloat:2.00];
//	glowAnimation.duration = 1.5;
//	glowAnimation.repeatCount = HUGE_VALF;
//	glowAnimation.autoreverses = YES;
//	glowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//	[[forwardButton layer] addAnimation:glowAnimation forKey:@"glowAnimation"];
//	[[backButton layer] setFilters:[NSArray arrayWithObject:filter]];
//	[[backButton layer] addAnimation:glowAnimation forKey:@"glowAnimation"];
//	[[linkButton layer] setFilters:[NSArray arrayWithObject:filter]];
//	[[linkButton layer] addAnimation:glowAnimation forKey:@"glowAnimation"];
//	[[prefButton layer] setFilters:[NSArray arrayWithObject:filter]];
//	[[prefButton layer] addAnimation:glowAnimation forKey:@"glowAnimation"];

/**
- (CGFloat)carousel:(iCarousel *)carousel valueForTransformOption:(iCarouselTranformOption)option withDefault:(CGFloat)value
{
    switch (option)
    {
        case iCarouselTranformOptionArc:
        {
            return 2 * M_PI * arcSlider.floatValue;
        }
        case iCarouselTranformOptionRadius:
        {
            return value * radiusSlider.floatValue;
        }
        case iCarouselTranformOptionAngle:
        {
            return tiltSlider.floatValue;
        }
        case iCarouselTranformOptionSpacing:
        {
			return spacingSlider.floatValue;
        }
        default:
        {
            return value;
        }
    }
}
*/
- (void)spellItOut:(NSString *)text{
	NSString *lowerText = [text lowercaseString];
	int i = 0;
	for (LetterLayer *l in letterLayers) {
		NSString *currentLetter;
		if (i > [lowerText length] - 1)
			currentLetter = @" ";
		else
			currentLetter = [lowerText substringWithRange:NSMakeRange(i,1)];
		[l setTargetLetter:currentLetter];
		i++;
	}
}

- (void)setInstantText:(NSString *)text
{
	NSString *lowerText = [text lowercaseString];
	int i = 0;
	
	for (LetterLayer *l in letterLayers) {
		NSString *currentLetter;
		if (i > [lowerText length] - 1)
			currentLetter = @" ";
		else
			currentLetter = [lowerText substringWithRange:NSMakeRange(i,1)];
		[l setInstantLetter:currentLetter];
		i++;
	}
}










- (void)dealloc
{
	//it's a good idea to set these to nil here to avoid
	//sending messages to a deallocated window or view controller
	carousel.delegate = nil;
	carousel.dataSource = nil;
	
    [carousel release];
    [super dealloc];
}
- (IBAction)switchCarouselType:(id)sender
{
	//restore view opacities to normal
    for (NSView *view in carousel.visibleItemViews)
    {
        view.layer.opacity = 1.0;
    }
	
    carousel.type = (iCarouselType)[sender tag];
}
- (IBAction)toggleVertical:(id)sender
{
    carousel.vertical = !carousel.vertical;
//    [sender setState:carousel.vertical? NSOnState: NSOffState];
}
- (IBAction)toggleWrap:(id)sender
{
    wrap = !wrap;
  //  [sender setState:wrap? NSOnState: NSOffState];
    [carousel reloadData];
}
- (IBAction)insertItem:(id)sender
{
    [carousel insertItemAtIndex:carousel.currentItemIndex animated:YES];
}
- (IBAction)removeItem:(id)sender
{
    [carousel removeItemAtIndex:carousel.currentItemIndex animated:YES];
}
#pragma mark -
#pragma mark iCarousel methods
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
	NSUInteger totes =  dbx.totalItems.intValue;
    return totes;
}



//- (void)mouseUp:(NSEvent *)theEvent
//{
//    NSPoint mouseUpPoint = [self convertWindowPointToImagePoint:[theEvent locationInWindow]];
//    CGFloat epsilonSquared = 0.025;
//    
//    CGFloat dx = __ME_mouseDownPoint.x - mouseUpPoint.x, dy = __ME_mouseDownPoint.y - mouseUpPoint.y;
//    BOOL pointsAreEqual = (dx * dx + dy * dy) < epsilonSquared;
//    
//    CALayer *hitLayer = [self layerAtPoint:mouseUpPoint];
//    
//    if (__ME_state == MEDeletingState && [self allowsDeletingOverlays] && [hitLayer valueForKey:@"MEOverlayObject"]) {
//        id overlayObject = [hitLayer valueForKey:@"MEOverlayObject"];
//        [__ME_overlayDelegate overlayView:self didDeleteOverlay:overlayObject];
//        [__ME_selectedOverlays removeObject:overlayObject];
//        [self removeTrackingArea:[hitLayer valueForKey:@"MEOverlayTrackingArea"]];
//    } else if (__ME_state == MEIdleState && [hitLayer valueForKey:@"MEOverlayObject"]) {
//        if ([self allowsOverlaySelection]) {
//            NSUInteger layerNumber = [[hitLayer valueForKey:@"MEOverlayNumber"] integerValue];
//            DLog(@"checking select with %lu", layerNumber);
//            BOOL multiAttempt = ([theEvent modifierFlags] & NSDeviceIndependentModifierFlagsMask) == NSShiftKeyMask || ([theEvent modifierFlags] & NSDeviceIndependentModifierFlagsMask) == NSCommandKeyMask;
//            if ([self isOverlaySelected:layerNumber]) {
//                if (multiAttempt && ([self numberOfSelectedOverlays] > 1 || [self allowsEmptyOverlaySelection])) {
//                    DLog(@"deselected");
//                    [self deselectOverlay:layerNumber];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:MEOverlayViewSelectionDidChangeNotification object:self];
//                }
//            } else {
//                [self selectOverlayIndexes:[NSIndexSet indexSetWithIndex:layerNumber] 
//                      byExtendingSelection:(multiAttempt && [self allowsMultipleOverlaySelection])];
//                [[NSNotificationCenter defaultCenter] postNotificationName:MEOverlayViewSelectionDidChangeNotification object:self];
//            }
//            DLog(@"current selection: %@", __ME_selectedOverlays);
//            [self drawOverlays];
//        }
//        if (__ME_action || __ME_doubleAction) {
//            __ME_clickedOverlay = [__ME_overlayCache indexOfObject:[hitLayer valueForKey:@"MEOverlayObject"]];
//            DLog(@"click!");
//            DLog(@"__ME_action: %@", NSStringFromSelector(__ME_action));
//            DLog(@"__ME_doubleAction: %@", NSStringFromSelector(__ME_doubleAction));
//            if ([theEvent clickCount] == 1 && __ME_action) {
//                [__ME_target performSelector:__ME_action withObject:nil afterDelay:[NSEvent doubleClickInterval]];
//            } else if ([theEvent clickCount] == 2 && __ME_doubleAction) {
//                DLog(@"Cancelling single click: %@", __ME_singleClickInvocation);
//                [NSRunLoop cancelPreviousPerformRequestsWithTarget:__ME_target];
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//                [__ME_target performSelector:__ME_doubleAction];
//#pragma clang diagnostic pop
//            } else {
//                [super mouseUp:theEvent];
//            }
//        }
//    } else if ((__ME_state == MECreatingState || __ME_state == MEModifyingState) && !pointsAreEqual) {
//        [self draggedFrom:__ME_mouseDownPoint to:mouseUpPoint done:YES];
//    } else {
//        [super mouseUp:theEvent];
//    }
//}


- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    //limit the number of items views loaded concurrently (for performance reasons)
	//	return NUMBER_OF_VISIBLE_ITEMS;
//	NSInteger totesVis = floor([self numberOfItemsInCarousel:carousel] / 2 );
	
    return numberOfItemsInCarousel;
}
- (NSView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(NSView *)view
{
//    NSTextField *label = nil;
    //create new view if no view is available for recycling
	if (view == nil)
	{

		//		NSImage *image = [NSImage imageNamed:@"page.png"];
		NSImage *image = [dbx.imageArray objectAtIndex:index];
       	SimpleView *bgView = [[SimpleView alloc]initWithFrame:NSMakeRect(0,0,image.size.width,image.size.height)];
		bgView.wantsLayer = YES;
		CALayer *bgLayer = bgView.layer;
       	view = [[NSImageView alloc] initWithFrame:NSMakeRect(0,0,(float)dbx.iconSize, (float)dbx.iconSize)];
		
//		image.size.width,image.size.height)] autorelease];
        [view setWantsLayer:YES];
		CALayer *imageLayer = view.layer;
		[imageLayer addSublayer:bgLayer];
//		imageLayer.anchorPoint = view.layer.anchorPoint;
//		imageLayer.bounds = CGRectMake((view.layer.frame.origin.x - 50.0),(view.layer.frame.origin.y -40),(view.layer.frame.size.width * 2),(view.layer.frame.size.height * 2));
//		imageLayer.borderWidth = 20.0;
//		view.layer.borderWidth = 50.0;
//		view.layer.cornerRadius = 8.0;
//		view.layer.masksToBounds = NO;
//		imageLayer.frame.= CGRectMake(0,0,(view.frame.size.width + 100.), (view.frame.size.height + 100.));
//		imageLayer.name = [NSString stringWithFormat:@"image%i",index];
		CGColorRef primary = [[dbx.appArray objectAtIndex:index]cgPrimary];
//		NSLog(@"Primary ref: %@", primary);
		bgLayer.borderColor = primary;
		imageLayer.shadowOffset = CGSizeMake(-10., -10.);
		imageLayer.shadowOpacity = .5;
		imageLayer.shadowColor = [[NSColor blackColor]CGColor];
//		imageLayer.backgroundColor = primary;//[[dbx.appArray objectAtIndex:index]cgPrimary];
		
//		NSLog(@"SuperLayer: %@",[imageLayer superlayer] );
		[(NSImageView *)view setImage:image];
        [(NSImageView *)view setImageScaling:NSImageScaleAxesIndependently];
//		[bgLayer addSublayer:imageLayer];
        
	}
	return view;
}		
				

		
//        label = [[[NSTextField alloc] init] autorelease];
//        [label setBackgroundColor:[NSColor randomColor]];
//        [label setBordered:YES];
//		[label setHidden:YES];
//        [label setSelectable:YES];
//        [label setAlignment:NSCenterTextAlignment];
//        [label setFont:[NSFont fontWithName:[[label font] fontName] size:50]];
//        [[self.window contentView] addSubview:label];
//	}
//	else
//	{
//		label = [[view subviews] lastObject];
//	}
	//set label
	//	NSString *cuteName = [dbx.appArray objectAtIndex:index].cuteName;
	//	NSLog(@"%@", cuteName);
//	DBXApp *app = [dbx.appArray objectAtIndex:index];
//	[label setStringValue:app.cuteName];
	//	[dbx cuteNameAtIndex:index]];
//    [label sizeToFit];
//    [label setFrameOrigin:NSMakePoint(((view.bounds.size.width - label.frame.size.width)/2.0),view.bounds.origin.y ) ];//.size.height - label.frame.size.height)/2.0)];

//- (long long)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
//{
//	//note: placeholder views are only displayed if wrapping is disabled
//	return INCLUDE_PLACEHOLDERS? 2: 0;
//}
/**- (NSView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(long long)index reusingView:(NSView *)view
 {
 NSTextField *label = nil;
 
 //create new view if no view is available for recycling
 if (view == nil)
 {
 NSImage *image = [NSImage imageNamed:@"page.png"];
 view = [[[NSImageView alloc] initWithFrame:NSMakeRect(0,0,image.size.width,image.size.height)] autorelease];
 [(NSImageView *)view setImage:image];
 [(NSImageView *)view setImageScaling:NSImageScaleAxesIndependently];
 
 label = [[[NSTextField alloc] init] autorelease];
 [label setBackgroundColor:[NSColor randomColor]];
 [label setBordered:NO];
 [label setSelectable:YES];
 [label setAlignment:NSCenterTextAlignment];
 [label setFont:[NSFont fontWithName:[[label font] fontName] size:50]];
 [view addSubview:label];
 
 }
 else
 {
 label = [[view subviews] lastObject];
 }
 
 //set label
 [label setStringValue:(index == 0)? @"[": @"]"];
 [label sizeToFit];
 [label setFrameOrigin:NSMakePoint((view.bounds.size.width - label.frame.size.width)/2.0,
 (view.bounds.size.height - label.frame.size.height)/2.0)];
 
 return view;
 }
 */
- (CGFloat)carouselItemWidth:(iCarousel *)carousel{    //usually this should be slightly wider than the item views
    return (1.2 * dbx.iconSize); //ITEM_SPACING;
}
- (CGFloat)carousel:(iCarousel *)carousel itemAlphaForOffset:(CGFloat)offset {
	//set opacity based on distance from camera
    return 1.0f - fminf(fmaxf(offset, 0.0f), 1.0f);
}
- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform {
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);
}
- (BOOL)carouselShouldWrap:(iCarousel *)carousel  { return wrap; }
- (IBAction)reloadCarousel:(id)sender  {    [carousel reloadData]; }


@end
//- (CALayer*) hitTestPoint: (NSPoint)locationInWindow offset: (CGPoint*)outOffset
//{ // I copied this from other sources, I didn't create them
//	CGPoint where = NSPointToCGPoint([self convertPoint: locationInWindow fromView: nil]);
//    where = [self.layer convertPoint: where fromLayer: self.layer];
//	CALayer *layer = [self.layer hitTest: where];
//	if ( layer != self.layer ){
//		CGPoint bitPos = [self.layer convertPoint: layer.position 
//										fromLayer: layer.superlayer];
//		if( outOffset )
//			*outOffset = CGPointMake( bitPos.x-where.x, bitPos.y-where.y);
//		
//		return layer;
//	}
//	else 
//		return nil;
//}
/**
 - (void) mouseDown: (NSEvent*)ev
 {
 CGPoint dragStartPos = ev.locationInWindow;
 //	CALayer *previouslyDraggedLayer = draggingLayer;
 //	draggingLayer = [self view
 //t: dragStartPos offset:nil];
 //&dragOffset]; // this tells me what i'm clicking on, if anything
 dragStartPos = ev.locationInWindow;
 NSLog(@"You clicked, message from mousedow at %f %f", dragStartPos.x, dragStartPos.y);
 
 }
 - (IBAction)reloadCarousel:(id)sender  {    [carousel reloadData]; }


 */
