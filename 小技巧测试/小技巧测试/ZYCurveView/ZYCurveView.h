//
//  ZYCurveView.h
//  动态曲线绘制
//
//  Created by Mac on 16/2/25.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYCurveView : UIView
{
    BOOL _isInitialize;//是否根据fame定义过视图
}

@property (nonatomic, strong) CAShapeLayer* curveLayer;

/** 这个创建path的时候在系统为IOS8时，不会显示，选用贝塞尔曲线 */
@property (nonatomic) CGMutablePathRef curvePathRef;
@property (nonatomic, strong) UIBezierPath* bezierPath;

/**
 *  @brief 最大显示值
 */
@property (nonatomic) CGFloat maxValue;

/**
 *  @author 嘴爷, 2016-02-25 16:02:06
 *
 *  @brief 添加点
 *
 *  @param numbers 数组样式[@(2), @(40), @(1836)]
 */
-(void)addValue:(NSArray<NSNumber*> *)numbers;

/**
 *  @author 嘴爷, 2016-02-26 10:02:26
 *
 *  @brief 清除曲线，回到初始状态
 */
-(void)clear;

@end
