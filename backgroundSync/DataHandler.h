//
//	DataHandler.h
//	backgroundSync
//
//	Created by Goran Blažič on 05/02/15.
//	Copyright (c) 2015 goranche.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHandler : NSObject

@property (readonly, nonatomic) NSArray *strings;

+ (id)sharedHandler;

// Will block thread, returns NO if an error occurs, YES otherwise
- (BOOL)fetchData;

@end
