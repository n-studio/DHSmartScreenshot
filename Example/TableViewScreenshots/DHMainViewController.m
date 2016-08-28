//
//  DHMainViewController.m
//  TableViewScreenshots
//
//  Created by Hernandez Alvarez, David on 11/28/13.
//  Copyright (c) 2013 David Hernandez. All rights reserved.
//

#import "DHMainViewController.h"
#import "DHSmartScreenshot.h"

@interface DHMainViewController ()
@property (strong, nonatomic) NSArray *screenshotsTaken;
@end

@implementation DHMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	self.screenshotsTaken = @[];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Take Screenshot Examples

- (void)takeFullScreenshot
{
	self.screenshotsTaken = @[[self.tableView screenshot]];
}

- (void)takeScreenshotWithoutHeaders
{
	self.screenshotsTaken = @[[self.tableView screenshotExcludingAllHeaders:YES
													 excludingAllFooters:NO
														excludingAllRows:NO]];
}

- (void)takeScreenshotWithoutFooters
{
	self.screenshotsTaken = @[[self.tableView screenshotExcludingAllHeaders:NO
													 excludingAllFooters:YES
														excludingAllRows:NO]];
}

- (void)takeScreenshotForRowsOnly
{
	self.screenshotsTaken = @[[self.tableView screenshotExcludingAllHeaders:YES
													 excludingAllFooters:YES
														excludingAllRows:NO]];
}

- (void)takeScreenshotForRowAtIndexPath:(NSIndexPath *)indexPath
{
	self.screenshotsTaken = @[[self.tableView screenshotOfCellAtIndexPath:indexPath]];
}

-(void)takeScreenshotOfVisibleContent{
    self.screenshotsTaken = @[[self.tableView screenshotOfVisibleContent]];
}

- (void)takeScreenshotWithoutFirstHeader
{
	NSArray *excludedHeadersSections = @[@(0)];
	self.screenshotsTaken = @[[self.tableView screenshotExcludingHeadersAtSections:[NSSet setWithArray:excludedHeadersSections]
													 excludingFootersAtSections:nil
													  excludingRowsAtIndexPaths:nil]];
}

- (void)takeScreenshoOfJustLastTwoFooters
{
	NSArray *includeFootersSections = @[@(self.tableView.numberOfSections - 2), @(self.tableView.numberOfSections - 1)];
	self.screenshotsTaken = @[[self.tableView screenshotOfHeadersAtSections:nil
													   footersAtSections:[NSSet setWithArray:includeFootersSections] rowsAtIndexPaths:nil]];
}

- (void)takeScreenshotForJustRowsOnThisSection:(NSUInteger)section
{
	NSArray *includedRows = nil;
	includedRows = [self.tableView indexPathsForRowsInRect:[self.tableView rectForSection:section]];
	self.screenshotsTaken = @[[self.tableView screenshotOfHeadersAtSections:nil
													   footersAtSections:nil
														rowsAtIndexPaths:[NSSet setWithArray:includedRows]]];
}

- (void)takeScreenshotsForA4Pages
{
    self.screenshotsTaken = [self.tableView screenshotPagesWithAspectRatio:29.7/21.0];
}

- (void)takeScreenshotForComplexUse
{
	NSMutableArray *includedRows = [NSMutableArray array];
	[includedRows addObject:[NSIndexPath indexPathForRow:0 inSection:0]];
	[includedRows addObject:[NSIndexPath indexPathForRow:0 inSection:1]];
	[includedRows addObject:[NSIndexPath indexPathForRow:0 inSection:2]];
	
	NSMutableArray *includedHeadersSections = [NSMutableArray array];
	[includedHeadersSections addObject:@(0)];
	[includedHeadersSections addObject:@(1)];
	[includedHeadersSections addObject:@(3)];
	
	NSMutableArray *includedFootersSections = [NSMutableArray array];
	[includedFootersSections addObject:@(0)];
	[includedFootersSections addObject:@(1)];
	[includedFootersSections addObject:@(2)];
	[includedFootersSections addObject:@(4)];
	
	self.screenshotsTaken = @[[self.tableView screenshotOfHeadersAtSections:[NSSet setWithArray:includedHeadersSections]
													footersAtSections:[NSSet setWithArray:includedFootersSections]
														rowsAtIndexPaths:[NSSet setWithArray:includedRows]]];
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) {
		if (indexPath.row == 0) {
			[self takeFullScreenshot];
		} else if (indexPath.row == 1) {
			[self takeScreenshotWithoutHeaders];
		} else if (indexPath.row == 2) {
			[self takeScreenshotWithoutFooters];
		} else if (indexPath.row == 3) {
			[self takeScreenshotForRowsOnly];
		} else if (indexPath.row == 4) {
			[self takeScreenshotForRowAtIndexPath:indexPath];
        } else if (indexPath.row == 5) {
            [self takeScreenshotOfVisibleContent];
        }
	} else if (indexPath.section == 1) {
		if (indexPath.row == 0) {
			[self takeScreenshotWithoutFirstHeader];
		} else if (indexPath.row == 1) {
			[self takeScreenshoOfJustLastTwoFooters];
		} else if (indexPath.row == 2) {
			[self takeScreenshotForJustRowsOnThisSection:indexPath.section];
        } else if (indexPath.row == 3) {
            [self takeScreenshotsForA4Pages];
        }
	} else if (indexPath.section == 2) {
		[self takeScreenshotForComplexUse];
	} else {
		[self takeFullScreenshot];
	}
	[self performSegueWithIdentifier:@"showTableViewScreenshotSegue_Id" sender:self];
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([[segue identifier] isEqualToString:@"showTableViewScreenshotSegue_Id"]) {
		UIViewController *destination = [segue destinationViewController];
		[destination setValue:self.screenshotsTaken forKey:@"screenshots"];
	}
}

@end
