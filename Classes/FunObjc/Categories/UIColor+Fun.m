//
//  UIColor+Fun.m
//  Dogo-iOS
//
//  Created by Marcus Westin on 6/25/13.
//  Copyright (c) 2013 Flutterby Labs Inc. All rights reserved.
//

#import "UIColor+Fun.h"

UIColor* rgba(NSUInteger r, NSUInteger g, NSUInteger b, CGFloat a) {
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
}
UIColor* rgb(NSUInteger r, NSUInteger g, NSUInteger b) {
    return rgba(r, g, b, 1.0);
}
UIColor* hsva(NSUInteger h, NSUInteger s, NSUInteger v, CGFloat a) {
    return [UIColor colorWithHue:h/360.0 saturation:s/100.0 brightness:v/100.0 alpha:a/100.0];
}
UIColor* hsv(NSUInteger h, NSUInteger s, NSUInteger v) {
    return hsva(h, s, v, 100.0);
}

@implementation UIColor (Fun)

+ (instancetype)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (UIColor *)addHue:(CGFloat)addHue saturation:(CGFloat)addSaturation brightness:(CGFloat)addBrightness {
    CGFloat hue, saturation, brightness, alpha;
    [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    return [UIColor colorWithHue:MIN(hue+addHue, 1.0) saturation:MIN(saturation+addSaturation, 1.0) brightness:MIN(brightness+addSaturation, 1.0) alpha:alpha];
}

- (CGFloat)alpha {
    CGFloat alpha;
    [self getWhite:nil alpha:&alpha];
    return alpha;
}

- (UIColor*)withAlpha:(CGFloat)alpha {
    CGFloat hue, saturation, brightness;
    [self getHue:&hue saturation:&saturation brightness:&brightness alpha:NULL];
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

- (BOOL)hasTransparency {
    return !self.alpha;
}

@end