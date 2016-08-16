//
//  TRStarCell.m
//  GameLive
//
//  Created by tarena on 16/8/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRStarCell.h"

@interface TRStarCell () <iCarouselDelegate, iCarouselDataSource>

@end

@implementation TRStarCell
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    if ([_dataSource respondsToSelector:@selector(numberOfItemInStarCell:)]) {
        return [_dataSource numberOfItemInStarCell:self];
    }
    return 0;
}
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    if (option == iCarouselOptionWrap) {
        value = YES;
    }
    return value;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (!view) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, carousel.bounds.size.height)];
        UIImageView *iv = [UIImageView new];
        [view addSubview:iv];
        iv.tag = 100;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(-10); //向上移动10
            make.centerX.equalTo(0);
            make.width.height.equalTo(50);
        }];
        iv.layer.cornerRadius = 25;
        
        UILabel *label = [UILabel new];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(iv.mas_bottom).equalTo(5);
        }];
        label.tag = 200;
    }
    
    UIImageView *iv = (UIImageView *)[view viewWithTag:100];
    UILabel *label = (UILabel *)[view viewWithTag:200];
    iv.image = [UIImage imageNamed:@"主播正在赶来"];
    label.text = nil;
    if ([_dataSource respondsToSelector:@selector(starCell:titleAtIndex:)]) {
        label.text = [_dataSource starCell:self titleAtIndex:index];
    }
    if ([_dataSource respondsToSelector:@selector(starCell:iconURLAtIndex:)]) {
        [iv setImageWithURL:[_dataSource starCell:self iconURLAtIndex:index] placeholder:[UIImage imageNamed:@"主播正在赶来"]];
    }
    
    return view;
}
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if ([_delegate respondsToSelector:@selector(starCell:didSelectedIndex:)]) {
        [_delegate starCell:self didSelectedIndex:index];
    }
}

#pragma mark - Method 方法
-(void)reloadData{
    [self.ic reloadData];
}

#pragma mark - LazyLoad 懒加载
- (iCarousel *)ic{
    if (!_ic) {
        _ic = [iCarousel new];
        [self.contentView addSubview:_ic];
        [_ic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(0);
            make.bottom.equalTo(-1); //有个一像素横线
        }];
        _ic.delegate = self;
        _ic.dataSource = self;
        //不翻页滚动
        _ic.pagingEnabled = NO;
        _ic.autoscroll = -.4;
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(0);
            make.height.equalTo(1);
        }];
    }
    return _ic;
}

@end
