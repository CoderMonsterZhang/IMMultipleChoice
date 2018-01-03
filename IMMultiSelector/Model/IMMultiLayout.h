//
//  IMMultiLayout.h
//  YJSelectionView
//
//  Created by Goldenbaby on 2017/12/22.
//  Copyright © 2017年 IDoctor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IMMultiFooterState) {
    IMMultiFooterStateCancel,
    IMMultiFooterStateBoth,
    IMMultiFooterStateConfirm
};

typedef NS_ENUM(NSInteger, IMMultiSelectionState) {
    IMMultiSelectionStateSingle,
    IMMultiSelectionStateMultipleChoice
};

typedef NS_ENUM(NSInteger, IMMultiDataPickerState) {
    IMMultiDataPickerNone,
    IMMultiDataPicker,
};

#define kTopPandding 8
#define kTextPandding 10
#define kItemHeight 49

#define kScreenSize [UIScreen mainScreen].bounds.size

#define kTitleFont [UIFont boldSystemFontOfSize:12]
#define kDetailTitleFont [UIFont italicSystemFontOfSize:13]

@interface IMMultiLayout : NSObject

@property (nonatomic, copy) NSString *title;                        ///< 标题
@property (nonatomic, assign) CGFloat titleHeight;                  ///< 标题头高度

@property (nonatomic, copy) NSString *detailTitle;                  ///< 子标题
@property (nonatomic, assign) CGFloat detailTitleHeight;            ///< 子标题高度

@property (nonatomic, assign) CGFloat titleViewHeight;              ///< 子标题高度

@property (nonatomic, strong) NSArray *items;                       ///< 选择cell
@property (nonatomic, assign) CGFloat itemsHeight;                  ///< 选择cell总高度

@property (nonatomic, assign) CGFloat bottomPandding;               ///< 底部距离
@property (nonatomic, assign) CGFloat bottomHeight;                 ///< 底部按钮高度
@property (nonatomic, assign) IMMultiFooterState state;             ///< 底部按钮状态,默认取消

@property (nonatomic, assign) BOOL isScrollEnable;                  ///< 是否可以滑动
@property (nonatomic, assign) IMMultiSelectionState choiceState;    ///< 单选 or 多选，默认单选
@property (nonatomic, assign) IMMultiDataPickerState pickerState;   ///< 是否是DataPicker

@property (nonatomic, assign) CGFloat height;   ///< 总高度

@end


