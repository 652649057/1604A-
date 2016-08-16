//
//  TRRoomListViewController.m
//  GameLive
//
//  Created by tarena on 16/8/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRRoomListViewController.h"
#import "TRRoomListViewModel.h"
#import "TRLiveCell.h"

@import AVKit;
@import AVFoundation;

@interface TRRoomListViewController ()
@property (nonatomic) TRRoomListViewModel *roomListVM;
@end

@implementation TRRoomListViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithSlug:(NSString *)slug{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    CGFloat width = (kScreenW - 3 * 10) / 2;
    //390 219
    CGFloat height = width * 219 / 390 + 30;
    layout.itemSize = CGSizeMake(width, height);
    
    if (self = [super initWithCollectionViewLayout:layout]) {
        //push操作时, 隐藏tabbar
        self.hidesBottomBarWhenPushed = YES;
        _slug = slug;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = kRGBA(234, 234, 234, 1);
    [self.collectionView registerClass:[TRLiveCell class] forCellWithReuseIdentifier:reuseIdentifier];
    __weak typeof(self) weakSelf = self;
    [self.collectionView addHeaderRefresh:^{
        [weakSelf.roomListVM getDataWithMode:RequestModeRefresh completionHandler:^(NSError *error) {
            [weakSelf.collectionView reloadData];
            [weakSelf.collectionView endHeaderRefresh];
        }];
    }];
    [self.collectionView beginHeaderRefresh];
    [self.collectionView addFooterRefresh:^{
        [weakSelf.roomListVM getDataWithMode:RequestModeMore completionHandler:^(NSError *error) {
            [weakSelf.collectionView reloadData];
            [weakSelf.collectionView endFooterRefresh];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.roomListVM.rowNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TRLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell.iconIV setImageWithURL:[self.roomListVM iconURLForRow:indexPath.row] placeholder:[UIImage imageNamed:@"主播正在赶来"]];
    cell.nickLb.text = [self.roomListVM nickForRow:indexPath.row];
    cell.titleLb.text = [self.roomListVM titleForRow:indexPath.row];
    cell.viewLb.text = [self.roomListVM viewForRow:indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    AVPlayerViewController *vc = [AVPlayerViewController new];
    vc.player = [AVPlayer playerWithURL:[self.roomListVM uidForRow:indexPath.row].yx_VideoURL];
    //NSLog(@"%@", [self.liveVM uidForRow:indexPath.row].yx_VideoURL);
    [vc.player play];
    [self presentViewController:vc animated:YES completion:nil];
}


#pragma mark - LazyLoad 懒加载
- (TRRoomListViewModel *)roomListVM {
	if(_roomListVM == nil) {
		_roomListVM = [[TRRoomListViewModel alloc] initWithSlug:_slug];
	}
	return _roomListVM;
}

@end
