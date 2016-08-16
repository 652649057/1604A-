//
//  TRTopViewModel.m
//  GameLive
//
//  Created by tarena on 16/8/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRTopViewModel.h"

@interface TRTopViewModel ()
@property (nonatomic) NSString *cachePath;
@end

@implementation TRTopViewModel
- (NSString *)cachePath{
    if (!_cachePath) {
        NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        _cachePath = [docPath stringByAppendingPathComponent:@"TRTopViewModel"];
    }
    return _cachePath;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        id obj = [NSKeyedUnarchiver unarchiveObjectWithFile:self.cachePath];
        if (obj) {
            self = obj;
        }
    }
    return self;
}

//只要添加了此宏, 该类就拥有了归档能力
kCodingDesc


- (void)getDataWithMode:(RequestMode)requestMode completionHandler:(void (^)(NSError *))completionHandler{
    self.dataTask = [TRNetManager getCategoryCompletionHandler:^(NSArray<TRCategoryModel *> *model, NSError *error) {
        if (!error) {
           _dataList = model;
           [NSKeyedArchiver archiveRootObject:self toFile:self.cachePath];
        }
        !completionHandler ?: completionHandler(error);
    }];
}

- (NSInteger)rowNumber{
    return self.dataList.count;
}

- (NSURL *)iconURLForRow:(NSInteger)row{
    return self.dataList[row].thumb.yx_URL;
}

- (NSString *)titleForRow:(NSInteger)row{
    return self.dataList[row].name;
}

- (NSString *)slugForRow:(NSInteger)row{
    return self.dataList[row].slug;
}


@end









