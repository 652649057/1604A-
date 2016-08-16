//
//  TRLiveCell.m
//  GameLive
//
//  Created by tarena on 16/8/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRLiveCell.h"

@implementation TRLiveCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UILabel *)titleLb {
    if(_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont systemFontOfSize:13];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.top.equalTo(self.iconIV.mas_bottom);
            make.height.equalTo(30);
        }];
    }
    return _titleLb;
}

- (UILabel *)viewLb {
    if(_viewLb == nil) {
        _viewLb = [[UILabel alloc] init];
        [self.maskView addSubview:_viewLb];
        _viewLb.textColor = [UIColor whiteColor];
        _viewLb.font = [UIFont systemFontOfSize:11];
        
        [_viewLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-2);
            make.centerY.equalTo(0);
        }];
        
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"用户名"]];
        [self.maskView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.width.height.equalTo(10);
            make.right.equalTo(_viewLb.mas_left).equalTo(-5);
        }];
    }
    return _viewLb;
}

- (UILabel *)nickLb {
    if(_nickLb == nil) {
        _nickLb = [[UILabel alloc] init];
        _nickLb.textColor = [UIColor whiteColor];
        _nickLb.font = [UIFont systemFontOfSize:11];
        [self.maskView addSubview:_nickLb];
        //左侧话筒图标
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"主播名"]];
        [self.maskView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(5);
            make.width.height.equalTo(10);
        }];
        
        [_nickLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iv.mas_right).equalTo(2);
            make.centerY.equalTo(0);
        }];
    }
    return _nickLb;
}

- (UIView *)maskView {
    if(_maskView == nil) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = kRGBA(0, 0, 0, .6);
        [self.iconIV addSubview:_maskView];
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(20);
        }];
    }
    return _maskView;
}

- (UIImageView *)iconIV {
    if(_iconIV == nil) {
        _iconIV = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconIV];
        [_iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(0);
        }];
    }
    return _iconIV;
}



@end
