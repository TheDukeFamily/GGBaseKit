//
//  AppDelegate.m
//  GGBaseKit
//
//  Created by Mac on 2018/5/29.
//  Copyright © 2018年 Mr.Gao. All rights reserved.
//

#import "AppDelegate.h"
#import "GGTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[GGTabBarViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
