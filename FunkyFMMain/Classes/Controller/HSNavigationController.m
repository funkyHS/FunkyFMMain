//
//  HSNavigationController.m
//  FunkyFM
//
//  Created by 胡晟 on 2017/5/27.
//  Copyright © 2017年 胡晟. All rights reserved.
//

#import "HSNavigationController.h"
#import "HSNavigationBar.h"
#import "HSMiddleView.h"

@interface HSNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation HSNavigationController

#pragma mark - 重写初始化方法
-(instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        
        [self setValue:[[HSNavigationBar alloc] init] forKey:@"navigationBar"];
    }
    return self;
}


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置手势代理。拿到navigationController原有的pop手势
    UIGestureRecognizer *gester = self.interactivePopGestureRecognizer;
    //    gester.delegate = self;
    
    // 自定义手势
    // 手势加在谁身上, 手势执行谁的什么方法
    UIPanGestureRecognizer *panGester = [[UIPanGestureRecognizer alloc] initWithTarget:gester.delegate action:NSSelectorFromString(@"handleNavigationTransition:")];
    
    // 其实就是控制器的容器视图   gester.view 手势的view
    [gester.view addGestureRecognizer:panGester];
    
    gester.delaysTouchesBegan = YES;
    panGester.delegate = self;
}

#pragma mark - pop返回
- (void)back {
    
    [self popViewControllerAnimated:YES];
    
}

#pragma mark - 拦截重写push方法
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 拦截每一个push的控制器, 进行统一设置
    // 过滤第一个根控制器
    if (self.childViewControllers.count > 0) {
        //        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem customBackItemWithTarget:self action:@selector(back)];
        
        //统一设置返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back_n"] style:0 target:self action:@selector(back)];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 千万不要忘记写
    [super pushViewController:viewController animated:animated];
    
    if (viewController.view.tag == 666) {
        viewController.view.tag = 888;
        HSMiddleView *middleView = [HSMiddleView middleView];
        
        middleView.middleClickBlock = [HSMiddleView shareInstance].middleClickBlock;
        middleView.isPlaying = [HSMiddleView shareInstance].isPlaying;
        middleView.middleImg = [HSMiddleView shareInstance].middleImg;
        
        CGRect frame = middleView.frame;
        frame.size.width = 65;
        frame.size.height = 65;
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        frame.origin.x = (screenSize.width - 65) * 0.5;
        frame.origin.y = screenSize.height - 65;
        middleView.frame = frame;
        [viewController.view addSubview:middleView];
        
    }
    
    
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    // 如果根控制器也要返回手势有效, 就会造成假死状态
    // 所以, 需要过滤根控制器
    if(self.childViewControllers.count == 1) {
        return NO;
    }
    
    return YES;
    
    
    
    //这里有两个条件不允许手势 1 当前控制器为根控制器 2 如果这个push  pop 动画正在执行(私有属性)
    // return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}


@end
