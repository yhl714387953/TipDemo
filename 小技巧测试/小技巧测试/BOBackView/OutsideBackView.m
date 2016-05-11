//
//  OutsideBackView.m
//  小技巧测试
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "OutsideBackView.h"

@implementation OutsideBackView
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
    [self addSubview:self.button];
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    BOOL inside = [super pointInside:point withEvent:event];
    if (!inside) {
        CGPoint touchPoint = [self convertPoint:point toView:self];
        inside = CGRectContainsPoint(self.button.frame, touchPoint);
    }

    return inside;
}

-(UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _button.frame = CGRectMake(-100, 150, 80, 30);
        [_button setTitle:@"试试能点不" forState:(UIControlStateNormal)];
        [_button addTarget:self action:@selector(clicked:) forControlEvents:(UIControlEventTouchUpInside)];
        _button.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _button;
}

#pragma mark -
#pragma mark - Action
-(void)clicked:(UIButton*)sender{
    
    OutsideBackViewBlock block = self.block;
    if (block) {
        block(sender);
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(outsideBackView:buttonClickAtIndex:)]) {
        [self.delegate outsideBackView:self buttonClickAtIndex:sender.tag];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
