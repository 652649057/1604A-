//
//  TRIntroModel.m
//  GameLive
//
//  Created by tarena on 16/8/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRIntroModel.h"

@implementation TRIntroModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"moblieWebgame": [TRIntroMobileModel class],
             @"moblieMinecraft": [TRIntroMobileModel class],
             @"mobileTvgame": [TRIntroMobileModel class],
             @"moblieSport": [TRIntroMobileModel class],
             @"mobileStar": [TRIntroMobileModel class],
             @"mobileRecommendation": [TRIntroMobileModel class],
             @"mobileIndex": [TRIntroMobileModel class],
             @"mobileBeauty": [TRIntroMobileModel class],
             @"mobileHeartstone": [TRIntroMobileModel class],
             @"moblieBlizzard": [TRIntroMobileModel class],
             @"mobileDota2": [TRIntroMobileModel class],
             @"moblieDnf": [TRIntroMobileModel class],
             @"list": [TRIntroListModel class],
             @"mobileLol": [TRIntroMobileModel class]};
}
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    //注意moblie 和 mobile  服务器人员拼写错误的情况
    return @{@"moblieWebgame": @"moblie-webgame",
             @"moblieMinecraft": @"moblie-minecraft",
             @"mobileTvgame": @"mobile-tvgame",
             @"moblieSport": @"moblie-sport",
             @"mobileStar": @"mobile-star",
             @"mobileRecommendation": @"mobile-recommendation",
             @"mobileIndex": @"mobile-index",
             @"mobileBeauty": @"mobile-beauty",
             @"mobileHeartstone": @"mobile-heartstone",
             @"moblieBlizzard": @"moblie-blizzard",
             @"mobileDota2": @"mobile-dota2",
             @"moblieDnf": @"moblie-dnf",
             @"mobileLol": @"mobile-lol"};
}
@end

@implementation TRIntroMobileModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID": @"id", @"linkObject": @"link_object"};
}
@end


@implementation TRIntroLinkObjectModel

@end


@implementation TRIntroListModel

@end



