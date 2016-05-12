//
//  ZYRulerView.h
//  标尺测试
//
//  Created by Mac on 16/2/18.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYRulerView;
@protocol ZYRulerViewDelegate <NSObject>

@optional
-(void)zyRulerView:(ZYRulerView*)view value:(CGFloat)value;

@end

@interface ZYRulerView : UIView<UIScrollViewDelegate>
/*!
 @brief 代理  支持XIB
 */
@property (nonatomic, weak) IBOutlet id<ZYRulerViewDelegate> delegate;

/*!
 @brief 中间指示器
 */
@property (nonatomic, strong)UIImageView* indicatorImageView;

/*!
 @brief 最大值  表示有多少个格
 */
@property (nonatomic) NSInteger maxValue;

/*!
 @brief 最小值 (待优化，外部不要修改)
 */
@property (nonatomic) NSInteger minValue;

/*!
 @brief 标尺左侧距离  默认半个标尺的宽度(待优化，外部不要修改)
 */
@property (nonatomic) CGFloat leftSpace;

/*!
 @brief 标尺右侧距离  默认半个标尺的宽度(待优化，外部不要修改)
 */
@property (nonatomic) CGFloat rightSpace;

/*!
 @brief 标尺刻度颜色
 */
@property (nonatomic, strong) UIColor* lineColor;

/*!
 @brief 内部滚动窗边界颜色
 */
@property (nonatomic, strong) UIColor* borderColor;

/*!
 @brief 标尺文字颜色
 */
@property (nonatomic, strong) UIColor* fontColor;

/*!
 @brief 标尺文字大小
 */
@property (nonatomic, strong) UIFont* valueFont;

/**
 *  @author 嘴爷, 2016-02-18 15:02:40
 *
 *  @brief 设置当前标尺的值 注意调用时机
 *
 *  @param value    标尺值
 *  @param animated 是否有动画
 */
-(void)setCurrentValue:(CGFloat)value animated:(BOOL)animated;

/**
 *  @author 嘴爷, 2016-02-18 15:02:02
 *
 *  @brief 修改了标尺的默认属性后要调用，刷新一次标尺
 */
-(void)resetRuler;

@end
