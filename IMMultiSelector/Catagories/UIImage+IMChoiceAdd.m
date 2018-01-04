//
//  UIImage+IMAdd.m
//  IMPagerView
//
//  Created by Goldenbaby on 2017/12/21.
//  Copyright © 2017年 iDoctor. All rights reserved.
//

#import "UIImage+IMChoiceAdd.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation UIImage (IMChoiceAdd)


#pragma mark -
#pragma mark - 获取视频第几秒帧图片
+ (UIImage *)imageWithVideoCoverUrl:(NSURL *)coverUrl atTime:(NSTimeInterval)time
{
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    /// if deprecated this methods, Use - AVURLAsset.
    MPMoviePlayerController *movie = [[MPMoviePlayerController alloc]initWithContentURL:coverUrl];
    movie.shouldAutoplay = NO;
    UIImage *thumbnail = [movie thumbnailImageAtTime:time timeOption:MPMovieTimeOptionNearestKeyFrame];
    movie  = nil;
    return IMMatchImage(thumbnail);
    
#pragma clang diagnostic pop

}

#pragma mark -
#pragma mark - Utilities

UIImage * IMMatchImage(UIImage *image) {
    return image == nil ? [UIImage imageNamed:@"Pagers Loading@2x.png"] : image;
}

@end
