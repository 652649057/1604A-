//
//  TRLiveModel.m
//  GameLive
//
//  Created by tarena on 16/8/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRLiveModel.h"

@implementation TRLiveModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data": [TRLiveLinkObjectModel class]};
}
@end
@implementation TRLiveRecommendModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data": [TRLiveDataModel class]};
}
@end


@implementation TRLiveDataModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID": @"id"};
}
@end


@implementation TRLiveLinkObjectModel

@end
