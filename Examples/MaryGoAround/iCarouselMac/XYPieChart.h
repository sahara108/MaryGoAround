//
//  XYPieChart.h
//  XYPieChart
//
//  Created by XY Feng on 2/24/12.
//  Copyright (c) 2012 Xiaoyang Feng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
//#import <AppKit/AppKit.h>

@class XYPieChart;
@protocol XYPieChartDataSource <NSObject>
@required
- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart;
- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index;
@optional
- (NSColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index;
@end

@protocol XYPieChartDelegate <NSObject>
@optional
- (void)pieChart:(XYPieChart *)pieChart willSelectSliceAtIndex:(NSUInteger)index;
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index;
- (void)pieChart:(XYPieChart *)pieChart willDeselectSliceAtIndex:(NSUInteger)index;
- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index;
@end

@interface XYPieChart : NSView
@property(unsafe_unretained) id<XYPieChartDataSource> dataSource;
@property(unsafe_unretained) id<XYPieChartDelegate> delegate;
//@property(nonatomic, weak) id<XYPieChartDataSource> dataSource;
//@property(nonatomic, weak) id<XYPieChartDelegate> delegate;
@property(nonatomic, assign) CGFloat startPieAngle;
@property(nonatomic, assign) CGFloat animationSpeed;
@property(nonatomic, assign) CGPoint pieCenter;
@property(nonatomic, assign) CGFloat pieRadius;
@property(nonatomic, assign) BOOL    showLabel;
@property(nonatomic, strong) NSFont  *labelFont;
@property(nonatomic, assign) CGFloat labelRadius;
@property(nonatomic, assign) CGFloat selectedSliceStroke;
@property(nonatomic, assign) CGFloat selectedSliceOffsetRadius;
@property(nonatomic, assign) BOOL    showPercentage;
- (id)initWithFrame:(CGRect)frame Center:(CGPoint)center Radius:(CGFloat)radius;
- (void)reloadData;
- (void)setPieBackgroundColor:(NSColor *)color;
@end;
