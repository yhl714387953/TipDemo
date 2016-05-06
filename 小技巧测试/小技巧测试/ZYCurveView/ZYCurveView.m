//
//  ZYCurveView.m
//  动态曲线绘制
//
//  Created by Mac on 16/2/25.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ZYCurveView.h"
//绘图区域的高度

@implementation ZYCurveView
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
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    self.maxValue = 3000.0f;
//    [self drawBackLayer];
//    [self addAnimation];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (!_isInitialize) {//背景只画一次
        [self drawBackLayer];
        _isInitialize = YES;
    }
}

-(void)drawBackLayer{
    
//    四个点
    CGPoint rightTopPoint = CGPointMake(10, 0);
    CGPoint leftTopPoint = CGPointMake(0, 0);
    CGPoint leftBottomPoint = CGPointMake(0, self.frame.size.height);
    CGPoint rightBottomPoint = CGPointMake(10, self.frame.size.height);
    
//    左侧折线
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, rightTopPoint.x, rightTopPoint.y);
    CGPathAddLineToPoint(pathRef, NULL, leftTopPoint.x, leftTopPoint.y);
    CGPathAddLineToPoint(pathRef, NULL, leftBottomPoint.x, leftBottomPoint.y);
    CGPathAddLineToPoint(pathRef, NULL, rightBottomPoint.x, rightBottomPoint.y);
    
    CAShapeLayer* shaperLayer = [CAShapeLayer layer];
    shaperLayer.strokeColor = [UIColor colorWithRed:36 / 255.0 green:183 / 255.0 blue:210 / 255.0 alpha:0.7].CGColor;
    shaperLayer.fillColor = [UIColor clearColor].CGColor;
    shaperLayer.lineWidth = 2.0f;
    shaperLayer.lineCap = kCALineCapButt;
    
    shaperLayer.path = pathRef;
    [self.layer insertSublayer:shaperLayer atIndex:0];
    
    
//    曲线绘制图层
    self.curveLayer = [CAShapeLayer layer];
    self.curveLayer.frame = self.bounds;
    self.curveLayer.strokeColor = [UIColor colorWithRed:36 / 255.0 green:183 / 255.0 blue:210 / 255.0 alpha:0.7].CGColor;
    self.curveLayer.fillColor = [UIColor clearColor].CGColor;
    self.curveLayer.lineWidth = 2.0f;
    self.curveLayer.lineCap = kCALineCapButt;
    self.curvePathRef = CGPathCreateMutable();
//    设置折线起点视图最右侧
    CGPathMoveToPoint(self.curvePathRef, NULL, self.frame.size.width, self.frame.size.height / 2.0);
    self.curveLayer.path = self.curvePathRef;
    [self.layer addSublayer:self.curveLayer];
}


-(void)addValue:(NSArray<NSNumber*> *)numbers{
    if (![numbers isKindOfClass:[NSArray class]]) {
        return;
    }
    // 步长
#define kCurveStep 3
#define kCurvePointHeight(x) (self.frame.size.height * ((x) / self.maxValue));
    
    for (NSNumber* number in numbers) {
        CGFloat curveHeight = kCurvePointHeight([number floatValue]);
        if (curveHeight > self.frame.size.height - 1) curveHeight = self.frame.size.height - 1;
        if (curveHeight <= 1) curveHeight = 1;

        CGPathAddLineToPoint(self.curvePathRef, NULL, self.curveLayer.frame.size.width + kCurveStep, self.frame.size.height - curveHeight);
        NSLog(@"%.1f", curveHeight);
        self.curveLayer.path = self.curvePathRef;//需要重新赋值一次
        self.curveLayer.frame = CGRectMake(self.curveLayer.frame.origin.x - kCurveStep, 0, self.curveLayer.frame.size.width + kCurveStep, self.frame.size.height);
        /*动画*/
//        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
//        animation.fromValue = [NSNumber numberWithFloat:self.curveLayer.frame.origin.x];
//        animation.toValue = [NSNumber numberWithFloat:self.curveLayer.frame.origin.x - kCurveStep];
//        animation.duration = 0.2;
//        [self.curveLayer addAnimation:animation forKey:nil];
//        CATransition *animation = [CATransition animation];
//        animation.delegate = self;
//        animation.duration = 0.2;
//        animation.timingFunction = UIViewAnimationCurveEaseIn;
//        [self.layer addAnimation:animation forKey:@"animation"];
        
    }
}

-(void)clear{
    self.curveLayer.frame = self.bounds;
    self.curvePathRef = CGPathCreateMutable();
    //    设置折线起点视图最右侧
    CGPathMoveToPoint(self.curvePathRef, NULL, self.frame.size.width, self.frame.size.height / 2.0);
    
    self.curveLayer.path = self.curvePathRef;
}

-(void)addAnimation{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    //    animation.type = @"pageCurl";
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromRight;
    [self.layer addAnimation:animation forKey:nil];
}

-(void)layerAnimation{
    

}

-(void)dealloc{
    CGPathRelease(self.curvePathRef);
    NSLog(@"曲线视图销毁了");
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
