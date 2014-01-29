//
//  State.h
//  ivyq
//
//  Created by Marcus Westin on 9/22/13.
//  Copyright (c) 2013 Flutterby Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FunBase.h"

@protocol StateInflateDeflate <NSObject>
+ (NSDictionary*)inflateDeflateMap;
@end

@interface State : NSObject <NSCoding>
+ (instancetype) withDict:(NSDictionary*)dict;
+ (instancetype) fromDict:(NSDictionary*)dict;
+ (instancetype) fromJson:(NSString*)json;
- (BOOL)archiveToDocument:(NSString*)archiveDocName;
- (NSDictionary*)toDictionary;
- (void)mergeDict:(NSDictionary*)dict;
+ (instancetype)fromArchiveDocument:(NSString*)archiveDocName;
- (instancetype) copyWithDictionary:(NSDictionary*)dict;
- (void)setDefaults;
@end
