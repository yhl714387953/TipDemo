//
//  OutsideViewController.m
//  小技巧测试
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "OutsideViewController.h"
#import "BOBackView.h"
#import "OutsideBackView.h"

@interface OutsideViewController ()<OutsideBackViewDelegate>
@property (weak, nonatomic) IBOutlet BOBackView *boBackView;
@property (weak, nonatomic) IBOutlet OutsideBackView *outsideBackView;

@end

@implementation OutsideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addButton];
    
    [self backViewBlock];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - init
-(void)addButton{
    UIButton* button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.frame = CGRectMake(-100, 150, 80, 30);
    [button setTitle:@"试试能点不" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(clicked:) forControlEvents:(UIControlEventTouchUpInside)];
    button.backgroundColor = [UIColor lightGrayColor];
    
    [self.boBackView addSubview:button];
    
    UIButton* button1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button1.frame = CGRectMake(-100, 200, 80, 30);
    [button1 setTitle:@"试试能点不" forState:(UIControlStateNormal)];
    [button1 addTarget:self action:@selector(clicked:) forControlEvents:(UIControlEventTouchUpInside)];
    button1.backgroundColor = [UIColor lightGrayColor];
    
    [self.boBackView addSubview:button1];
}

#pragma mark -
#pragma mark - Action
-(void)clicked:(UIButton*)sender{
    UIAlertController* ac = [UIAlertController alertControllerWithTitle:@"点击测试" message:@"点到了" preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:ac animated:YES completion:^{
        
    }];
    
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [ac addAction:action];
//    NSLog(@"点到了");
}

#pragma mark -
#pragma mark - OutsideBackViewDelegate
-(void)outsideBackView:(OutsideBackView *)view buttonClickAtIndex:(NSInteger)index{
    [self clicked:nil];
}

#pragma mark -
#pragma mark - OutsideBackViewBlock
-(void)backViewBlock{
    __weak typeof(self)weakSelf = self;
    self.outsideBackView.block = ^(id obj){
        [weakSelf clicked:nil];
    };
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
