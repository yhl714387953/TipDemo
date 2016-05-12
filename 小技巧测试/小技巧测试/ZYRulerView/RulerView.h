//
//  RulerView.h
//  标尺测试
//
//  Created by Mac on 16/2/17.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//刻度之间的距离
#define kDistance 8.0f

@interface RulerView : UIView
@property (nonatomic, strong) UIColor* lineColor;
@property (nonatomic, strong) UIColor* fontColor;
@property (nonatomic, strong) UIFont* valueFont;
@property (nonatomic) NSInteger maxValue;
@property (nonatomic) NSInteger minValue;

-(void)drawRuler;

@end
