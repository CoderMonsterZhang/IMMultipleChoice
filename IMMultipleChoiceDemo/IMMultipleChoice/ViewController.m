//
//  ViewController.m
//  IMMultipleChoice
//
//  Created by Goldenbaby on 2017/12/25.
//  Copyright © 2017年 Monster Zhang. All rights reserved.
//

#import "ViewController.h"
#import "IMMultiActionSheet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dataPicker:(UIButton *)sender {
    
    NSMutableArray *weeks = @[].mutableCopy;
    NSMutableArray *days = @[].mutableCopy;
    for (int i = 25; i < 80; i++) {
        IMMultiItem *item = [IMMultiItem new];
        item.title = [NSString stringWithFormat:@"%d",i];
        item.identifier = @(i).stringValue;
        [weeks addObject:item];
    }
    
    for (int i = 0; i < 7; i++) {
        IMMultiItem *item = [IMMultiItem new];
        item.title = [NSString stringWithFormat:@"%d",i];
        item.identifier = @(i).stringValue;
        [days addObject:item];
    }
    
    IMMultiLayout *layout = [IMMultiLayout new];
    layout.title = @"提示";
    layout.detailTitle = @"请选择更多结果";
    layout.items = @[weeks, days];
    layout.state = IMMultiFooterStateBoth;
    layout.pickerState = IMMultiDataPicker;
    
    IMMultiActionSheet *sheet = [IMMultiActionSheet new];
    sheet.layouts = layout;
    [sheet show];
    
    sheet.getterResponseComplete = ^(BOOL isConfirm, NSArray *selectionList) {
        NSLog(@"%@",selectionList);
    };
}

- (IBAction)multipleChoice {
    
    NSMutableArray *arr = @[].mutableCopy;
    for (int i = 0; i < 13; i++) {
        IMMultiItem *item = [IMMultiItem new];
        item.title = [NSString stringWithFormat:@"我是多选%d",i];
        item.identifier = @(i).stringValue;
        [arr addObject:item];
    }
    
    IMMultiLayout *layout = [IMMultiLayout new];
    layout.title = @"提示";
    layout.detailTitle = @"请选择更多结果";
    layout.items = arr;
    layout.state = IMMultiFooterStateBoth;
    layout.choiceState = IMMultiSelectionStateMultipleChoice;
    
    IMMultiActionSheet *sheet = [IMMultiActionSheet new];
    sheet.layouts = layout;
    [sheet show];
    
    sheet.getterResponseComplete = ^(BOOL isConfirm, NSArray *selectionList) {
        NSLog(@"%@",selectionList);
    };
}

@end
