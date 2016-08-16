//
//  TRRoomListModel.m
//  GameLive
//
//  Created by tarena on 16/8/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRRoomListModel.h"

@implementation TRRoomListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data": [TRRoomListDataModel class]};
}
@end
@implementation TRRoomListDataModel

@end


