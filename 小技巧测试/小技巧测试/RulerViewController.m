//
//  RulerViewController.m
//  小技巧测试
//
//  Created by Mac on 16/5/12.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "RulerViewController.h"
#import "ZYRulerView.h"

@interface RulerViewController ()<ZYRulerViewDelegate>
@property (weak, nonatomic) IBOutlet ZYRulerView *rulerView;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end

@implementation RulerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rulerView.maxValue = 330;
    [self.rulerView resetRuler];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    [self.rulerView setCurrentValue:5.5 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)zyRulerView:(ZYRulerView *)view value:(CGFloat)value{
    NSLog(@"%f", value);
    
    self.valueLabel.text = [NSString stringWithFormat:@"当前值: %0.1f", value / 10.0f];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
