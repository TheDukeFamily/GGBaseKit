//
//  GGTabBarViewController.m
//  GGBaseKit
//
//  Created by Mac on 2018/5/29.
//  Copyright © 2018年 Mr.Gao. All rights reserved.
//

#import "GGTabBarViewController.h"
#import "GGNavgationController.h"
#import "GGTabBars.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"

@interface GGTabBarViewController ()

@end

@implementation GGTabBarViewController

+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    attrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"666666"];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"f02b2b"];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    [self setUpAllChildViewController];
}

- (void)setUpAllChildViewController{
    [self setupChildViewController:[[OneViewController alloc] init] title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    [self setupChildViewController:[[TwoViewController alloc] init] title:@"游戏" imageName:@"tabbar_game" selectedImageName:@"tabbar_game_selected"];
    [self setupChildViewController:[[ThreeViewController alloc] init] title:@"商城" imageName:@"tabbar_mall" selectedImageName:@"tabbar_mall_selected"];
    [self setupChildViewController:[[FourViewController alloc] init] title:@"我的" imageName:@"tabbar_user" selectedImageName:@"tabbar_user_selected"];
    
    // 更换tabBar
    [self setValue:[[GGTabBars alloc] init] forKeyPath:@"tabBar"];
}

- (void)setupChildViewController:(UIViewController *)controller title:(NSString *)title imageName:(NSString *)image selectedImageName:(NSString *)selectedImage{
    controller.navigationItem.title = title;
    controller.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.title = title;
   
    GGNavgationController *nav = [[GGNavgationController alloc] initWithRootViewController:controller];
    
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
