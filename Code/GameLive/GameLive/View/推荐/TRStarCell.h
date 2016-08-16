//
//  TRStarCell.h
//  GameLive
//
//  Created by tarena on 16/8/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@class TRStarCell;
@protocol TRStarCellDataSource <NSObject>
- (NSInteger)numberOfItemInStarCell:(TRStarCell *)cell;
- (NSURL *)starCell:(TRStarCell *)cell iconURLAtIndex:(NSInteger)index;
- (NSString *)starCell:(TRStarCell *)cell titleAtIndex:(NSInteger)index;
@end

@protocol TRStarCellDelegate <NSObject>
- (void)starCell:(TRStarCell *)cell didSelectedIndex:(NSInteger)index;
@end


@interface TRStarCell : UICollectionViewCell

@property (nonatomic) iCarousel *ic;

@property (nonatomic, weak) id<TRStarCellDelegate> delegate;
@property (nonatomic, weak) id<TRStarCellDataSource> dataSource;

- (void)reloadData;
@end
















