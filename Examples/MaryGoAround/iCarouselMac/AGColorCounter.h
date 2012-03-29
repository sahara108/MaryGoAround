//
//  AGColorCounter.h
//  DBXCollection
//
//  Created by Alex Gray on 3/18/12.
//  Copyright (c) 2012 mrgray.com, inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "/sd/COCOA/NSData+Base64.h"
#import "SBJSON.h"

@interface AGColorCounter : NSObject
{
	NSString		*phpPath;
	NSString		*scriptPath;
	id				jsonObject;
	NSArray			*colorArray;
	SBJSON		 	*jsonParser;

}

@property (strong) NSString *scriptPath;
@property (strong) NSString *phpPath;
@property (assign) id jsonObject;

- (NSArray *)getColorsforImage:(NSImage *)image;

@end
