//
//  IMMultiLayout.m
//  YJSelectionView
//
//  Created by Goldenbaby on 2017/12/22.
//  Copyright © 2017年 IDoctor. All rights reserved.
//

#import "IMMultiLayout.h"
#import "NSString+IMChoiceAdd.h"

@implementation IMMultiLayout

- (CGFloat)titleHeight
{
    return [self.title heightForFont:kTitleFont width:[UIScreen mainScreen].bounds.size.width - 100];
}

- (CGFloat)detailTitleHeight
{
    return [self.detailTitle heightForFont:kDetailTitleFont width:[UIScreen mainScreen].bounds.size.width - 50];
}


- (CGFloat)titleViewHeight
{
    return self.titleHeight + self.detailTitleHeight + kTopPandding + kTextPandding + kTopPandding;
}

- (CGFloat)itemsHeight
{
    if (self.pickerState == IMMultiDataPickerNone) {
        CGFloat contentHeight = self.items.count * kItemHeight;
        self.isScrollEnable = contentHeight >= kScreenSize.height - 100 ? YES : NO;
        return contentHeight >= kScreenSize.height - 100 ? kItemHeight * 10 : contentHeight;
    } else {
        return 200;
    }
}

- (CGFloat)bottomHeight
{
    return kItemHeight + kTopPandding;
}

- (CGFloat)height
{
    CGFloat h = self.titleViewHeight + self.itemsHeight + self.bottomHeight;
    if (kScreenSize.height == 812) {
        h += 34;
    }
    return h;
}

@end
