//
//	MainViewController.m
//	backgroundSync
//
//	Created by Goran Blažič on 05/02/15.
//	Copyright (c) 2015 goranche.net. All rights reserved.
//

#import "MainViewController.h"
#import "DataHandler.h"
#import "MBProgressHUD.h"

@interface MainViewController ()
@property (strong, nonatomic) NSArray *strings;
@property (strong, nonatomic) MBProgressHUD *progressHUD;
@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
	_progressHUD = [[MBProgressHUD alloc] initWithWindow:mainWindow];
	_progressHUD.dimBackground = YES;
	[mainWindow addSubview:self.progressHUD];

	_strings = [[DataHandler sharedHandler] strings];
}

- (IBAction)refreshData:(UIBarButtonItem *)sender {

	[_progressHUD showAnimated:YES whileExecutingBlock:^(){

		if ([[DataHandler sharedHandler] fetchData]) {

			_strings = [[DataHandler sharedHandler] strings];

			[self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];

		}

	}];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _strings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *dequeID = @"bgSync";

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dequeID];

	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeID];
	}

	cell.textLabel.text = _strings[indexPath.row];

	return cell;
}

@end
