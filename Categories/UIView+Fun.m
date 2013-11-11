//
//  UIView+Fun.m
//  ivyq
//
//  Created by Marcus Westin on 9/10/13.
//  Copyright (c) 2013 Flutterby Labs Inc. All rights reserved.
//

#import "UIView+Fun.h"
#import "FunObjc.h"

@class FunBlurView;

@implementation UIView (Fun)
/* Size
 ******/
- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}
- (CGFloat)width {
    return CGRectGetWidth(self.frame);
}
- (CGSize)size {
    return self.frame.size;
}
- (void)setWidth:(CGFloat)width {
    [self setSize:CGSizeMake(width, self.height)];
}
- (void)setHeight:(CGFloat)height {
    [self setSize:CGSizeMake(self.width, height)];
}
- (void)setHeightUp:(CGFloat)height {
    CGFloat dh = self.height - height;
    self.height = height;
    self.y += dh;
}
- (void)setSize:(CGSize)size {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}
- (void)resizeByAddingWidth:(CGFloat)width height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height += height;
    frame.size.width += width;
    self.frame = frame;
}
- (void)resizeBySubtractingWidth:(CGFloat)width height:(CGFloat)height {
    [self resizeByAddingWidth:-width height:-height];
}
- (void)containSubviews {
    CGPoint move = CGPointZero;
    for (UIView* view in self.subviews) {
        CGRect subFrame = view.frame;
        if (subFrame.origin.x < move.x) {
            move.x = subFrame.origin.x;
        }
        if (subFrame.origin.y < move.y) {
            move.y = subFrame.origin.y;
        }
    }
    [self moveByX:move.x y:move.y];
    CGRect frame = self.frame;
    CGFloat maxX = frame.size.width;
    CGFloat maxY = frame.size.height;
    for (UIView* view in self.subviews) {
        [view moveByX:-move.x y:-move.y];
        if (view.x2 > maxX) {
            maxX = view.x2;
        }
        if (view.y2 > maxY) {
            maxY = view.y2;
        }
    }
    frame.size.width = maxX;
    frame.size.height = maxY;
    self.frame = frame;
}

/* Position
 **********/
- (void)moveByX:(CGFloat)dx y:(CGFloat)dy {
    CGRect frame = self.frame;
    frame.origin.x += dx;
    frame.origin.y += dy;
    self.frame = frame;
}
- (void)moveByX:(CGFloat)x {
    [self moveByX:x y:0];
}
- (void)moveByY:(CGFloat)y {
    [self moveByX:0 y:y];
}
- (void)moveToX:(CGFloat)x y:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.x = x;
    frame.origin.y = y;
    self.frame = frame;
}
- (void)moveToY:(CGFloat)y {
    [self moveToX:self.frame.origin.x y:y];
}
- (void)moveToX:(CGFloat)x {
    [self moveToX:x y:self.frame.origin.y];
}
- (void)moveToPosition:(CGPoint)origin {
    [self moveToX:origin.x y:origin.y];
}
- (void)moveByVector:(CGPoint)vector {
    CGPoint newOrigin = self.frame.origin;
    newOrigin.x += vector.x;
    newOrigin.y += vector.y;
    [self moveToPosition:newOrigin];
}
- (void)centerVertically {
    [self moveToY:CGRectGetMidY(self.superview.bounds) - self.height/2];
}
- (void)centerHorizontally {
    [self moveToX:CGRectGetMidX(self.superview.bounds) - self.width/2];
}
- (void)centerView {
    [self centerVertically];
    [self centerHorizontally];
}
- (CGPoint)topRightCorner {
    CGPoint point = self.frame.origin;
    point.x += self.width;
    return point;
}
- (CGFloat)x {
    return CGRectGetMinX(self.frame);
}
- (CGFloat)y {
    return CGRectGetMinY(self.frame);
}
- (CGFloat)x2 {
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)y2 {
    return CGRectGetMaxY(self.frame);
}
- (void)setX:(CGFloat)x {
    [self moveToX:x];
}
- (void)setY:(CGFloat)y {
    [self moveToY:y];
}
- (void)setX2:(CGFloat)x2 {
    [self moveToX:x2 - self.width];
}
- (void)setY2:(CGFloat)y2 {
    [self moveToY:y2 - self.height];
}
- (CGRect)frameInWindow {
    return [self convertRect:self.bounds toView:self.window];
}
- (CGRect)frameOnScreen {
    CGRect frame = self.frame;
    UIView* view = self;
    while ((view = view.superview) != nil) {
        frame.origin.x += view.x;
        frame.origin.y += view.y;
        if ([view isKindOfClass:UIScrollView.class]) {
            CGPoint offset = ((UIScrollView*)view).contentOffset;
            frame.origin.x -= offset.x;
            frame.origin.y -= offset.y;
        }
    }
    return frame;
}

/* Borders, Shadows & Insets
 ***************************/
