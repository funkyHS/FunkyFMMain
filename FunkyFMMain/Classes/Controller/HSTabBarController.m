//
//  HSTabBarController.m
//  FunkyFM
//
//  Created by 胡晟 on 2017/5/27.
//  Copyright © 2017年 胡晟. All rights reserved.
//

#import "HSTabBarController.h"
#import "HSNavigationController.h"
#import "HSTabBar.h"
#import "HSMiddleView.h"

@interface HSTabBarController ()

@end

@implementation HSTabBarController

#pragma mark - 单列类
+ (instancetype)shareInstance {
    
    static HSTabBarController *tabbarVC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabbarVC = [[HSTabBarController alloc] init];
    });
    return tabbarVC;
}

#pragma mark - 生命周期
-(void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tabbar
    [self setUpTabbar];
    
}

- (void)setUpTabbar {
    [self setValue:[[HSTabBar alloc] init] forKey:@"tabBar"];
}


+ (instancetype)tabBarControllerWithAddChildVCsBlock: (void(^)(HSTabBarController *tabBarVC))addVCBlock {
    
    HSTabBarController *tabbarVC = [[HSTabBarController alloc] init];
    if (addVCBlock) {
        addVCBlock(tabbarVC);
    }
    
    return tabbarVC;
}

#pragma mark - 添加子控制器
- (void)addChildVC: (UIViewController *)vc normalImageName: (NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController: (BOOL)isRequired{
    
    UIImage *normalImg = [[UIImage imageNamed:normalImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    if (isRequired) {
        
        HSNavigationController *nav = [[HSNavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:normalImg selectedImage:selectedImage];
        [self addChildViewController:nav];
        
    }else {
        
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:normalImg selectedImage:selectedImage];
        //    vc.tabBarItem.title=@"消息";
        //    vc.tabBarItem.image=[UIImage imageNamed:normalImageName];
        //    vc.tabBarItem.badgeValue=@"123";
        [self addChildViewController:vc];
        
    }
    
    
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    
    UIViewController *vc = self.childViewControllers[selectedIndex];
    if (vc.view.tag == 666) {
        vc.view.tag = 888;
        
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
        [vc.view addSubview:middleView];
        
    }
    
    
}

@end
