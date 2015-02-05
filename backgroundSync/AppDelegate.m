//
//	AppDelegate.m
//	backgroundSync
//
//	Created by Goran Blažič on 05/02/15.
//	Copyright (c) 2015 goranche.net. All rights reserved.
//

#import "AppDelegate.h"
#import "DataHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	[application setMinimumBackgroundFetchInterval:30.0f];

	return YES;
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

	NSInteger prevCount = [[[DataHandler sharedHandler] strings] count];

	UIBackgroundFetchResult result = UIBackgroundFetchResultFailed;

	if ([[DataHandler sharedHandler] fetchData]) {

		if (prevCount == [[[DataHandler sharedHandler] strings] count]) {
			// No new data

			result = UIBackgroundFetchResultNoData;

		} else {

			result = UIBackgroundFetchResultNewData;

		}
	}

	completionHandler(result);

}

@end
