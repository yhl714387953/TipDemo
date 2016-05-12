//
//  RulerView.m
//  标尺测试
//
//  Created by Mac on 16/2/17.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "RulerView.h"

@implementation RulerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAttributes];
        [self drawRuler];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initAttributes];
        [self drawRuler];
    }
    return self;
}

#pragma mark -
#pragma mark - init
-(void)initAttributes{
    self.backgroundColor = [UIColor clearColor];
    self.lineColor = [UIColor purpleColor];
    self.fontColor = [UIColor darkTextColor];
    self.maxValue = 330;
    self.minValue = 0;
    self.clipsToBounds = NO;//超过边界的半个像素也可以显示
}

-(void)drawRuler{
    
//    如果重复多次调用这个方法，label会无限增加
    for (UIView* view in self.subviews)
        if ([view isKindOfClass:[UILabel class]])
            [view removeFromSuperview];
    
//    如果重复多次调用这个方法，layer会无限增加
    for (CALayer* layer in self.layer.sublayers)
        if ([layer isKindOfClass:[CAShapeLayer class]])
            [layer removeFromSuperlayer];

//    标尺刻度
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CAShapeLayer* shaperLayer = [CAShapeLayer layer];
    shaperLayer.strokeColor = self.lineColor.CGColor;
    shaperLayer.fillColor = [UIColor clearColor].CGColor;
    shaperLayer.lineWidth = 1.0f;
    shaperLayer.lineCap = kCALineCapButt;
    
    for (NSInteger i = self.minValue; i <= self.maxValue; i++) {
        CGFloat lineHeight = 30;
        if (i % 10 == 0) {
            lineHeight = 30;
        }else if (i % 5 == 0){
            lineHeight = 20;
        }else{
            lineHeight = 10;
        }
        
        CGPathMoveToPoint(pathRef, NULL, i * kDistance, 0);
        CGPathAddLineToPoint(pathRef, NULL, i * kDistance, lineHeight);
        
//        文字
        if (i % 5 == 0) {
            
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 15, 40, 15)];
            label.font = self.valueFont ? : [UIFont systemFontOfSize:10];//< ? : >判断条件是待使用的值，可简化三目运算符
            label.textColor = self.fontColor ? : [UIColor darkTextColor];
            
            label.text = [NSString stringWithFormat:@"%0.1f", i / 10.0 + 1];
            [label sizeToFit];
            label.center = CGPointMake(i * kDistance, label.center.y);
            
            [self addSubview:label];
            
        }
  
    }
    
    shaperLayer.path = pathRef;
    [self.layer addSublayer:shaperLayer];
    
    self.frame = CGRectMake(0, 0, self.maxValue * kDistance, self.frame.size.height);
}

@end
