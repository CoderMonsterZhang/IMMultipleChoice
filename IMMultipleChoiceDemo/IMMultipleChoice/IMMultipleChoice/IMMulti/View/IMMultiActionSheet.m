//
//  IMMutiActionSheet.m
//  YJSelectionView
//
//  Created by Goldenbaby on 2017/12/22.
//  Copyright © 2017年 Jake. All rights reserved.
//

#import "IMMultiActionSheet.h"
#import "UIView+IMChoiceAdd.h"
#import "NSString+IMChoiceAdd.h"

#define kWindow [UIApplication sharedApplication].keyWindow

@implementation IMMultiActionSheetTitle

- (instancetype)init
{
    self = [super init];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = kTitleFont;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor grayColor];
    [self addSubview:_titleLabel];
    
    _detailTitleLabel = [UILabel new];
    _detailTitleLabel.font = kDetailTitleFont;
    _detailTitleLabel.textColor = [UIColor lightGrayColor];
    _detailTitleLabel.textAlignment = NSTextAlignmentCenter;
    _detailTitleLabel.numberOfLines = 0;
    [self addSubview:_detailTitleLabel];
    
    
    return self;
}

- (void)setLayouts:(IMMultiLayout *)layouts
{
    _layouts = layouts;
    _titleLabel.sy_w = kScreenSize.width - 100;
    _titleLabel.sy_x = 50;
    _titleLabel.sy_h = layouts.titleHeight;
    _titleLabel.sy_y = kTopPandding;
    _titleLabel.text = layouts.title;
    
    _detailTitleLabel.sy_w = kScreenSize.width - 50;
    _detailTitleLabel.sy_x = 25;
    _detailTitleLabel.sy_h = layouts.detailTitleHeight;
    _detailTitleLabel.sy_y = _titleLabel.sy_bottom + kTextPandding;
    _detailTitleLabel.text = layouts.detailTitle;
    
    CALayer *line = [CALayer layer];
    line.frame = CGRectMake(0, _detailTitleLabel.sy_bottom + kTextPandding, [UIScreen mainScreen].bounds.size.width, 1);
    line.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.09].CGColor;
    [self.layer addSublayer:line];
    
    _height = line.frame.origin.y + 1;
}

@end

@implementation IMMultiActionSheetContentView 

- (instancetype)init
{
    self = [super init];
    
    
    return self;
}

