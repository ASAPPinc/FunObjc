//
//  FunFiles.h
//  Dogo-iOS
//
//  Created by Marcus Westin on 6/25/13.
//  Copyright (c) 2013 Flutterby Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Files : NSObject

+ (id)readJsonDocument:(NSString*)filename;
+ (id)readJsonDocument:(NSString*)filename property:(NSString*)property;
+ (void)writeJsonDocument:(NSString*)filename data:(id)data;
+ (void)writeJsonDocument:(NSString*)filename property:(NSString*)property data:(id)data;
+ (NSData*)readDocument:(NSString*)filename;
+ (NSData*)readCache:(NSString*)filename;
+ (BOOL)writeDocument:(NSString*)filename data:(NSData*)data;
+ (BOOL)writeCache:(NSString*)filename data:(NSData*)data;
+ (NSString*)cachePath:(NSString*)filename;
+ (NSString*)documentPath:(NSString*)filename;
+ (BOOL)removeDocument:(NSString*)name;
+ (BOOL)removeCache:(NSString*)name;

+ (NSData*)readResource:(NSString*)name;
+ (NSData*)readResource:(NSString*)resourceName ofType:(NSString*)type;

+ (void)resetFileRoot;

@end
