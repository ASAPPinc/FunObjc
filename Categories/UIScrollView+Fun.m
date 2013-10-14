//
//  UIScrollView+Fun.m
//  ivyq
//
//  Created by Marcus Westin on 10/14/13.
//  Copyright (c) 2013 Flutterby Labs Inc. All rights reserved.
//

#import "UIScrollView+Fun.h"

@implementation UIScrollView (Fun)

- (void)addContentInset:(UIEdgeInsets)add {
    UIEdgeInsets insets = self.contentInset;
    insets.top += add.top;
    insets.bottom += add.bottom;
    insets.left += add.left;
    insets.right += add.right;
    self.contentInset = insets;
}

- (void)addContentInsetTop:(CGFloat)insetTop {
    [self addContentInset:UIEdgeInsetsMake(insetTop, 0, 0, 0)];
}

- (void)addContentInsetBottom:(CGFloat)insetBottom {
    [self addContentInset:UIEdgeInsetsMake(0, 0, insetBottom, 0)];
}

@end
