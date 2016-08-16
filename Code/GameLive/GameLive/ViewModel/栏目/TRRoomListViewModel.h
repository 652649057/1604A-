//
//  TRRoomListViewModel.h
//  GameLive
//
//  Created by tarena on 16/8/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "TRNetManager.h"

@interface TRRoomListViewModel : BaseViewModel

- (instancetype)initWithSlug:(NSString *)slug;
@property (nonatomic, readonly) NSString *slug;

@property (nonatomic, readonly) NSInteger rowNumber;
@property (nonatomic) NSMutableArray<TRRoomListDataModel *> *dataList;
@property (nonatomic) NSInteger page;

- (NSURL *)iconURLForRow:(NSInteger)row;
- (NSString *)nickForRow:(NSInteger)row;
- (NSString *)titleForRow:(NSInteger)row;
- (NSString *)uidForRow:(NSInteger)row;
- (NSString *)viewForRow:(NSInteger)row;
@end
