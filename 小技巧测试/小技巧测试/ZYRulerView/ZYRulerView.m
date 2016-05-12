//
//  ZYRulerView.m
//  标尺测试
//
//  Created by Mac on 16/2/18.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ZYRulerView.h"
#import "RulerView.h"

@interface ZYRulerView ()
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) RulerView* rulerView;

@end

@implementation ZYRulerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];

    }
    return self;
}


-(void)commonInit{
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.rulerView];
    
    [self addSubview:self.indicatorImageView];
    
    self.scrollView.layer.borderColor = [UIColor purpleColor].CGColor;
    self.scrollView.layer.borderWidth = 1.0f;
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
//    默认左右距离
    if (self.leftSpace == 0)  self.leftSpace = self.frame.size.width / 2.0f;
    if (self.rightSpace == 0) self.rightSpace = self.frame.size.width / 2.0f;
    
//    指示器设置
    self.indicatorImageView.frame = CGRectMake(0, 0, 2, self.frame.size.height);
    self.indicatorImageView.center = CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f);
    
//    滚动条设置
    self.scrollView.frame = self.bounds;
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, self.scrollView.frame.size.width / 2.0, 0, self.scrollView.frame.size.width / 2.0)];
   
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.rulerView.frame), 0);
}

#pragma mark -
#pragma mark - getter
-(UIImageView *)indicatorImageView{
    if (!_indicatorImageView) {
        _indicatorImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _indicatorImageView.clipsToBounds = NO;
        _indicatorImageView.backgroundColor = [UIColor redColor];
    }
    
    return _indicatorImageView;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    
    return _scrollView;
}

-(RulerView *)rulerView{
    if (!_rulerView) {
        _rulerView = [[RulerView alloc] initWithFrame:CGRectMake(0, 0, 0, CGRectGetHeight(self.scrollView.frame))];
        
    }
    
    return _rulerView;
}

#pragma mark -
#pragma mark - setter
-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    
    self.rulerView.lineColor = lineColor;
}

-(void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    
    self.scrollView.layer.borderColor = borderColor.CGColor;
}

-(void)setFontColor:(UIColor *)fontColor{
    _fontColor = fontColor;
    
    self.rulerView.fontColor = fontColor;
}

-(void)setValueFont:(UIFont *)valueFont{
    _valueFont = valueFont;
    
    self.rulerView.valueFont = valueFont;
}

-(void)setMinValue:(NSInteger)minValue{
    _minValue = minValue;
    
    self.rulerView.minValue = minValue;
}

-(void)setMaxValue:(NSInteger)maxValue{
    _maxValue = maxValue;
   
    self.rulerView.maxValue = maxValue;
}

#pragma mark -
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat value = (scrollView.contentOffset.x + self.leftSpace) / (kDistance * 10.0);
//    NSLog(@"%f  %f  %f", self.leftSpace, (scrollView.contentOffset.x + self.leftSpace) / (kDistance * 1),  scrollView.contentOffset.x);
    
//    CGFloat value = scrollView.contentOffset
    if (scrollView.contentOffset.x + self.leftSpace < 0) {
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(zyRulerView:value:)]) {
        [self.delegate zyRulerView:self value:(scrollView.contentOffset.x + self.leftSpace) / kDistance + 10];
    }

}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    CGFloat x = (scrollView.contentOffset.x + self.leftSpace) / (kDistance * 1);
////    NSLog(@"========  %f", x - (int)x);
//    if (!decelerate) {
////        x - (int)x > 0.5 停到下一个刻度
//        CGFloat pointX = x - (int)x > 0.5 ? (int)x * kDistance - self.leftSpace : ((int)x + 1) * kDistance - self.leftSpace;
//        [scrollView setContentOffset:CGPointMake(pointX, 0) animated:YES];
//    }
    CGFloat pointX = 0;
    CGFloat offsetX = scrollView.contentOffset.x + self.leftSpace;//leftSpace 补偿左侧位置，从0开始
//    以kDistance为单位划分 共有totalPerDis份  余数
    int totalPerDis = offsetX / kDistance;
    CGFloat yushu = offsetX - totalPerDis * kDistance;
    
    if (yushu > kDistance / 2.0) {
        pointX = totalPerDis * kDistance  + kDistance;
    }else{
        pointX = totalPerDis * kDistance;
    }
    
    if (!decelerate) {
        [scrollView setContentOffset:CGPointMake(pointX - self.leftSpace, 0) animated:YES];
    }

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    CGFloat x = (scrollView.contentOffset.x + self.leftSpace) / (kDistance * 1);
////    NSLog(@"========  %f", x - (int)x);
//    //        x - (int)x > 0.5 停到下一个刻度
//    CGFloat pointX = x - (int)x > 0.5 ? (int)x * kDistance - self.leftSpace : ((int)x + 1) * kDistance - self.leftSpace;
//    [scrollView setContentOffset:CGPointMake(pointX, 0) animated:YES];
    
    CGFloat pointX = 0;
    CGFloat offsetX = scrollView.contentOffset.x + self.leftSpace;//leftSpace 补偿左侧位置，从0开始
    //    以kDistance为单位划分 共有totalPerDis份  余数
    int totalPerDis = offsetX / kDistance;
    CGFloat yushu = offsetX - totalPerDis * kDistance;
    
    if (yushu > kDistance / 2.0) {
        pointX = totalPerDis * kDistance  + kDistance;
    }else{
        pointX = totalPerDis * kDistance;
    }
    
    [scrollView setContentOffset:CGPointMake(pointX - self.leftSpace, 0) animated:YES];
}


#pragma mark -
#pragma mark - public method
-(void)setCurrentValue:(CGFloat)value animated:(BOOL)animated{
    [self.scrollView setContentOffset:CGPointMake((value - 1) * 10 * kDistance - self.leftSpace, 0) animated:animated];
}

-(void)resetRuler{
    [self.rulerView drawRuler];
}


@end
