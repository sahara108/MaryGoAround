//
//  AGColorCounter.m
//  DBXCollection
//
//  Created by Alex Gray on 3/18/12.
//  Copyright (c) 2012 mrgray.com, inc. All rights reserved.
//

#import "AGColorCounter.h"

@implementation AGColorCounter
@synthesize phpPath, scriptPath, jsonObject;

- (NSArray *)getColorsforImage:(NSImage *)image {
	scriptPath = [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"colors.base64.php"];
	phpPath = [NSString stringWithString:@"/usr/bin/php"];
	
	NSData *imageData = [self dataFromImage:image];
	NSString *base64Image = [imageData base64EncodedString];
//	NSLog(@"base64 image: %@", base64Image);
	NSTask *php = [[NSTask alloc] init];	NSPipe *pipe = [[NSPipe alloc] init]; NSFileHandle *handle; NSString *string;
	[php setLaunchPath:@"/usr/bin/php"];
	
	[php setArguments:[NSArray arrayWithObjects:@"-f", scriptPath, base64Image, nil]];
	[php setStandardOutput:pipe];		handle=[pipe fileHandleForReading];		[php launch];
	string = [[NSString alloc] initWithData:[handle readDataToEndOfFile] encoding:NSASCIIStringEncoding]; 
	//	string = [[NSString alloc] initWithData:[handle readDataToEndOfFile] encoding:NSASCIIStringEncoding]; 
	NSLog(@"string: %@",string);
	self.jsonObject = [string JSONValue]; //JSONValue];
	NSLog(@"jsonObject: %@  a member of class: %@",self.jsonObject, [self.jsonObject className]);
	if ( [self.jsonObject isKindOfClass:NSClassFromString(@"NSArray")] )  {
		return jsonObject;
	}else {
		return nil;
	}
	
}


//- (void) loadImage:(NSImage*)image {
//	
//	//	[image setSize:NSMakeSize(10.0f, 10.0f)];
//	NSData *finalData = [self dataFromImage:image];	
//	[[webView mainFrame] loadData:finalData MIMEType:@"image/png" textEncodingName:nil baseURL:nil];
//}

- (NSData *) dataFromImage: (NSImage *)image {
	
	NSData *imageData = [image TIFFRepresentation];
	NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
	return [imageRep representationUsingType:NSPNGFileType properties:nil];
}



@end
