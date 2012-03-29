//
//  ViewController.m
//  XYPieChart
//
//  Created by XY Feng on 2/24/12.
//  Copyright (c) 2012 Xiaoyang Feng. All rights reserved.
//

#import "XYViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation XYViewController

@synthesize pieChart = _pieChart;
//@synthesize pieChartLeft = _pieChartCopy;
//@synthesize percentageLabel = _percentageLabel;
//@synthesize selectedSliceLabel = _selectedSlice;
@synthesize numOfSlices = _numOfSlices;
//@synthesize indexOfSlices = _indexOfSlices;
//@synthesize downArrow = _downArrow;
@synthesize slices = _slices;
@synthesize sliceColors = _sliceColors;

#pragma mark - View lifecycle

/**
- (void)loadView {  //    [super viewDidLoad];
    self.slices = [NSMutableArray arrayWithCapacity:10];
    for(int i = 0; i < 5; i ++)
    {
        NSNumber *one = [NSNumber numberWithInt:rand()%60+20];
        [_slices addObject:one];
    }
    
	[self.pieChart setFrame:CGRectMake(299,299., 300, 300)];
	//mainC.frame Center:CGPointMake((screenX/2.0), (screen.size.height/2.0)) Radius:100.];
    
    [self.pieChart setDataSource:self];
    [self.pieChart setStartPieAngle:M_PI_2];
    [self.pieChart setAnimationSpeed:1.0];
	//    [pieChart setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];
	//    [pieChart setLabelRadius:160];
	//    [pieChart setShowPercentage:YES];
	//    [self.pieChartLeft setPieBackgroundColor:[NSColor colorWithWhite:0.95 alpha:1]];
	[self.pieChart setPieCenter:CGPointMake(100, 100)];
//    pieChart.slices = app.counts.copy;
//    for(NSNumber *slice in app.counts)  {
//		//        NSNumber *one = [NSNumber numberWithInt:rand()%60+20];
//        [slices addObject:slice];
//    }
//    [self.percentageLabel.layer setCornerRadius:90];
    
    self.sliceColors =[NSArray arrayWithObjects:
                       [CIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                       [CIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                       [CIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                       [CIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1], 
                       [NSColor colorWithDeviceRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
    
    //rotate up arrow
//    self.downArrow.transform = CGAffineTransformMakeRotation(M_PI);
//}
//
//- (void)loadView {
//    [self setPieChartLeft:nil];
//    [self setPieChartRight:nil];
//    [self setPercentageLabel:nil];
//    [self setSelectedSliceLabel:nil];
//    [self setIndexOfSlices:nil];
//    [self setNumOfSlices:nil];
//    [self setDownArrow:nil];
//    [super viewDidUnload];
}
//
//- (void)viewWill :(BOOL)animated
//{
//    [super viewWillAppear:animated];
//}

- (void) awakeFromNib
//DidAppear:(BOOL)animated
{
//    [super viewDidAppear:animated];
    [self.pieChart reloadData];
//    [self.pieChartRight reloadData];
}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//	[super viewWillDisappear:animated];
//}
//
//- (void)viewDidDisappear:(BOOL)animated
//{
//	[super viewDidDisappear:animated];
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
//}

- (IBAction)SliceNumChanged:(id)sender 
{
//    NSButton *btn = (NSButton *)sender;
//    NSInteger num = self.numOfSlices.text.intValue;
//    if(btn.tag == 100 && num > -10)
//        num = num - ((num == 1)?2:1);
//    if(btn.tag == 101 && num < 10)
//        num = num + ((num == -1)?2:1);
    
//    self.numOfSlices.text = [NSString stringWithFormat:@"%d",num];
}

- (void)clearSlices {
    [_slices removeAllObjects];
//    [self.pieChartLeft reloadData];
    [self.pieChart reloadData];
}
/**
//- (IBAction)addSliceBtnClicked:(id)sender 
-(void) addSlice {
    NSInteger num = [self.numOfSlices.text intValue];
    if (num > 0) {
        for (int n=0; n < abs(num); n++) 
        {
            NSNumber *one = [NSNumber numberWithInt:rand()%60+20];
            NSInteger index = 0;
            if(self.slices.count > 0)
            {
                switch (self.indexOfSlices.selectedSegmentIndex) {
                    case 1:
                        index = rand()%self.slices.count;
                        break;
                    case 2:
                        index = self.slices.count - 1;
                        break;
                }
            }
            [_slices insertObject:one atIndex:index];
        }
    }
    else if (num < 0)
    {
        if(self.slices.count <= 0) return;
        for (int n=0; n < abs(num); n++) 
        {
            NSInteger index = 0;
            if(self.slices.count > 0)
            {
                switch (self.indexOfSlices.selectedSegmentIndex) {
                    case 1:
                        index = rand()%self.slices.count;
                        break;
                    case 2:
                        index = self.slices.count - 1;
                        break;
                }
                [_slices removeObjectAtIndex:index];
            }
        }
    }
    [self.pieChartLeft reloadData];
    [self.pieChartRight reloadData];
}*/

- (void)updateSlices
{
    for(int i = 0; i < _slices.count; i ++)
    {
        [_slices replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:rand()%60+20]];
    }
//    [self.pieChartLeft reloadData];
    [self.pieChart reloadData];
}

//- (IBAction)showSlicePercentage:(id)sender {
//    UISwitch *perSwitch = (UISwitch *)sender;
//    [self.pieChartRight setShowPercentage:perSwitch.isOn];
//}

#pragma mark - XYPieChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return self.slices.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[self.slices objectAtIndex:index] intValue];
}

- (NSColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    if(pieChart == self.pieChart) return nil;
    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
}
/**
#pragma mark - XYPieChart Delegate
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did select slice at index %d",index);
    self.selectedSliceLabel.text = [NSString stringWithFormat:@"$%@",[self.slices objectAtIndex:index]];
}*/

@end
