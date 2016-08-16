//
//  TRNetManager.m
//  GameLive
//
//  Created by tarena on 16/8/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRNetManager.h"

@implementation TRNetManager

+ (id)getIntroCompletionHandler:(void (^)(TRIntroModel *, NSError *))completionHandler{
    return [self GET:kIntroPath parameters:nil completionHandler:^(id responseObj, NSError *error) {
        !completionHandler ?: completionHandler([TRIntroModel parse:responseObj], nil);
    }];
}

+ (id)getRoomList:(NSString *)slug page:(NSInteger)page completionHandler:(void (^)(TRRoomListModel *, NSError *))completionHandler{
    NSString *path = [NSString stringWithFormat:kRoomListPath, slug, page == 0 ? @"" : [NSString stringWithFormat:@"_%ld", page]];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        !completionHandler ?: completionHandler([TRRoomListModel parse:responseObj], error);
    }];
}

+ (id)getCategoryCompletionHandler:(void (^)(NSArray<TRCategoryModel *> *, NSError *))completionHandler{
    return [self GET:kCategoriesPath parameters:nil completionHandler:^(id responseObj, NSError *error) {
        !completionHandler ?: completionHandler([TRCategoryModel parse:responseObj], error);
    }];
}

+ (id)getLiveListWithPage:(NSInteger)page completionHandler:(void (^)(TRLiveModel *, NSError *))completionHandler{
    NSString *path = [NSString stringWithFormat:kLiveRoomListPath, page == 0 ? @"" : [NSString stringWithFormat:@"_%ld", page]];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        !completionHandler ?: completionHandler([TRLiveModel parse:responseObj], error);
    }];
}
@end
