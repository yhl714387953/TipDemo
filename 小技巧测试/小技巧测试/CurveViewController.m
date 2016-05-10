//
//  CurveViewController.m
//  小技巧测试
//
//  Created by Mac on 16/5/6.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CurveViewController.h"
#import "ZYCurveView.h"

@interface CurveViewController ()
@property (weak, nonatomic) IBOutlet ZYCurveView *curveView;
@property (nonatomic, strong) NSTimer* timer;
@end

@implementation CurveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.curveView.maxValue = 220;
    // Do any additional setup after loading the view.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - Action
//开始
- (IBAction)start:(UIButton *)sender {
    [self pause:nil];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(addPoint:) userInfo:nil repeats:YES];
}

//暂停
- (IBAction)pause:(UIButton *)sender {
    [self.timer invalidate];
}

//清除
- (IBAction)clear:(UIButton *)sender {
    [self pause:nil];
    [self.curveView clear];
}

//添加点
-(void)addPoint:(NSTimer*)timer{
    NSMutableArray* array = [NSMutableArray array];
    for (int i = 0; i < 3; i++){
        [array addObject:@(arc4random() % 180 + 20)];
    }
    
    [self.curveView addValue:array];
}

-(void)dealloc{
    NSLog(@"%@销毁了", self.class.description);
    
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