- (void)setBorderColor:(UIColor *)color width:(CGFloat)width {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

- (void)setGradientColors:(NSArray *)colors {
    CAGradientLayer* gradient = [CAGradientLayer layer];
    CALayer* layer = self.layer;
    gradient.frame = layer.bounds;
    gradient.colors = [colors map:^id(UIColor* color, NSUInteger i) {
        return (id)color.CGColor;
    }];
    //    gradient.locations = [colors map:^id(id val, NSUInteger i) {
    //        return numf(((CGFloat) i) / (colors.count - 1));
    //    }];
    gradient.cornerRadius = self.layer.cornerRadius;
    [layer insertSublayer:gradient atIndex:0];
}

- (void)setOutsetShadowColor:(UIColor *)color radius:(CGFloat)radius {
    return [self setOutsetShadowColor:color radius:radius spread:0 x:0 y:0];
}
- (void)setInsetShadowColor:(UIColor *)color radius:(CGFloat)radius {
    return [self setInsetShadowColor:color radius:radius spread:0 x:0 y:0];
}

static CGFloat STATIC = 0.5f;
- (void)setOutsetShadowColor:(UIColor *)color radius:(CGFloat)radius spread:(CGFloat)spread x:(CGFloat)offsetX y:(CGFloat)offsetY {
    if (self.clipsToBounds) { NSLog(@"Warning: outset shadow put on view with clipped bounds"); }
    NSArray* colors = @[(id)color.CGColor, (id)[UIColor.clearColor CGColor]];
    
    CAGradientLayer *top = [CAGradientLayer layer];
    top.frame = CGRectMake(0 + offsetX, -radius + offsetY, self.bounds.size.width, spread + radius);
    top.colors = colors;
    top.startPoint = CGPointMake(STATIC, 1.0);
    top.endPoint = CGPointMake(STATIC, 0.0);
    [self.layer insertSublayer:top atIndex:0];
    
    CAGradientLayer *right = [CAGradientLayer layer];
    right.frame = CGRectMake(self.bounds.size.width + radius + offsetX, 0 + offsetY, spread + radius, self.bounds.size.height);
    right.colors = colors;
    right.startPoint = CGPointMake(0.0, STATIC);
    right.endPoint = CGPointMake(1.0, STATIC);
    [self.layer insertSublayer:right atIndex:0];
    
    CAGradientLayer *bottom = [CAGradientLayer layer];
    bottom.frame = CGRectMake(0 + offsetX, self.bounds.size.height + offsetY, self.bounds.size.width, spread + radius);
    bottom.colors = colors;
    bottom.startPoint = CGPointMake(STATIC, 0.0);
    bottom.endPoint = CGPointMake(STATIC, 1.0);
    [self.layer insertSublayer:bottom atIndex:0];
    
    CAGradientLayer *left = [CAGradientLayer layer];
    left.frame = CGRectMake(-radius + offsetX, 0 + offsetY, spread + radius, self.bounds.size.height);
    left.colors = colors;
    left.startPoint = CGPointMake(1.0, STATIC);
    left.endPoint = CGPointMake(0.0, STATIC);
    [self.layer insertSublayer:left atIndex:0];
}

- (void)setInsetShadowColor:(UIColor*)color radius:(CGFloat)radius spread:(CGFloat)spread x:(CGFloat)offsetX y:(CGFloat)offsetY {
    NSArray* colors = @[(id)color.CGColor, (id)[UIColor.clearColor CGColor]];
    
    CAGradientLayer *top = [CAGradientLayer layer];
    top.frame = CGRectMake(0 + offsetX, 0 + offsetY, self.bounds.size.width, spread + radius);
    top.colors = colors;
    top.startPoint = CGPointMake(STATIC, 0.0);
    top.endPoint = CGPointMake(STATIC, 1.0);
    [self.layer insertSublayer:top atIndex:0];
    
    CAGradientLayer *right = [CAGradientLayer layer];
    right.frame = CGRectMake(self.bounds.size.width - radius + offsetX, 0 + offsetY, spread + radius, self.bounds.size.height);
    right.colors = colors;
    right.startPoint = CGPointMake(1.0, STATIC);
    right.endPoint = CGPointMake(0.0, STATIC);
    [self.layer insertSublayer:right atIndex:0];
    
    CAGradientLayer *bottom = [CAGradientLayer layer];
    bottom.frame = CGRectMake(0 + offsetX, self.bounds.size.height - radius + offsetY, self.bounds.size.width, spread + radius);
    bottom.colors = colors;
    bottom.startPoint = CGPointMake(STATIC, 1.0);
    bottom.endPoint = CGPointMake(STATIC, 0.0);
    [self.layer insertSublayer:bottom atIndex:0];
    
    CAGradientLayer *left = [CAGradientLayer layer];
    left.frame = CGRectMake(0 + offsetX, 0 + offsetY, spread + radius, self.bounds.size.height);
    left.colors = colors;
    left.startPoint = CGPointMake(0.0, STATIC);
    left.endPoint = CGPointMake(1.0, STATIC);
    [self.layer insertSublayer:left atIndex:0];
}

/* View hierarchy
 ****************/
- (void)empty {
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}
- (void)appendTo:(UIView *)superview {
    [superview addSubview:self];
}
- (void)prependTo:(UIView *)superview {
    [superview insertSubview:self atIndex:0];
}

/* Screenshot
 ************/
- (UIImage *)captureToImage {
    return [self captureToImageWithScale:0.0];
}
- (UIImage *)captureToImageWithScale:(CGFloat)scale {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
- (NSData *)captureToJpgData:(CGFloat)compressionQuality {
    return UIImageJPEGRepresentation([self captureToImage], compressionQuality);
}
- (NSData *)captureToPngData {
    return UIImagePNGRepresentation([self captureToImage]);
}
- (UIView*)ghost {
    UIImage* ghostImage = [self captureToImage];
    UIImageView* ghostView = [UIImageView.appendTo(self.window).frame([self frameInWindow]) render];
    ghostView.image = ghostImage;
    return ghostView;
}
- (void)ghostWithDuration:(NSTimeInterval)duration animation:(ViewCallback)animationCallback {
    [self ghostWithDuration:duration animation:animationCallback completion:^(NSError *err, UIView *ghostView) {
        [ghostView removeFromSuperview];
    }];
}
- (void)ghostWithDuration:(NSTimeInterval)duration animation:(ViewCallback)animationCallback completion:(ViewCallback)completionCallback {
    UIView* ghostView = self.ghost;
    [UIView animateWithDuration:duration animations:^{
        animationCallback(nil, ghostView);
    } completion:^(BOOL finished) {
        completionCallback(nil, ghostView);
    }];
}

/* Animations
 ************/
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations {
    return [UIView animateWithDuration:duration delay:delay options:options animations:animations completion:nil];
}
@end

// Blur effect
//////////////
@interface FunBlurView : UIView
@property UIToolbar *toolbar;
@end
@implementation FunBlurView
- (id)initWithSuperview:(UIView*)view color:(UIColor*)color {
    self = [super initWithFrame:view.bounds];
    self.clipsToBounds = YES; // toolbar draws a thin shadow on top without clip
    if (color) {
        [self.toolbar setBarTintColor:color];
    }
    [self setToolbar:[[UIToolbar alloc] initWithFrame:[self bounds]]];
    [self.layer insertSublayer:[self.toolbar layer] atIndex:0];
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.toolbar setFrame:[self bounds]];
}
@end
@implementation UIView (Blur)
- (void)blur {
    [self blur:WHITE];
}
- (void)blur:(UIColor *)color {
    [self addSubview:[[FunBlurView alloc] initWithSuperview:self color:color]];
}
@end

@interface UITextFieldFunDelegate : NSObject<UITextFieldDelegate>
@property NSPredicate* excludePredicate;
@property NSUInteger maxLength;
@property (copy)ShouldChangeStringCallback shouldChangeStringCallback;
@end
@implementation UITextFieldFunDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([_excludePredicate evaluateWithObject:string]) {
        return NO;
    }
    if (_maxLength && textField.text.length - range.length + string.length > _maxLength) {
        return NO;
    }
    NSString* toString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (_shouldChangeStringCallback) {
        return _shouldChangeStringCallback(textField.text, toString, range, string);
    }
    return YES;
}
@end

