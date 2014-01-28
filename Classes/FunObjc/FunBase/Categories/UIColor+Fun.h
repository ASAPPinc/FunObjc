//
//  UIColor+Fun.h
//  Dogo-iOS
//
//  Created by Marcus Westin on 6/25/13.
//  Copyright (c) 2013 Flutterby Labs Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WHITE [UIColor whiteColor]
#define YELLOW [UIColor yellowColor]
#define TRANSPARENT [UIColor clearColor]
#define BLACK [UIColor blackColor]
#define RED [UIColor redColor]
#define GREEN [UIColor greenColor]
#define BLUE [UIColor blueColor]
#define RANDOM_COLOR [UIColor randomColor]
UIColor* rgba(CGFloat r, CGFloat g, CGFloat b, CGFloat a);
UIColor* rgb(CGFloat r, CGFloat g, CGFloat b);
UIColor* hsva(CGFloat h, CGFloat s, CGFloat v, CGFloat a);
UIColor* hsv(CGFloat h, CGFloat s, CGFloat v);

#define LIGHT_GRAY rgb(230,230,230)
#define STEELBLUE rgb(70,130,180)

@interface UIColor (Fun)

+ (instancetype) randomColor;

- (CGFloat)alpha;
- (UIColor*)withAlpha:(CGFloat)alpha;
- (BOOL)hasTransparency;
- (UIColor*) addHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness;

@end
