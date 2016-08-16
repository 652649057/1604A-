//
//  WelcomeViewController.m
//  Day04_1_Welcome
//
//  Created by tarena on 16/8/3.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "WelcomeViewController.h"
#import "iCarousel.h"
#import "AppDelegate.h"

@import AVFoundation;

@interface WelcomeViewController ()<iCarouselDelegate, iCarouselDataSource>
@property (nonatomic) iCarousel *ic;
@property (nonatomic) NSArray<UIImage *> *imageList;
//显示视频内容的
@property (nonatomic) AVPlayerLayer *playerLayer;

@end

@implementation WelcomeViewController
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    //当点击滚动栏中的最后一张图时, 切换当前控制器的所在的window的根视图控制器为主页面
    //self.view.window.rootViewController = [ViewController new];
    
    //点击以后, 让欢迎页的所在的window, 逐渐变透明, 并且放大

    //判断是否是最后一页
    if (index == _imageList.count -1) {
        
    [UIView animateWithDuration:1 animations:^{
        self.view.window.alpha = 0;
        //view 三大属性: bounds,  frame, transform
        self.view.window.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        delegate.welcomeWindow.hidden = YES;
        //释放欢迎控制器的指针索引
        delegate.welcomeWindow.rootViewController = nil;
        delegate.welcomeWindow = nil;
        /*
        //设置当前版本号为已读版本号
        NSDictionary *infoDic = [NSBundle mainBundle].infoDictionary;
        NSString *version = infoDic[@"CFBundleShortVersionString"];
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"ReadVersion"];
        //NSUserDefaults从内存写入硬盘的时机,由runloop来掌握, 并不是立刻写入.
        //要想立刻写入, 则调用
        [[NSUserDefaults standardUserDefaults] synchronize]; */
    }];
    }
}
- (void)dealloc{
    //切记: 监听者必须在添加的对应生命周期中删除
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSLog(@"dealloc");
}

- (NSArray<UIImage *> *)imageList{
    if (!_imageList) {
        NSArray *imageNames960 = @[@"0welcome960", @"1welcome960", @"2welcome960"];
        NSArray *imageNames1136 = @[@"0welcome1136", @"1welcome1136", @"2welcome1136"];
        NSArray *imageNames1334 = @[@"0welcome1334", @"1welcome1334", @"2welcome1334"];
        NSArray *imageNames1472 = @[@"0welcome1472", @"1welcome1472", @"2welcome1472"];
        CGFloat height = [UIScreen mainScreen].nativeBounds.size.height;
        NSArray *imageNames = nil;
        if (height == 960) {
            imageNames = imageNames960;
        }
        if (height == 1136) {
            imageNames = imageNames1136;
        }
        if (height == 1334) {
            imageNames = imageNames1334;
        }
        //真机iphone6p的高度是1920
        if (height == 2208 || height == 1920) {
            //iphone6p的高度是2208, 美工命名有问题!
            imageNames = imageNames1472;
        }
        NSMutableArray *tmpArr = [NSMutableArray new];
        [imageNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [tmpArr addObject:[UIImage imageNamed:obj]];
        }];
        _imageList = tmpArr.copy;
    }
    return _imageList;
}

- (iCarousel *)ic{
    if (!_ic) {
        _ic = [[iCarousel alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_ic];
        _ic.delegate = self;
        _ic.dataSource = self;
        _ic.scrollSpeed = .2;
        _ic.bounces = NO;
    }
    return _ic;
}
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.imageList.count;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (!view) {
        view = [[UIImageView alloc] initWithFrame:carousel.bounds];
        view.contentMode = UIViewContentModeScaleAspectFill;
        view.clipsToBounds = YES;
    }
    ((UIImageView *)view).image = self.imageList[index];
    return view;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //视频播放需要一个短暂的加载过程, 这是闪屏的原因. 可以考虑把视图背景设置成跟启动页一样. 就不会出现问题了
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default1472"]];
    [self.view addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    //如果遇到导入项目的音视频无法获取到路径, 则把文件放入一个文件夹, 文件夹后缀名改为bundle. 然后在拖入项目. 用的时候, 路径前加上bundle的前缀
    
    //注意拖入文件 一定要把addtoTarget打上对号
    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"dyla_movie" withExtension:@"mp4"];
    //要想监听视频播放结束的时机, 必须用playerItem
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:videoURL];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    _playerLayer.frame = self.view.bounds;
    //视频播放界面的内容模式, 具体的值 是通过cmd+左键 查看注释得到的
    _playerLayer.videoGravity =AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:_playerLayer];
    [player play];
    
    //添加播放结束之后的监听
    //向消息中心中添加当前对象为一个监听者, 监听 item 的 播放结束通知, 如果监听到以后, 则触发playToEnd方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playToEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:item];
}

- (void)playToEnd{
    [_playerLayer removeFromSuperlayer];
    [self.ic reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
