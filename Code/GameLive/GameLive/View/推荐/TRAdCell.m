//
//  TRAdCell.m
//  GameLive
//
//  Created by tarena on 16/8/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRAdCell.h"

@interface TRAdCell ()<iCarouselDelegate, iCarouselDataSource>
//浅黑色蒙层, 不需要暴露给外部
@property (nonatomic) UIView *maskView;
@end

@implementation TRAdCell
#pragma mark - ic Delegate
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    if ([_dataSource respondsToSelector:@selector(numberOfItemsInCell:)]) {
        return [_dataSource numberOfItemsInCell:self];
    }
    return 0;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (view == nil) {
        view = [[UIImageView alloc] initWithFrame:carousel.bounds];
    }
    if ([_dataSource respondsToSelector:@selector(iconURLForItemInCell:atIndex:)]) {
        [((UIImageView *)view) setImageWithURL:[_dataSource iconURLForItemInCell:self atIndex:index] placeholder:[UIImage imageNamed:@"主播正在赶来"]];
    }else{
        ((UIImageView *)view).image = [UIImage imageNamed:@"主播正在赶来"];
    }
    return view;
}
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    _pc.currentPage = carousel.currentItemIndex;
    if ([_dataSource respondsToSelector:@selector(titleForItemInCell:atIndex:)]) {
        _titleLb.text = [_dataSource titleForItemInCell:self atIndex:carousel.currentItemIndex];
    }
    
}
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if ([_delegate respondsToSelector:@selector(adCell:didSelectedIconAtIndex:)]) {
        [_delegate adCell:self didSelectedIconAtIndex:index];
    }
}
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    if (option == iCarouselOptionWrap) {
        value = YES;
    }
    return value;
}

#pragma mark - Method 方法
- (void)reloadData{
    if ([_dataSource respondsToSelector:@selector(numberOfItemsInCell:)]) {
        _pc.numberOfPages = [_dataSource numberOfItemsInCell:self];
    }
    if ([_dataSource respondsToSelector:@selector(titleForItemInCell:atIndex:)]) {
        if ([_dataSource respondsToSelector:@selector(numberOfItemsInCell:)]) {
            if ([_dataSource numberOfItemsInCell:self] > 0) {
                self.titleLb.text = [_dataSource titleForItemInCell:self atIndex:0];
            }
        }

    }
    [_ic reloadData];
    
    [_timer invalidate];
    _timer = nil;
    
    _timer = [NSTimer bk_scheduledTimerWithTimeInterval:2 block:^(NSTimer *timer) {
        [self.ic scrollToItemAtIndex:_ic.currentItemIndex + 1 animated:YES];
    } repeats:YES];
}

#pragma mark - LifeCycle 生命周期

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self ic];
        [self titleLb];
        [self pc];
    }
    return self;
}

#pragma mark - LazyLoad 懒加载
- (UIPageControl *)pc {
    if(_pc == nil) {
        _pc = [[UIPageControl alloc] init];
        [self.maskView addSubview:_pc];
        [_pc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-5);
            make.centerY.equalTo(0);
        }];
    }
    return _pc;
}

- (UILabel *)titleLb {
    if(_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = [UIColor whiteColor];
        [self.maskView addSubview:_titleLb];
        _titleLb.font = [UIFont systemFontOfSize:14];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
        }];
    }
    return _titleLb;
}

- (iCarousel *)ic {
    if(_ic == nil) {
        _ic = [[iCarousel alloc] init];
        [self.contentView addSubview:_ic];
        [_ic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _ic.delegate = self;
        _ic.dataSource = self;
        _ic.scrollSpeed = .2;
    }
    return _ic;
}

- (UIView *)maskView {
	if(_maskView == nil) {
		_maskView = [[UIView alloc] init];
        _maskView.backgroundColor = kRGBA(0, 0, 0, .6);
        [self.contentView addSubview:_maskView];
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(0);
            make.height.equalTo(30);
        }];
	}
	return _maskView;
}

@end