- (void)setLayouts:(IMMultiLayout *)layouts
{
    _layouts = layouts;
    
    switch (layouts.pickerState) {
        case IMMultiDataPickerNone:
            self.tableView.delegate = self;
            self.tableView.dataSource = self;
            self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
            self.tableView.scrollEnabled = layouts.isScrollEnable;
            self.tableView.rowHeight = kItemHeight;
            
            self.frame = CGRectMake(0, layouts.titleViewHeight + 3, kScreenSize.width, layouts.itemsHeight);
            self.tableView.frame = (CGRect){{0,0},self.frame.size};
            break;
        case IMMultiDataPicker:
            self.frame = CGRectMake(0, layouts.titleViewHeight + 3, kScreenSize.width, layouts.itemsHeight);
            self.pickerView.frame = (CGRect){{0,0},self.frame.size};
            [self.pickerView addSubview:self.dataPickerView];
            
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.layouts.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IMMultiItem *item = self.layouts.items[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = item.title;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    [self.selectionItemList enumerateObjectsUsingBlock:^(IMMultiItem *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:self.layouts.items[indexPath.row]]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            *stop = YES;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (self.layouts.choiceState == IMMultiSelectionStateMultipleChoice) {
        switch (cell.accessoryType) {
            case UITableViewCellAccessoryCheckmark:
                [self.selectionItemList removeObject:self.layouts.items[indexPath.row]];
                break;
            case UITableViewCellAccessoryNone:
                [self.selectionItemList addObject:self.layouts.items[indexPath.row]];
                break;
            default:
                break;
        }
        
        cell.accessoryType = cell.accessoryType == UITableViewCellAccessoryCheckmark ? UITableViewCellAccessoryNone : UITableViewCellAccessoryCheckmark;
    } else {
        if (self.contentComplete) {
            self.contentComplete(YES,@[self.layouts.items[indexPath.row]]);
        }
    }
    
}

#pragma mark -
#pragma mark - UIDataPicker DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.layouts.items.count;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.layouts.items[component] count];
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    IMMultiItem *item = self.layouts.items[component][row];
    return item.title;
}


#pragma mark -
#pragma mark - Getter
- (NSMutableArray *)selectionItemList
{
    if (!_selectionItemList) {
        _selectionItemList = @[].mutableCopy;
    }
    return _selectionItemList;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        [self addSubview:_tableView];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (UIView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [UIView new];
        _pickerView.backgroundColor = [UIColor redColor];
        [self addSubview:_pickerView];
    }
    return _pickerView;
}

- (UIPickerView *)dataPickerView
{
    if (!_dataPickerView) {
        
        _dataPickerView = [[UIPickerView alloc]initWithFrame:(CGRect){{0,0},self.frame.size}];
        _dataPickerView.showsSelectionIndicator = YES;
        _dataPickerView.backgroundColor = [UIColor whiteColor];
        _dataPickerView.delegate = self;
        _dataPickerView.dataSource = self;
        [_dataPickerView selectRow:[self.layouts.items[0] count] / 3 inComponent:0 animated:YES];
    }
    return _dataPickerView;
}

@end

@implementation IMMultiActionFooterView

- (instancetype)init
{
    self = [super init];
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return self;
}

- (void)setLayouts:(IMMultiLayout *)layouts
{
    _layouts = layouts;
    
    self.frame = CGRectMake(0, layouts.itemsHeight + layouts.titleViewHeight, kScreenSize.width, layouts.bottomHeight);
    
    if (layouts.state == IMMultiFooterStateBoth) {
        for (int i = 0; i < 2; i++) {
            UIButton *item = [UIButton buttonWithType:UIButtonTypeSystem];
            [item.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
            [item setTitle:@[@"取消",@"确定"][i] forState:UIControlStateNormal];
            [item setBackgroundColor:[UIColor whiteColor]];
            [item setFrame:CGRectMake(i * kScreenSize.width / 2, kTopPandding, kScreenSize.width / 2, self.layouts.bottomHeight)];
            [item addTarget:self action:@selector(touchFooterItems:) forControlEvents:UIControlEventTouchUpInside];
            [item setTag:100000 + i];
            [self addSubview:item];
        }
    } else {
        UIButton *item = [self itemsForState:layouts.state];
        [self addSubview:item];
    }
}



- (UIButton *)itemsForState:(IMMultiFooterState)state
{
    NSString *title = state == IMMultiFooterStateConfirm ? @"确定" : @"取消";
    NSInteger tag = state == IMMultiFooterStateCancel ? 100000: 100001;
    UIButton *item = [UIButton buttonWithType:UIButtonTypeSystem];
    [item.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [item setTitle:title forState:UIControlStateNormal];
    [item setBackgroundColor:[UIColor whiteColor]];
    [item setFrame:CGRectMake(0, kTopPandding, kScreenSize.width, self.layouts.bottomHeight)];
    [item addTarget:self action:@selector(touchFooterItems:) forControlEvents:UIControlEventTouchUpInside];
    [item setTag:tag];
    return item;
}

- (void)touchFooterItems:(UIButton *)item
{
    if (self.touchFooterComplete) {
        self.touchFooterComplete(item.tag - 100000);
    }
}



@end


@implementation IMMultiActionSheet

#pragma mark -
#pragma mark - 声明周期

- (instancetype)init
{
    self = [super init];
    
    self.frame = kWindow.bounds;
    self.backgroundColor = [UIColor clearColor];
    
    __weak typeof(self) weak_self = self;
    
    _backgroundView = [[UIView alloc] initWithFrame:self.frame];
    _backgroundView.backgroundColor = [UIColor colorWithWhite:0.02f alpha:0.6];
    [self addSubview:_backgroundView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureBackgroundView:)];
    [_backgroundView addGestureRecognizer:tap];
    
    /// 内容视图
    _contentView = [UIView new];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    
    _titleView = [IMMultiActionSheetTitle new];
    _titleView.hidden = YES;
    [_contentView addSubview:_titleView];
    
    _sheetContentView = [IMMultiActionSheetContentView new];
    [_contentView addSubview:_sheetContentView];
    _sheetContentView.contentComplete = ^(BOOL isConfirm, NSArray *selectionList) {
        if (weak_self.getterResponseComplete) {
            weak_self.getterResponseComplete(isConfirm, selectionList);
        }
        [weak_self cancel];
    };
    
    _footerView = [IMMultiActionFooterView new];
    [_contentView addSubview:_footerView];
    
    _footerView.touchFooterComplete = ^(BOOL isConfirm) {
        if (weak_self.getterResponseComplete) {
            if (weak_self.layouts.pickerState == IMMultiDataPicker) {
                NSMutableArray *indexes = [NSMutableArray array];
                NSMutableArray *items = [NSMutableArray array];
                for (int i = 0; i < weak_self.sheetContentView.layouts.items.count; i++) {
                    NSInteger row = [weak_self.sheetContentView.dataPickerView selectedRowInComponent:i];
                    [items addObject:weak_self.sheetContentView.layouts.items[i][row]];
                    [indexes addObject:@(row).stringValue];
                }
                weak_self.getterResponseComplete(isConfirm, items);
                [weak_self cancel];
            } else {
                weak_self.getterResponseComplete(isConfirm, weak_self.sheetContentView.selectionItemList);
            }
        }
        if (!isConfirm || self.sheetContentView.selectionItemList.count > 0) {
            [weak_self cancel];
        }
    };
    
    return self;
}

- (void)tapGestureBackgroundView:(UITapGestureRecognizer *)sender
{
    [self cancel];
}

#pragma mark -
#pragma mark - 数据布局
- (void)setLayouts:(IMMultiLayout *)layouts
{
    _layouts = layouts;
    _titleView.sy_h = layouts.titleViewHeight;
    _titleView.layouts = layouts;
    if (layouts.height > 0) {
        _titleView.hidden = NO;
    } else {
        _titleView.hidden = YES;
    }
    
    
    _contentView.sy_h = layouts.height;
    _contentView.sy_w = kScreenSize.width;
    _contentView.sy_y = kScreenSize.height;
    _contentView.sy_x = 0;
    
    _sheetContentView.layouts = layouts;
    _footerView.layouts = layouts;
}

#pragma mark -
#pragma mark - 外部接口
- (void)show
{
    self.backgroundView.alpha = 0;
    [UIView animateWithDuration:.25f animations:^{
        self.backgroundView.alpha = 1.f;
        _contentView.sy_bottom = self.backgroundView.sy_bottom;
        [kWindow addSubview:self];
    }];
}

- (void)cancel
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundView.alpha = 0;
        _contentView.sy_y = self.backgroundView.sy_bottom;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
