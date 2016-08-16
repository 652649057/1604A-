//
//  TopViewController.m
//  GameLive
//
//  Created by tarena on 16/7/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TopViewController.h"
#import "TRTopViewModel.h"
#import "TRCategoryCell.h"
#import "TRRoomListViewController.h"

@interface TopViewController ()
@property (nonatomic) TRTopViewModel *topVM;
@end

@implementation TopViewController

static NSString * const reuseIdentifier = @"Cell";
#pragma mark - LifeCycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = kRGBA(243, 243, 243, 1);
    [self.collectionView registerClass:[TRCategoryCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    __weak typeof(self) weakSelf = self;
    [self.collectionView addHeaderRefresh:^{
        [weakSelf.topVM getDataWithMode:RequestModeRefresh completionHandler:^(NSError *error) {
            [weakSelf.collectionView endHeaderRefresh];
            [weakSelf.collectionView reloadData];
        }];
    }];
    [self.collectionView beginHeaderRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UICollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.topVM.rowNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TRCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell.iconIV setImageWithURL:[self.topVM iconURLForRow:indexPath.row] placeholder:[UIImage imageNamed:@"主播正在赶来"]];
    cell.titleLb.text = [self.topVM titleForRow:indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TRRoomListViewController *vc = [[TRRoomListViewController alloc] initWithSlug:[self.topVM slugForRow:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - LazyLoad 懒加载
- (TRTopViewModel *)topVM {
	if(_topVM == nil) {
		_topVM = [[TRTopViewModel alloc] init];
	}
	return _topVM;
}

@end
