//
//  Log.m
//  Dogo-iOS
//
//  Created by Marcus Westin on 6/27/13.
//  Copyright (c) 2013 Flutterby Labs Inc. All rights reserved.
//

#import "Log.h"

@implementation Log

+ (void)event:(NSString *)event data:(NSDictionary *)data {
    NSLog(@"Log: EVENT %@ %@", event, data);
}

+ (id)error:(NSError *)error {
    NSLog(@"Log: ERROR %@", error);
    return nil;
}

@end
