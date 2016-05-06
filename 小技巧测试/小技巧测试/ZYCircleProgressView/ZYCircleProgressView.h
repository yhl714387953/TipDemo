//
//  ZYCircleProgressView.h
//  动态曲线绘制
//
//  Created by Mac on 16/2/29.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYCircleProgressView;
@protocol ZYCircleProgressViewDelegate <NSObject>
@optional
-(void)circleView:(ZYCircleProgressView*)circleView ainimatedProgress:(CGFloat)progress;

@end

@interface ZYCircleProgressView : UIView
{
    CGFloat _currentProgress;
}

@property (nonatomic, weak)IBOutlet id<ZYCircleProgressViewDelegate> delegate;
@property (nonatomic) CGFloat progress;
@property (nonatomic, strong) NSTimer* timer;



/*!
 @brief 进度  0.0f~100.0f
 */
-(void)resetProgress:(CGFloat)progress;

/*!
 @brief 注释
 */
@property (nonatomic, strong) UIColor* progressTintColor;

@end
