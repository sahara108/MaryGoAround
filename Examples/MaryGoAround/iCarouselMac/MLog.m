//
//  MLog.m
//  Originally by AgentM.  This code is in the public domain.
//  http://borkware.com/rants/agentm/mlog/



#import "MLog.h"
#ifndef NDEBUG
#import <Foundation/Foundation.h>
#import <stdio.h>
extern void _NSSetLogCStringFunction(void (*)(const char *string, unsigned length, BOOL withSyslogBanner));

static void PrintNSLogMessage(const char *string, unsigned length, BOOL withSyslogBanner){
	puts(string);
}

static void HackNSLog(void) __attribute__((constructor));
static void HackNSLog(void){
	_NSSetLogCStringFunction(PrintNSLogMessage);
}
#endif


static BOOL __MLogOn = NO;

@implementation MLog

+ (void) initialize {
	char * env = getenv("MLogOn");
	
	if (strcmp(env == NULL ? "" : env, "NO") != 0)
		__MLogOn = YES;
}


+ (void) logFile: (char *) sourceFile lineNumber: (int) lineNumber format: (NSString *) format, ...; {
	
	va_list ap;
	
	NSString *print, *file;
	
	if (__MLogOn == NO)
		return;
	
	va_start(ap, format);
	
	file  = [[NSString alloc] initWithBytes: sourceFile 
									 length: strlen(sourceFile) 
								   encoding: NSUTF8StringEncoding];
	
	print = [[NSString alloc] initWithFormat:format arguments: ap];
	
	va_end(ap);
	
	// NSLog handles synchronization issues
	NSLog(@"%s: %d %@", [[file lastPathComponent] UTF8String], lineNumber, print);
	
//	[print release];
//	[file  release];
	
	return;
}


+ (void) setLogOn: (BOOL) logOn {
	
	__MLogOn = logOn;
}

@end
