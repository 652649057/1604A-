//
//  TRLiveViewModel.h
//  GameLive
//
//  Created by tarena on 16/8/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "TRNetManager.h"
@interface TRLiveViewModel : BaseViewModel
@property (nonatomic, readonly) NSInteger rowNumber;
@property (nonatomic) NSMutableArray<TRLiveLinkObjectModel *> *dataList;
@property (nonatomic) NSInteger page;

- (NSURL *)iconURLForRow:(NSInteger)row;
- (NSString *)nickForRow:(NSInteger)row;
- (NSString *)titleForRow:(NSInteger)row;
- (NSString *)uidForRow:(NSInteger)row;
- (NSString *)viewForRow:(NSInteger)row;

@end






