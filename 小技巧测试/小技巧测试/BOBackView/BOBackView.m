//
//  BOBackView.m
//  JiaPingMember
//
//  Created by Mac on 16/3/1.
//  Copyright © 2016年 zhongkeyun. All rights reserved.
//

#import "BOBackView.h"

@implementation BOBackView

//答案很简单，重写下UIView的这个方法就行了，子视图即使超过了自己的边界也可以点击
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    BOOL inside = [super pointInside:point withEvent:event];
    
    if (!inside) {
        CGPoint tempPoint = [self convertPoint:point toView:self];//将屏幕上的点转换到自己本身上
        for (UIView* view in self.subviews) {//遍历subViews
            if (CGRectContainsPoint(view.frame, tempPoint)) {//如果这个self上的这个点包含在子视图的frame内，就认为可以响应这个点击事件, 执行下面的代码
                inside = [view pointInside:[self convertPoint:point toView:view] withEvent:event];
                break;
            }
        }
        
    }
    
    return inside;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
