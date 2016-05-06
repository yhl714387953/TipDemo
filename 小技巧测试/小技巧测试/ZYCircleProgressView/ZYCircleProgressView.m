//
//  ZYCircleProgressView.m
//  动态曲线绘制
//
//  Created by Mac on 16/2/29.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ZYCircleProgressView.h"

@implementation ZYCircleProgressView

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
    self.progressTintColor = [UIColor blackColor];
    _currentProgress = 0;
}

-(void)resetProgress:(CGFloat)progress{
    self.progress = progress;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(drawCircle:) userInfo:nil repeats:YES];
}
-(void)drawCircle:(NSTimer*)timer{
    _currentProgress += 3;
    [self setNeedsDisplay];
    
    if (_currentProgress > self.progress) {
        _currentProgress = self.progress;
        [timer invalidate];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(circleView:ainimatedProgress:)]) {
        [self.delegate circleView:self ainimatedProgress:_currentProgress];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // Drawing code
    [self.progressTintColor set];
    CGFloat lineWidth = 8;
    CGPoint center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    CGFloat radius = MIN(self.frame.size.width / 2.0, self.frame.size.height / 2.0) - lineWidth / 2.0;
    CGFloat rate = M_PI / 180.f;
    
    //    90 ～ 360    0 ～ actualEndAngle(实际结束角度)
    //    所有的值在(360 + actualEndAngle - 90)度的角度上均分  一个进度代表的角度
    NSInteger startEngle = 90;
    NSInteger actualEndAngle = 80;
    CGFloat ava = (360 + actualEndAngle - startEngle) / 99.9f;
    CGFloat endAngle = startEngle + ava * _currentProgress;
    
    endAngle = endAngle < 360 ? endAngle : endAngle - 360;
    
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:(rate * startEngle) endAngle:rate * endAngle clockwise:YES];
    path.lineCapStyle = kCGLineCapRound;//线的起始和结尾是圆角
    //    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = lineWidth;
    
    [path stroke];
}

@end
