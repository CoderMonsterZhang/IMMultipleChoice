//
//  UIView+IMAnimationAdd.m
//  IMPopoverController
//
//  Created by 松宇 on 2017/5/23.
//  Copyright © 2017年 monsters_zhang. All rights reserved.
//

#import "UIView+IMChoiceAdd.h"

@implementation UIView (IMChoiceAdd)

- (void)setSy_x:(CGFloat)sy_x
{
    CGRect frame = self.frame;
    frame.origin.x = sy_x;
    self.frame = frame;
}

- (CGFloat)sy_x
{
    return self.frame.origin.x;
}

- (void)setSy_y:(CGFloat)sy_y
{
    CGRect frame = self.frame;
    frame.origin.y = sy_y;
    self.frame = frame;
}

- (CGFloat)sy_y
{
    return self.frame.origin.y;
}

- (void)setSy_w:(CGFloat)sy_w
{
    CGRect frame = self.frame;
    frame.size.width = sy_w;
    self.frame = frame;
}

- (CGFloat)sy_w
{
    return self.frame.size.width;
}

- (void)setSy_h:(CGFloat)sy_h
{
    CGRect frame = self.frame;
    frame.size.height = sy_h;
    self.frame = frame;
}

- (CGFloat)sy_h
{
    return self.frame.size.height;
}

- (void)setSy_bottom:(CGFloat)sy_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = sy_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)sy_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)sy_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setSy_right:(CGFloat)sy_right {
    CGRect frame = self.frame;
    frame.origin.x = sy_right - frame.size.width;
    self.frame = frame;
}

- (void)setSy_size:(CGSize)sy_size
{
    CGRect frame = self.frame;
    frame.size = sy_size;
    self.frame = frame;
}

- (CGSize)sy_size
{
    return self.frame.size;
}

- (void)setSy_origin:(CGPoint)sy_origin
{
    CGRect frame = self.frame;
    frame.origin = sy_origin;
    self.frame = frame;
}

- (CGPoint)sy_origin
{
    return self.frame.origin;
}

@end
