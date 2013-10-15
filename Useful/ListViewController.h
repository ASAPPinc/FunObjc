//
//  ListViewController.h
//  Dogo-iOS
//
//  Created by Marcus Westin on 8/8/13.
//  Copyright (c) 2013 Flutterby Labs Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

typedef NSInteger ListItemIndex;

enum ListViewLocation { TOP=1, BOTTOM=2 };
typedef enum ListViewLocation ListViewLocation;

enum ListViewDirection { UP=-1, DOWN=1 };
typedef enum ListViewDirection ListViewDirection;

@protocol ListViewDelegate <NSObject>
@required
- (id) listItemForIndex:(NSInteger)index;
- (UIView*) listViewForItem:(id)item atIndex:(NSInteger)itemIndex withWidth:(CGFloat)width;
- (void) listSelectItem:(id)item index:(NSInteger)itemIndex view:(UIView*)itemView;
@optional
- (NSInteger) listStartIndex;
- (UIView*) listViewForGroupId:(id)groupId withItem:(id)item withWidth:(CGFloat)width;
- (id) listGroupIdForItem:(id)item;
- (void) listTopGroupViewDidMove:(CGRect)frame;
- (void) listTopGroupDidChange:(id)topGroupItem withDirection:(ListViewDirection)direction;
- (void) listSelectGroupWithId:(id)groupId withItem:(id)item;
- (BOOL) listShouldMoveWithKeyboard;
@end


@interface ListViewController : ViewController <UIScrollViewDelegate>
@property UIScrollView* scrollView;
@property (weak) id<ListViewDelegate> delegate;
@property NSInteger topItemIndex;
@property NSInteger bottomItemIndex;
@property CGFloat previousContentOffsetY;
@property (readonly) id bottomGroupId;
@property (readonly) id topGroupId;
@property CGFloat topY;
@property CGFloat bottomY;
@property UIEdgeInsets groupMargins;
- (void) reloadDataWithStartIndex:(NSInteger)startIndex;
- (void) stopScrolling;

- (void) listAppendItemsStartingAtIndex:(ListItemIndex)firstIndex count:(NSUInteger)count;
@end

// Sample implementation
//- (id)listItemForIndex:(NSInteger)index {
//    return nil;
//}
//
//- (UIView *)listViewForItem:(id)item atIndex:(NSInteger)itemIndex withWidth:(CGFloat)width {
//    return nil;
//}
//
//- (void)listSelectItem:(id)item index:(NSInteger)itemIndex view:(UIView *)itemView {
//    
//}