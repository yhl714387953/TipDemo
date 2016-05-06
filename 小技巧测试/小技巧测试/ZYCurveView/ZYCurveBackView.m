//
//  ZYCurveBackView.m
//  动态曲线绘制
//
//  Created by Mac on 16/2/25.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ZYCurveBackView.h"

@implementation ZYCurveBackView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAttributes];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initAttributes];
    }
    return self;
}

#pragma mark -
#pragma mark - init
-(void)initAttributes{
    self.backgroundColor = [UIColor colorWithRed:241 / 255.0 green:241 / 255.0 blue:241 / 255.0 alpha:0.5];
    [self drawBackLayer];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (!_isInitialize) {//背景只画一次
        [self drawBackLayer];
        _isInitialize = YES;
    }
}

-(void)drawBackLayer{
    /*
     6 * 6  线宽为1
     */
    CGMutablePathRef pathRef = CGPathCreateMutable();
    float space = 7;
    int hLines = self.frame.size.height / space + 1;
    int vLines = self.frame.size.width / space + 1;
    
    //    画横线
    for (int i = 0; i < hLines; i++) {
        CGPathMoveToPoint(pathRef, NULL, 0, i * space);
        CGPathAddLineToPoint(pathRef, NULL, self.frame.size.width, i * space);
    }
    
    //    画竖线
    for (int i = 0; i < vLines; i++) {
        CGPathMoveToPoint(pathRef, NULL, i * space, 0);
        CGPathAddLineToPoint(pathRef, NULL, i * space, self.frame.size.height);
    }
    
    CAShapeLayer* shaperLayer = [CAShapeLayer layer];
    shaperLayer.strokeColor = [UIColor whiteColor].CGColor;
    shaperLayer.fillColor = [UIColor clearColor].CGColor;
    shaperLayer.lineWidth = 1.0f;
    shaperLayer.lineCap = kCALineCapButt;
    
    shaperLayer.path = pathRef;
    
//    背景的layer要放在最底层
    [self.layer insertSublayer:shaperLayer atIndex:0];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
