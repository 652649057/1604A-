//
//  TRTopViewModel.h
//  GameLive
//
//  Created by tarena on 16/8/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "TRNetManager.h"

@interface TRTopViewModel : BaseViewModel
@property (nonatomic, readonly) NSInteger rowNumber;
@property (nonatomic) NSArray<TRCategoryModel *> *dataList;

- (NSURL *)iconURLForRow:(NSInteger)row;
- (NSString *)titleForRow:(NSInteger)row;
- (NSString *)slugForRow:(NSInteger)row;
@end





