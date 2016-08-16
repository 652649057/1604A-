//
//  TRIntroViewModel.m
//  GameLive
//
//  Created by tarena on 16/8/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRIntroViewModel.h"

@implementation TRIntroViewModel

- (void)getDataWithMode:(RequestMode)requestMode completionHandler:(void (^)(NSError *))completionHandler{
    self.dataTask = [TRNetManager getIntroCompletionHandler:^(TRIntroModel *model, NSError *error) {
        if (!error) {
            _indexList = model.mobileIndex;
            _starList = model.mobileStar;
            _recommendList = model.mobileRecommendation;
            NSMutableArray *tmpArr = [NSMutableArray new];
            [model.list enumerateObjectsUsingBlock:^(TRIntroListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //重点方法: 查看transformSlug:方法体
                //从list中获取返回值
                NSString *slug = [self transformSlug:obj.slug];
                if (idx > 2) { //推荐列表之后的
                    //通过KVC取值
                    id ar = [model valueForKey:slug];
                    if (ar) {
                        [tmpArr addObject:ar];
                    }
                }
            }];
            _others = tmpArr.copy;
        }
        !completionHandler ?: completionHandler(error);
    }];
}
//mobile-dnf -> mobileDnf
- (NSString *)transformSlug:(NSString *)slug{
    //把mobile-dnf 通过-分割为数组 @[@"mobile", @"dnf"]
    NSArray *tmpArr = [slug componentsSeparatedByString:@"-"];
    //数组中的最后一个元素的头字母大写  dnf -> Dnf
    NSString *upLastStr = ((NSString *)tmpArr.lastObject).capitalizedString;
    //重新拼接  mobileDnf
    slug = [tmpArr.firstObject stringByAppendingString:upLastStr];
//    NSLog(@"slug %@", slug);
    //返回拼接出来的字符串
    return slug;
}

/*********  头部滚动广告栏  ***********/
- (NSInteger)indexNum{
    return self.indexList.count;
}
- (NSURL *)indexIconURLForRow:(NSInteger)row{
    return self.indexList[row].linkObject.thumb.yx_URL;
}
- (NSString *)indexTitleForRow:(NSInteger)row{
    return self.indexList[row].linkObject.title;
}
- (NSURL *)videoURLForRow:(NSInteger)row{
    return self.indexList[row].linkObject.uid.yx_VideoURL;
}

/*********  头部滚动主播展示栏   ***********/
- (NSInteger)starNum{
    return self.starList.count;
}

- (NSURL *)starIconURLForRow:(NSInteger)row{
    return self.starList[row].thumb.yx_URL;
}
- (NSString *)starNameForRow:(NSInteger)row{
    return self.starList[row].title;
}
- (NSURL *)starVideoURLForRow:(NSInteger)row{
    return self.starList[row].fk.yx_VideoURL;
}
/*********  精彩推荐    *************/
//换一换
- (void)changeRecommendRandomList{
    //因为_recommendRandomList被使用时, 是懒加载的方式. 所以我们只要把它设置为nil, 就可以让它在懒加载时重新初始化
    _recommendRandomList = nil;
}

- (NSArray<TRIntroMobileModel *> *)recommendRandomList{
    if (!_recommendRandomList) {
        if (_recommendList.count < 3) {
            _recommendRandomList = _recommendList;
        }else{
            NSInteger index0 = arc4random() % _recommendList.count;
            NSInteger index1 = 0;
            //如果随机获取的两个数组索引值相同, 则继续获取随机数.
            //这里用的do-while, 不管如何都先获取一次index1
            do {
                index1 = arc4random() % _recommendList.count;
            } while (index0 == index1);
            
            _recommendRandomList = @[_recommendList[index0], _recommendList[index1]];
        }
    }
    return _recommendRandomList;
}

- (NSInteger)recommendNum{
    return self.recommendRandomList.count;
    //页面最多显示两个
    //return _recommendList.count > 2 ? 2 : _recommendList.count;
}
- (NSURL *)recommendIconURLForRow:(NSInteger)row{
    return self.recommendRandomList[row].linkObject.thumb.yx_URL;
}
- (NSString *)recommendNickForRow:(NSInteger)row{
    return self.recommendRandomList[row].linkObject.nick;
}
- (NSString *)recommendTitleForRow:(NSInteger)row{
    return self.recommendRandomList[row].linkObject.title;
}
- (NSURL *)recommendVideoURLForRow:(NSInteger)row{
    return self.recommendRandomList[row].linkObject.uid.yx_VideoURL;
}
- (NSString *)recommendViewForRow:(NSInteger)row{
    NSInteger num = self.recommendRandomList[row].linkObject.view.integerValue;
    if (num >= 10000) {
        return [NSString stringWithFormat:@"%.1f万", num/10000.0];
    }else{
        return self.recommendRandomList[row].linkObject.view;
    }
}

/***********  其他普通  *************/
- (NSInteger)rowNumberAtSection:(NSInteger)section{
    return _others[section].count;
}
- (NSURL *)iconURLAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"%@", _others[indexPath.section][indexPath.row].thumb);
    return _others[indexPath.section][indexPath.row].linkObject.thumb.yx_URL;
}
- (NSString *)nickAtIndexPath:(NSIndexPath *)indexPath{
     return _others[indexPath.section][indexPath.row].linkObject.nick;
}
- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath{
     return _others[indexPath.section][indexPath.row].linkObject.title;
}
- (NSURL *)videoURLAtIndexPath:(NSIndexPath *)indexPath{
    return _others[indexPath.section][indexPath.row].linkObject.uid.yx_VideoURL;
}
- (NSString *)viewAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger num = _others[indexPath.section][indexPath.row].linkObject.view.integerValue;
    if (num >= 10000) {
        return [NSString stringWithFormat:@"%.1f万", num/10000.0];
    }else{
        return _others[indexPath.section][indexPath.row].linkObject.view;
    }
}

- (NSString *)categoryNameAtSection:(NSInteger)section{
    return _others[section].firstObject.linkObject.category_name;
}

- (NSString *)slugAtSection:(NSInteger)section{
    return _others[section].firstObject.linkObject.category_slug;
}
@end
