//
//  NSString+IMAdd.h
//  IMPagerView
//
//  Created by Goldenbaby on 2017/12/20.
//  Copyright © 2017年 iDoctor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (IMChoiceAdd)

@property (nonatomic, copy, readonly) NSURL *conversionsUrl;

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)widthForFont:(UIFont *)font;

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;

@end
