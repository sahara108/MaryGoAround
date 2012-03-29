//
//  ViewController.h
//  XYPieChart
//
//  Created by XY Feng on 2/24/12.
//  Copyright (c) 2012 Xiaoyang Feng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "XYPieChart.h"

@interface XYViewController : NSViewController <XYPieChartDelegate, XYPieChartDataSource>

@property (strong, nonatomic) IBOutlet XYPieChart *pieChart;
//@property (strong, nonatomic) IBOutlet XYPieChart *pieChartLeft;
//@property (strong, nonatomic) IBOutlet UILabel *percentageLabel;
//@property (strong, nonatomic) IBOutlet UILabel *selectedSliceLabel;
@property (assign) NSUInteger *numOfSlices;
//@property (strong, nonatomic) IBOutlet UISegmentedControl *indexOfSlices;
//@property (strong, nonatomic) IBOutlet UIButton *downArrow;
@property(nonatomic, strong) NSMutableArray *slices;
@property(nonatomic, strong) NSArray        *sliceColors;
@end
