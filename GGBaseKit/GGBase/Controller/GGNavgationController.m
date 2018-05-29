//
//  GGNavgationController.m
//  GGBaseKit
//
//  Created by Mac on 2018/5/29.
//  Copyright © 2018年 Mr.Gao. All rights reserved.
//

#define GGNavBgColor [UIColor colorWithHexString:@"f02b2b"]
#define GGNavBgFontColor [UIColor colorWithHexString:@"ffffff"]

#import "GGNavgationController.h"

@interface GGNavgationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,assign) BOOL isSystemSlidBack;//是否开启系统右滑返回
@end

@implementation GGNavgationController

+ (void)initialize{
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBarTintColor:GGNavBgColor];
    [navBar setTintColor:GGNavBgFontColor];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:GGNavBgFontColor,NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [navBar setBackgroundImage:[UIImage imageWithColor:GGNavBgColor] forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     //默认开启系统右划返回
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = self;
}

//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    if (_isSystemSlidBack) {
//        self.interactivePopGestureRecognizer.enabled = YES;
//    }else{
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
//}
//
////根视图禁用右划返回
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    return self.childViewControllers.count == 1 ? NO:YES;
//}
//
////push时隐藏Tabbar
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    if (self.childViewControllers.count) {//不是根视图
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
//    [super pushViewController:viewController animated:animated];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