@implementation UITextField (Fun)
- (void)bindTextTo:(NSMutableString *)str {
    if (!str || str.isNull) {
        NSLog(@"WARNING UITextField -bindTextTo: got nil string");
        return;
    }
    self.text = str;
    [self onChange:^(UIEvent *event) {
        [str setString:self.text];
    }];
}
- (UITextFieldFunDelegate*) funDelegate {
    UITextFieldFunDelegate* delegate = GetProperty(self, @"FunDelegate");
    if (delegate) {
        if (![delegate isKindOfClass:[UITextFieldFunDelegate class]]) {
            [NSException raise:@"" format:@"UITextField (Fun) has already been assigned a delegate"];
        }
    } else {
        delegate = [UITextFieldFunDelegate new];
        SetProperty(self, @"FunDelegate", delegate);
        self.delegate = delegate;
    }
    return delegate;
}
- (void)excludeInputsMatching:(NSString *)pattern {
    UITextFieldFunDelegate* delegate = [self funDelegate];
    if (delegate.excludePredicate) {
        [NSException raise:@"" format:@"excludeInputsMatching: called multiple times on the same input"];
    }
    delegate.excludePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
}
- (void)limitLengthTo:(NSUInteger)maxLength {
    [self funDelegate].maxLength = maxLength;
}
- (void)shouldChange:(ShouldChangeStringCallback)shouldChangeStringCallback {
    [self funDelegate].shouldChangeStringCallback = shouldChangeStringCallback;
}
@end

@implementation UILabel (Fun)
- (void)wrapText {
    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByWordWrapping;
    [self sizeToFit];
}
@end