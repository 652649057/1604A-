//
//  TRRoomListViewModel.m
//  GameLive
//
//  Created by tarena on 16/8/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRRoomListViewModel.h"

@implementation TRRoomListViewModel
- (instancetype)initWithSlug:(NSString *)slug{
    if (self = [super init]) {
        _slug = slug;
    }
    return self;
}
- (instancetype)init{
    NSAssert1(NO, @"%s : 必须使用initWithSlug:方法初始化", __FUNCTION__);
    return nil;
}


- (void)getDataWithMode:(RequestMode)requestMode completionHandler:(void (^)(NSError *))completionHandler{
    NSInteger tmpPage = 0;
    if (requestMode == RequestModeMore) {
        tmpPage = _page + 1;
    }
    self.dataTask = [TRNetManager getRoomList:_slug page:tmpPage completionHandler:^(TRRoomListModel *model, NSError *error) {
        if (!error) {
            if (requestMode == RequestModeRefresh) {
                [self.dataList removeAllObjects];
            }
            [self.dataList addObjectsFromArray:model.data];
            _page = tmpPage;
        }
        !completionHandler?:completionHandler(error);
    }];
}

- (NSInteger)rowNumber{
    return self.dataList.count;
}
- (NSURL *)iconURLForRow:(NSInteger)row{
    return self.dataList[row].thumb.yx_URL;
}
- (NSString *)nickForRow:(NSInteger)row{
    return self.dataList[row].nick;
}
- (NSString *)titleForRow:(NSInteger)row{
    return self.dataList[row].title;
}
- (NSString *)uidForRow:(NSInteger)row{
    return self.dataList[row].uid;
}
- (NSString *)viewForRow:(NSInteger)row{
    NSInteger num = self.dataList[row].view.integerValue;
    if (num >= 10000) {
        return [NSString stringWithFormat:@"%.1f万", num/10000.0];
    }else{
        return self.dataList[row].view;
    }
}

- (NSMutableArray<TRRoomListDataModel *> *)dataList{
    if(!_dataList){
        _dataList = [NSMutableArray new];
    }
    return _dataList;
}
@end
