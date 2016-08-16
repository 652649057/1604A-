//
//  AppDelegate.m
//  GameLive
//
//  Created by tarena on 16/7/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarController.h"
#import "TRNetManager.h"
#import "WelcomeViewController.h"

@interface AppDelegate ()
@end
@implementation AppDelegate
/*
 1. 首次安装 显示欢迎页
 2. 升级安装 显示欢迎页
 3. 已经进入过主页面了 不显示欢迎页
 实现:
 如果进入过欢迎页: 则保存当前的软件版本号
 每次启动时: 判断系统的版本号, 和 保存过的启动版本号是否一致.
 
 */

- (UIWindow *)window{
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_window makeKeyAndVisible];
        _window.rootViewController = [MyTabBarController new];
    }
    return _window;
}
- (UIWindow *)welcomeWindow{
    if (!_welcomeWindow) {
        //显示欢迎页的窗口. 后初始化的窗口显示在最上方. 被用户可见.
        //注意此写法对于storyboard不好用, 因为生命周期的问题.
        _welcomeWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        //window初始化之后, 默认是隐藏的
        _welcomeWindow.hidden = NO;
        _welcomeWindow.rootViewController = [WelcomeViewController new];
        //窗口的层级关系, 数值越大, 则显示在上层 默认是0
        _welcomeWindow.windowLevel = 1;
    }
    return _welcomeWindow;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configSystem:launchOptions];
    //获取当前系统版本号
    NSDictionary *infoDic = [NSBundle mainBundle].infoDictionary;
    NSLog(@"%@", infoDic);
    NSString *version = infoDic[@"CFBundleShortVersionString"];
    //假设已经读取的版本号, key 是 ReadVersion
    NSString *readVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"ReadVersion"];
    
    if (![readVersion isEqualToString:version]) {
        [self welcomeWindow];
    }
    [self window];
    return YES;
}

@end
