//
//  TestViewController.m
//  FunkyFM
//
//  Created by 胡晟 on 2017/5/27.
//  Copyright © 2017年 胡晟. All rights reserved.
//

#import "TestViewController.h"
#import "Test2ViewController.h"


@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.tag = 666;
    self.view.backgroundColor = [UIColor redColor];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    NSLog(@"摸到我了");
    static BOOL isPlay = NO;
    isPlay = !isPlay;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playState" object:@(isPlay)];
    UIImage *image = [UIImage imageNamed:@"zxy_icon"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playImage" object:image];
    //
    [self.navigationController pushViewController:[Test2ViewController new] animated:YES];
    
    
    
}

@end
