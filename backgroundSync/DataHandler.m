//
//	DataHandler.m
//	backgroundSync
//
//	Created by Goran Blažič on 05/02/15.
//	Copyright (c) 2015 goranche.net. All rights reserved.
//

#import "DataHandler.h"

@implementation DataHandler

+ (id)sharedHandler {
	static DataHandler *sharedHandler = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedHandler = [self new];
	});
	return sharedHandler;
}

- (NSString *)appDataPath {
	return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"dataFile"];
}

- (void)splitDataToStrings:(NSData *)data {

	NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

	_strings = [string componentsSeparatedByString:@"\n"];

}

- (instancetype)init {
	if ((self = [super init])) {
		NSData *data = [NSData dataWithContentsOfFile:[self appDataPath]];
		if (data) {
			[self splitDataToStrings:data];
		}
	}
	return self;
}

- (BOOL)fetchData {

	NSURL *url = [NSURL URLWithString:@"http://localhost:8080"];

	NSData *data=[NSData dataWithContentsOfURL:url];

	if (data) {

		[self splitDataToStrings:data];

		[data writeToFile:[self appDataPath] atomically:YES];

	}

	return data != nil;

}

@end
