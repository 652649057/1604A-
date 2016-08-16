//
//  TRIntroSectionHeaderView.m
//  GameLive
//
//  Created by tarena on 16/8/3.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRIntroSectionHeaderView.h"

@implementation TRIntroSectionHeaderView
- (void)setCellType:(TRRecommendCellType)cellType{
    if (_cellType == cellType) {
        return;
    }
    _cellType = cellType;
    [_rightC removeFromSuperview];
    _rightC = nil;
    
    _rightC = [UIControl new];
    [_rightC bk_addEventHandler:^(id sender) {
        !_btnClicked ?: _btnClicked(_section);
    } forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightC];
    [_rightC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-16);
        make.centerY.equalTo(0);
    }];
    
    UILabel *label = [UILabel new];
    label.text = _cellType == TRRecommendCellTypeMore ? @"更多" : @"换一换";
    [_rightC addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.bottom.equalTo(-10);
        make.right.equalTo(0);
    }];
    
    UIImageView *icon = [UIImageView new];
    icon.image = [UIImage imageNamed:_cellType == TRRecommendCellTypeMore ? @"更多" :@"换一换"];
    [_rightC addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(label.mas_left).equalTo(-4);
        make.centerY.equalTo(label);
        make.left.equalTo(0);
    }];
}


- (void)setBtnClicked:(void (^)(NSInteger))btnClicked{
    _btnClicked = btnClicked;
}



- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        [self addSubview:_titleLb];
        
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"栏目标题"]];
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
            make.size.equalTo(CGSizeMake(4, 22));
        }];
        
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(iv.mas_right).equalTo(4);
        }];
    }
    return _titleLb;
}
@end
