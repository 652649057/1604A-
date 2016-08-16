//
//  TRAdCell.h
//  GameLive
//
//  Created by tarena on 16/8/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h" //此文件在Vendor文件夹中

@class TRAdCell;
@protocol TRAdCellDataSource <NSObject>
- (NSInteger)numberOfItemsInCell:(TRAdCell *)cell;
- (NSURL *)iconURLForItemInCell:(TRAdCell *)cell atIndex:(NSInteger)index;
- (NSString *)titleForItemInCell:(TRAdCell *)cell atIndex:(NSInteger)index;
@end

@protocol TRAdCellDelegate <NSObject>
- (void)adCell:(TRAdCell *)cell didSelectedIconAtIndex:(NSInteger)index;
@end

@interface TRAdCell : UICollectionViewCell
@property (nonatomic) iCarousel *ic;
@property (nonatomic) UILabel *titleLb;
@property (nonatomic) UIPageControl *pc;
@property (nonatomic, weak) id<TRAdCellDelegate> delegate;
@property (nonatomic, weak) id<TRAdCellDataSource> dataSource;

- (void)reloadData;

@property (nonatomic) NSTimer *timer;




@end
