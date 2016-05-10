//
//  ProgressViewController.m
//  小技巧测试
//
//  Created by Mac on 16/5/10.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ProgressViewController.h"
#import "ZYCircleProgressView.h"

@interface ProgressViewController ()
@property (weak, nonatomic) IBOutlet ZYCircleProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)drawProgress:(UIButton *)sender {
    
    [self.progressView resetProgress:80];
}
- (IBAction)resetZero:(UIButton *)sender {
    [self.progressView resetProgress:0];
}
- (IBAction)sliderChanged:(UISlider *)sender {
    [self.progressView resetProgress:sender.value];
    self.progressLabel.text = [NSString stringWithFormat:@"%0.0f", sender.value];
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
