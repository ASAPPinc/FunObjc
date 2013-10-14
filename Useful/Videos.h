//
//  Videos.h
//  Dogo-iOS
//
//  Created by Marcus Westin on 7/1/13.
//  Copyright (c) 2013 Flutterby Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FunTypes.h"

@interface Videos : NSObject

+ (instancetype)playVideo:(NSString*)url fromView:(UIView*)view callback:(StringErrorCallback)callback;

@end
