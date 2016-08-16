//
//  IntroViewController.m
//  GameLive
//
//  Created by tarena on 16/7/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "IntroViewController.h"
#import "TRAdCell.h"
#import "TRIntroViewModel.h"
#import "TRStarCell.h"
#import "TRLiveCell.h"
#import "TRIntroSectionHeaderView.h"
#import "TRRoomListViewController.h"

@import AVKit;
@import AVFoundation;

@interface IntroViewController ()<UICollectionViewDelegateFlowLayout, TRAdCellDelegate, TRAdCellDataSource, TRStarCellDataSource, TRStarCellDelegate>
@property (nonatomic) TRIntroViewModel *introVM;
@end

@implementation IntroViewController
#pragma mark - TRStarCell Delegate
- (NSString *)starCell:(TRStarCell *)cell titleAtIndex:(NSInteger)index{
    return [self.introVM starNameForRow:index];
}
- (NSURL *)starCell:(TRStarCell *)cell iconURLAtIndex:(NSInteger)index{
    return [self.introVM starIconURLForRow:index];
}
- (NSInteger)numberOfItemInStarCell:(TRStarCell *)cell{
    return self.introVM.starNum;
}

- (void)starCell:(TRStarCell *)cell didSelectedIndex:(NSInteger)index{
    AVPlayerViewController *vc = [AVPlayerViewController new];
    vc.player = [AVPlayer playerWithURL:[self.introVM starVideoURLForRow:index]];
    //NSLog(@"%@", [self.introVM starVideoURLForRow:index].absoluteString);
    [self presentViewController:vc animated:YES completion:nil];
    [vc.player play];
}

#pragma mark - TRAdCell Delegate
- (NSInteger)numberOfItemsInCell:(TRAdCell *)cell{
    return self.introVM.indexNum;
}
- (NSURL *)iconURLForItemInCell:(TRAdCell *)cell atIndex:(NSInteger)index{
    return [self.introVM indexIconURLForRow:index];
}
- (void)adCell:(TRAdCell *)cell didSelectedIconAtIndex:(NSInteger)index{
    AVPlayerViewController *vc = [AVPlayerViewController new];
    vc.player = [AVPlayer playerWithURL:[self.introVM videoURLForRow:index]];
    [self presentViewController:vc animated:YES completion:nil];

    [vc.player play];
}
- (NSString *)titleForItemInCell:(TRAdCell *)cell atIndex:(NSInteger)index{
    return [self.introVM indexTitleForRow:index];
}

#pragma mark - LifeCycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = kRGBA(234, 234, 234, 1);
    [self.collectionView registerClass:[TRAdCell class] forCellWithReuseIdentifier:@"TRAdCell"];
    [self.collectionView registerClass:[TRStarCell class] forCellWithReuseIdentifier:@"TRStarCell"];
    [self.collectionView registerClass:[TRLiveCell class] forCellWithReuseIdentifier:@"TRLiveCell"];
    [self.collectionView registerClass:[TRIntroSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TRIntroSectionHeaderView"];
    
    __weak typeof(self) weakSelf = self;
    [self.collectionView addHeaderRefresh:^{
        [weakSelf.introVM getDataWithMode:RequestModeRefresh completionHandler:^(NSError *error) {
            [weakSelf.collectionView endHeaderRefresh];
            [weakSelf.collectionView reloadData];
        }];
    }];
    
    [self.collectionView beginHeaderRefresh];
}

#pragma mark - UICollectionView Delegate

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        TRIntroSectionHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"TRIntroSectionHeaderView" forIndexPath:indexPath];
        if (indexPath.section == 1) {
            view.titleLb.text = @"推荐";
            view.cellType = TRRecommendCellTypeChange;
            view.btnClicked = ^(NSInteger section){
//                DDLogVerbose(@"change");
                [self.introVM changeRecommendRandomList];
                [collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
            };
        }
        if (indexPath.section > 1) {
            view.titleLb.text = [self.introVM categoryNameAtSection:indexPath.section - 2];
            view.section = indexPath.section;
            view.btnClicked = ^(NSInteger section){
                TRRoomListViewController *vc = [[TRRoomListViewController alloc] initWithSlug:[self.introVM slugAtSection:section-2]];
                [self.navigationController pushViewController:vc animated:YES];
            };
            view.cellType = TRRecommendCellTypeMore;
        }
        
        return view;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section > 0) {
        return CGSizeMake(0, 50); //宽度无用, 永远与collectionView同宽
    }
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsZero;
    }
    //最后一个分组的脚部, 有10像素的间隔. 第三参数是10
    if (section == self.introVM.others.count + 1) {
        return UIEdgeInsetsMake(0, 10, 10, 10);
    }
    //cell的内边距, 参数1, 3代表上下, 对应的sectionHeader/footer的距离. 这里是0
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 10;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //720 * 400
            return CGSizeMake(kScreenW, kScreenW * 400 / 720);
        }else{
            return CGSizeMake(kScreenW, 100);
        }
    }
    
    CGFloat width = (long)((kScreenW - 3 * 10)/2);
    CGFloat height = width * 219 / 390 + 30;
    return CGSizeMake(width, height);
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2 + self.introVM.others.count; //暂时先写2个
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
       return self.introVM.recommendNum;
    }
    return [self.introVM rowNumberAtSection:section-2];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            TRAdCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TRAdCell" forIndexPath:indexPath];
            cell.dataSource = self;
            cell.delegate = self;
            [cell reloadData];
            return cell;
        }else{
            TRStarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TRStarCell" forIndexPath:indexPath];
            cell.delegate = self;
            cell.dataSource = self;
            [cell reloadData];
            return cell;
        }
    }
    
    if (indexPath.section == 1) { //推荐
        TRLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TRLiveCell" forIndexPath:indexPath];
        [cell.iconIV setImageWithURL:[self.introVM recommendIconURLForRow:indexPath.row] placeholder:[UIImage imageNamed:@"主播正在赶来"]];
        cell.nickLb.text = [self.introVM recommendNickForRow:indexPath.row];
        cell.titleLb.text = [self.introVM recommendTitleForRow:indexPath.row];
        cell.viewLb.text = [self.introVM recommendViewForRow:indexPath.row];
        return cell;
    }
    
    //其他
    NSIndexPath *ip = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - 2];
    TRLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TRLiveCell" forIndexPath:ip];
    [cell.iconIV setImageWithURL:[self.introVM iconURLAtIndexPath:ip] placeholder:[UIImage imageNamed:@"主播正在赶来"]];
    cell.nickLb.text = [self.introVM nickAtIndexPath:ip];
    cell.titleLb.text = [self.introVM titleAtIndexPath:ip];
    cell.viewLb.text = [self.introVM viewAtIndexPath:ip];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSURL *videoURL = nil;
    switch (indexPath.section) {
        case 0:
            return;
            break;
        case 1:
            videoURL = [self.introVM recommendVideoURLForRow:indexPath.row];
            break;
        default:
        {
            NSIndexPath *ip = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - 2];
            videoURL = [self.introVM videoURLAtIndexPath:ip];
        }
            break;
    }
    
    AVPlayerViewController *vc = [AVPlayerViewController new];
    vc.player = [AVPlayer playerWithURL:videoURL];
    DDLogInfo(@"%@", videoURL.absoluteString);
    [self presentViewController:vc animated:YES completion:nil];
    [vc.player play];
}


#pragma mark - LazyLoad 懒加载
- (TRIntroViewModel *)introVM {
	if(_introVM == nil) {
		_introVM = [[TRIntroViewModel alloc] init];
	}
	return _introVM;
}

@end
