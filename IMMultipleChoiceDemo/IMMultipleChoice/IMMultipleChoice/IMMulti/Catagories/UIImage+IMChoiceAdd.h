//
//  UIImage+IMAdd.h
//  IMPagerView
//
//  Created by Goldenbaby on 2017/12/21.
//  Copyright © 2017年 iDoctor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (IMChoiceAdd)


/**
 获取视频第几秒帧图片

 @param coverUrl 视频地址
 @param time 视频第几秒封面
 @return 生成图片
 */
+ (UIImage *)imageWithVideoCoverUrl:(NSURL *)coverUrl atTime:(NSTimeInterval)time;

@end
