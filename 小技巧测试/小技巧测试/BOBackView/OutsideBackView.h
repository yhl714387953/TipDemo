//
//  OutsideBackView.h
//  小技巧测试
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^OutsideBackViewBlock)(id obj);

@class OutsideBackView;
@protocol OutsideBackViewDelegate <NSObject>
@optional
-(void)outsideBackView:(OutsideBackView*)view buttonClickAtIndex:(NSInteger)index;

@end

@interface OutsideBackView : UIView

@property (nonatomic, copy) OutsideBackViewBlock block;
@property (nonatomic, weak) IBOutlet id<OutsideBackViewDelegate> delegate;

@property (nonatomic, strong) UIButton* button;
@end
