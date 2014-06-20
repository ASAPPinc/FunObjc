//
//  FunAppDelegate.h
//  Dogo-iOS
//
//  Created by Marcus Westin on 7/13/13.
//  Copyright (c) 2013 Flutterby Labs Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FunViewController.h"
#import "FunObjc.h"

@protocol FunApp <NSObject>

@required
- (void)funAppStyleLabels:(UILabelStyles*)labels buttons:(UIButtonStyles*)buttons textFields:(UITextFieldStyles*)textFields textViews:(UITextViewStyles*)textViews;
- (void)funAppInterfaceWillLoad;
- (UIViewController*)funAppRootViewControllerForFreshLoad;

@optional
- (void)funAppInterfaceDidLoad:(UIWindow*)window;
@end

@interface FunAppDelegate : UIResponder<UIApplicationDelegate>
+ (FunAppDelegate*)instance;
@property (strong, nonatomic) UIWindow *window;
@property id<FunApp>funApp;
@end
