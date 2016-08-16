//
//  TRIntroSectionHeaderView.h
//  GameLive
//
//  Created by tarena on 16/8/3.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TRRecommendCellType) {
    TRRecommendCellTypeUnknown,
    TRRecommendCellTypeMore, //更多
    TRRecommendCellTypeChange, //换一换
};
@interface TRIntroSectionHeaderView : UICollectionReusableView
@property (nonatomic) UILabel *titleLb;
//UIControl是UIView的子类, 不仅可以显示. 还可以接受用户点击事件
@property (nonatomic) UIControl *rightC;

@property (nonatomic) TRRecommendCellType cellType;
//右侧按钮点击时的回调事件
@property (nonatomic, copy) void(^btnClicked)(NSInteger section);
//当前头是属于哪个section, 回调时使用.
@property (nonatomic) NSInteger section;
@end









