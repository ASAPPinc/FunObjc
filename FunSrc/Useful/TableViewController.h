//
//  TableViewController.h
//  Dogo-iOS
//
//  Created by Marcus Westin on 7/1/13.
//  Copyright (c) 2013 Flutterby Labs Inc. All rights reserved.
//

#import "FunViewController.h"

@protocol TableViewDelegate <NSObject>
@required
- (void)renderItem:(id)item inCell:(UITableViewCell*)cell width:(CGFloat)width height:(CGFloat)height;
- (void)renderHeader:(NSInteger)section inView:(UIView*)view width:(CGFloat)width height:(CGFloat)height;
- (CGFloat)heightForItem:(id)item width:(CGFloat)width;
- (CGFloat)heightForHeader:(NSUInteger)index;
- (NSArray*)loadItems;
- (NSArray*)loadSectionCounts;
- (void)selectItem:(id)item cell:(UITableViewCell*)cell;
- (BOOL)shouldHighlightItem:(id)item;
@end

typedef void (^ForEachIndexBlock)(NSUInteger rowIndex);

@interface TableViewController : FunViewController <UITableViewDataSource, UITableViewDelegate>
@property UITableView* tableView;
@property NSUInteger sectionCount;
@property NSUInteger* rowCountsPerSection;
@property NSUInteger* rowCountsBeforeSection;
@property NSUInteger* rowHeights;
@property NSUInteger* headerHeights;
@property NSArray* items;
@property NSObject<TableViewDelegate>* delegate;

- (NSUInteger)indexForPath:(NSIndexPath*)indexPath;
- (void)forEachRowIndexInSection:(NSUInteger)section block:(ForEachIndexBlock)block;
- (id)firstItemInSection:(NSUInteger)section;
- (id)lastItemInSection:(NSUInteger)section;

- (id)itemForPath:(NSIndexPath*)indexPath;
- (void)scrollToBottomAnimated:(BOOL)animated;
- (void)scrollToSection:(NSUInteger)section animated:(BOOL)animated;
@end
