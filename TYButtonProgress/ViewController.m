//
//  ViewController.m
//  TYButtonProgress
//
//  Created by tiny on 16/7/4.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import "ViewController.h"
#import "TYButtonProgress.h"

@interface ViewController ()
@property (nonatomic,strong)TYButtonProgress *skipBtn;
@property (nonatomic,strong)NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self example1];
    
    //    [self example2];
    
}

#pragma mark - 加载倒计时
-(void)example1
{
    //加载倒计时
    self.skipBtn = [[TYButtonProgress alloc] initWithFrame:CGRectMake(60,40, 50, 50) WithClockWise:NO];
    //    [self.skipBtn setBackgroundColor:[UIColor whiteColor]];
    [self.skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
    self.skipBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.skipBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.skipBtn.color = [UIColor blueColor];
    self.skipBtn.bottomRingColor = [UIColor grayColor];
    self.skipBtn.borderWidth = 5.0f;
    self.skipBtn.progress = 1.0f;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    
    [self.skipBtn addTarget:self action:@selector(skipAdClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.skipBtn];
}

#pragma mark - 类似音乐的进度圆形加载条
-(void)example2
{
    //直接设置progress就可以了
}

static int count = 100;

#pragma mark - Pravite
-(void)countdown
{
    count-=4;
    //    _countLb.text = @(count).description;
    self.skipBtn.progress = count/100.0;
    if (count == 0) {
        NSLog(@"进入主界面");
    }
}

-(void)skipAdClick
{
    if (self.timer.isValid) {
        [self.timer invalidate];
        self.timer = nil;
    }
    NSLog(@"点击了跳过");
}


@end
