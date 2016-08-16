//
//  TRNetManager.h
//  GameLive
//
//  Created by tarena on 16/8/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BaseNetworking.h"
#import "TRLiveModel.h"
#import "TRCategoryModel.h"
#import "TRRoomListModel.h"
#import "TRIntroModel.h"

@interface TRNetManager : BaseNetworking
//推荐页
+ (id)getIntroCompletionHandler:(void(^)(TRIntroModel *model, NSError *error))completionHandler;

//栏目下一页
+ (id)getRoomList:(NSString *)slug page:(NSInteger)page completionHandler:(void(^)(TRRoomListModel *model, NSError *error))completionHandler;

//栏目
+ (id)getCategoryCompletionHandler:(void(^)(NSArray<TRCategoryModel *> *model, NSError *error))completionHandler;
//直播
+ (id)getLiveListWithPage:(NSInteger)page completionHandler:(void(^)(TRLiveModel *model, NSError *error))completionHandler;

@end
