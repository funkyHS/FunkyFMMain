//
//  MainModuleAPI.m
//  FunkyFMMain
//
//  Created by 胡晟 on 2017/6/2.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import "MainModuleAPI.h"
#import "HSTabBar.h"
#import "HSTabBarController.h"
#import "HSNavigationBar.h"
#import "HSMiddleView.h"

@implementation MainModuleAPI

+ (HSTabBarController *)rootTabBarCcontroller {
    return [HSTabBarController shareInstance];
}


+ (void)addChildVC:(UIViewController *)vc normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController:(BOOL)isRequired {
    
    [[HSTabBarController shareInstance] addChildVC:vc normalImageName:normalImageName selectedImageName:selectedImageName isRequiredNavController:isRequired];
    
}


+ (void)setTabbarMiddleBtnClick: (void(^)(BOOL isPlaying))middleClickBlock {
    
    HSTabBar *tabbar = (HSTabBar *)[HSTabBarController shareInstance].tabBar;
    tabbar.middleClickBlock = middleClickBlock;
    
}

/**
 *  设置全局的导航栏背景图片
 *
 *  @param globalImg 全局导航栏背景图片
 */
+ (void)setNavBarGlobalBackGroundImage: (UIImage *)globalImg {
    [HSNavigationBar setGlobalBackGroundImage:globalImg];
}
/**
 *  设置全局导航栏标题颜色, 和文字大小
 *
 *  @param globalTextColor 全局导航栏标题颜色
 *  @param fontSize        全局导航栏文字大小
 */
+ (void)setNavBarGlobalTextColor: (UIColor *)globalTextColor andFontSize: (CGFloat)fontSize {
    
    [HSNavigationBar setGlobalTextColor:globalTextColor andFontSize:fontSize];
    
}

+ (UIView *)middleView {
    return [HSMiddleView middleView];
}


@end
