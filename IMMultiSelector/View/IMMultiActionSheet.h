//
//  IMMutiActionSheet.h
//  YJSelectionView
//
//  Created by Goldenbaby on 2017/12/22.
//  Copyright © 2017年 iDoctor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMMultiLayout.h"
#import "IMMultiItem.h"

@interface IMMultiActionSheetTitle : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailTitleLabel;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) IMMultiLayout *layouts;

@end

@interface IMMultiActionSheetContentView : UIView <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSMutableArray *selectionItemList;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *pickerView;
@property (nonatomic, strong) IMMultiLayout *layouts;
@property (nonatomic, strong) void (^contentComplete)(BOOL isConfirm, NSArray *selectionList);
@property (nonatomic, strong) UIPickerView *dataPickerView;

@end

@interface IMMultiActionFooterView: UIView

@property (nonatomic, strong) void (^touchFooterComplete)(BOOL isConfirm);
@property (nonatomic, strong) IMMultiLayout *layouts;

@end

@interface IMMultiActionSheet : UIView

- (void)show;   ///< 展示

/// 数据
@property (nonatomic, strong) IMMultiLayout *layouts;

/// 布局
@property (nonatomic, strong) UIView *backgroundView;                    ///< 半透明黑背景
@property (nonatomic, strong) UIView *contentView;                       ///< 展示内容视图
@property (nonatomic, strong) IMMultiActionSheetTitle *titleView;        ///< 标题头视图
@property (nonatomic, strong) IMMultiActionSheetContentView *sheetContentView;   ///< 内容视图
@property (nonatomic, strong) IMMultiActionFooterView *footerView;       ///< 底部视图

@property (nonatomic, strong) void (^getterResponseComplete)(BOOL isConfirm, NSArray *selectionList);

@end
