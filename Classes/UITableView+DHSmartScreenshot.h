//
//  UITableView+DHSmartScreenshot.h
//  TableViewScreenshots
//
//  Created by Hernandez Alvarez, David on 11/28/13.
//  Copyright (c) 2013 David Hernandez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (DHSmartScreenshot)

- (UIImage *)screenshot;

- (NSArray *)screenshotPagesWithAspectRatio:(CGFloat)ratio;

- (UIImage *)screenshotOfCellAtIndexPath:(NSIndexPath *)indexPath;

- (UIImage *)screenshotOfHeaderViewAtSection:(NSUInteger)section;

- (UIImage *)screenshotOfFooterViewAtSection:(NSUInteger)section;

- (UIImage *)screenshotExcludingAllHeaders:(BOOL)withoutHeaders
					   excludingAllFooters:(BOOL)withoutFooters
						  excludingAllRows:(BOOL)withoutRows;

- (UIImage *)screenshotExcludingHeadersAtSections:(NSSet *)headerSections
					   excludingFootersAtSections:(NSSet *)footerSections
						excludingRowsAtIndexPaths:(NSSet *)indexPaths;

- (NSArray *)screenshotPagesExcludingHeadersAtSections:(NSSet *)headerSections
                       excludingFootersAtSections:(NSSet *)footerSections
                        excludingRowsAtIndexPaths:(NSSet *)indexPaths
                                        withRatio:(CGFloat)ratio;

- (UIImage *)screenshotOfHeadersAtSections:(NSSet *)headerSections
						 footersAtSections:(NSSet *)footerSections
						  rowsAtIndexPaths:(NSSet *)indexPaths;

@end

