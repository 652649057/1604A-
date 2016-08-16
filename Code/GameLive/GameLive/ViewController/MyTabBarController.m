//
//  MyTabBarController.m
//  GameLive
//
//  Created by tarena on 16/7/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyTabBarController.h"
#import "MineViewController.h"
#import "TopViewController.h"
#import "IntroViewController.h"
#import "LiveViewController.h"

@interface MyTabBarController ()
@property (nonatomic) MineViewController *mineVC;
@property (nonatomic) TopViewController *topVC;
@property (nonatomic) IntroViewController *introVC;
@property (nonatomic) LiveViewController *liveVC;
@end

@implementation MyTabBarController
#pragma mark - LifeCycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    //修改某个控件的某个属性的默认值
    [UITabBar appearance].translucent = NO;
    [UINavigationBar appearance].translucent = NO;
    //设置导航栏颜色
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:252/255.0 green:50/255.0 blue:41/255.0 alpha:1.0];
    //调整导航栏中的元素颜色为白色
    [UINavigationBar appearance].barStyle = UIBarStyleBlackOpaque;
    //tintColor:会影响到所有子视图的高亮颜色
    [UITabBar appearance].tintColor = [UIColor colorWithRed:252/255.0 green:50/255.0 blue:41/255.0 alpha:1.0];
    
    
    UINavigationController *navi0 = [[UINavigationController alloc] initWithRootViewController:self.introVC];
    UINavigationController *navi1 = [[UINavigationController alloc] initWithRootViewController:self.topVC];
    UINavigationController *navi2 = [[UINavigationController alloc] initWithRootViewController:self.liveVC];
    UINavigationController *navi3 = [[UINavigationController alloc] initWithRootViewController:self.mineVC];
    self.viewControllers = @[navi0, navi1, navi2, navi3];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LazyLoad 懒加载
- (LiveViewController *)liveVC {
	if(_liveVC == nil) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        CGFloat width = (kScreenW - 3 * 10) / 2;
        //390 219
        CGFloat height = width * 219 / 390 + 30;
        layout.itemSize = CGSizeMake((long)width, height);
		_liveVC = [[LiveViewController alloc] initWithCollectionViewLayout:layout];
        _liveVC.title = @"直播";
        _liveVC.tabBarItem.image = [UIImage imageNamed:@"发现_默认"];
        //需要修改高亮图片 在图片文件夹中, 选择图片->修改它的Render As 为 original image
        _liveVC.tabBarItem.selectedImage = [UIImage imageNamed:@"发现_焦点"];
	}
	return _liveVC;
}

- (IntroViewController *)introVC {
	if(_introVC == nil) {
		_introVC = [[IntroViewController alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
        _introVC.title = @"推荐";
        _introVC.tabBarItem.image = [UIImage imageNamed:@"推荐_默认"];
        _introVC.tabBarItem.selectedImage = [UIImage imageNamed:@"推荐_焦点"];
	}
	return _introVC;
}

- (TopViewController *)topVC {
	if(_topVC == nil) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        CGFloat width = (kScreenW - 4 * 10) / 3;
        //345 450
        CGFloat height = width * 450 / 345 + 30;
        layout.itemSize = CGSizeMake((long)width, height);
		_topVC = [[TopViewController alloc] initWithCollectionViewLayout:layout];
        _topVC.title = @"栏目";
        _topVC.tabBarItem.image = [UIImage imageNamed:@"栏目_默认"];
        _topVC.tabBarItem.selectedImage = [UIImage imageNamed:@"栏目_焦点"];
	}
	return _topVC;
}

- (MineViewController *)mineVC {
	if(_mineVC == nil) {
		_mineVC = [[MineViewController alloc] initWithStyle:UITableViewStyleGrouped];
        _mineVC.title = @"我的";
        _mineVC.tabBarItem.image = [UIImage imageNamed:@"我的_默认"];
        _mineVC.tabBarItem.selectedImage = [UIImage imageNamed:@"我的_焦点"];
	}
	return _mineVC;
}

@end
