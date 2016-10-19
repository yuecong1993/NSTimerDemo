//
//  ViewController.m
//  text
//
//  Created by yishanmen on 16/10/19.
//  Copyright © 2016年 yishanmen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIButton *controlBtn,*clearBtn, *speedBtn;
@property (nonatomic,strong) NSTimer *myTimer;
@property (nonatomic,assign) CGFloat timerSpeed;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.myTimer = [[NSTimer alloc] init];
    
    [self initUI];
    [self controSpeed:1.0];
    
    self.timerSpeed = 1.0;
}

- (void)controSpeed:(CGFloat)inter{
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:inter target:self selector:@selector(numberAdd) userInfo:nil repeats:YES];
}

- (void)initUI{
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    _timeLabel.textColor = [UIColor redColor];
    _timeLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.timeLabel];
    _timeLabel.text = @"0";
    
    self.controlBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 100, 50, 50)];
    [self.controlBtn setTitle:@"暂停" forState:UIControlStateNormal];
    [self.controlBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:_controlBtn];
    [_controlBtn addTarget:self action:@selector(pressBtn) forControlEvents:UIControlEventTouchUpInside];
    
    self.clearBtn = [[UIButton alloc] initWithFrame:CGRectMake(250, 100, 50, 50)];
    [_clearBtn setTitle:@"清零" forState:UIControlStateNormal];
    [_clearBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:_clearBtn];
    [_clearBtn addTarget:self action:@selector(clearNum) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.speedBtn = [[UIButton alloc] initWithFrame:CGRectMake(250, 150, 50, 50)];
    [_speedBtn setTitle:@"加速" forState:UIControlStateNormal];
    [_speedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:_speedBtn];
    [_speedBtn addTarget:self action:@selector(speedNum) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)numberAdd{
    
    int i = [self.timeLabel.text intValue];
    i++;
    self.timeLabel.text = [NSString stringWithFormat:@"%d",i];
}

- (void)pressBtn{
    
    if ([self.controlBtn.titleLabel.text isEqualToString:@"暂停"]) {
        [_myTimer setFireDate:[NSDate distantFuture]];
        [self.controlBtn setTitle:@"开始" forState:UIControlStateNormal];
    }else{
        [_myTimer setFireDate:[NSDate distantPast]];
        [self.controlBtn setTitle:@"暂停" forState:UIControlStateNormal];
    }
    
}

- (void)clearNum{
    
    self.timeLabel.text = @"0";
    self.timerSpeed = 1.0;
    [self.myTimer invalidate];
    
    [self controSpeed:self.timerSpeed];
    
}


- (void)speedNum{
    
    self.timerSpeed = self.timerSpeed/2;
    [self.myTimer invalidate];
    
    if (self.timerSpeed < 0.00001) {
        self.timerSpeed = 0.00001;
    }
    
    [self controSpeed:self.timerSpeed];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
