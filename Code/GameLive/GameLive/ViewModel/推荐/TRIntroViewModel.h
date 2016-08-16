//
//  TRIntroViewModel.h
//  GameLive
//
//  Created by tarena on 16/8/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "TRNetManager.h"

@interface TRIntroViewModel : BaseViewModel
/*********  头部滚动广告栏  ***********/
@property (nonatomic) NSArray<TRIntroMobileModel *> *indexList;
@property (nonatomic, readonly) NSInteger indexNum;
- (NSURL *)indexIconURLForRow:(NSInteger)row;
- (NSString *)indexTitleForRow:(NSInteger)row;
- (NSURL *)videoURLForRow:(NSInteger)row;


/*********  头部滚动主播展示栏   ***********/
@property (nonatomic) NSArray<TRIntroMobileModel *> *starList;
@property (nonatomic, readonly) NSInteger starNum;
- (NSURL *)starIconURLForRow:(NSInteger)row;
- (NSString *)starNameForRow:(NSInteger)row;
- (NSURL *)starVideoURLForRow:(NSInteger)row;

/*********  精彩推荐    *************/
@property (nonatomic) NSArray<TRIntroMobileModel *> *recommendList;
@property (nonatomic, readonly) NSInteger recommendNum;
- (NSURL *)recommendIconURLForRow:(NSInteger)row;
- (NSString *)recommendNickForRow:(NSInteger)row;
- (NSString *)recommendTitleForRow:(NSInteger)row;
- (NSURL *)recommendVideoURLForRow:(NSInteger)row;
- (NSString *)recommendViewForRow:(NSInteger)row;

//为换一换功能添加的代码
//随机从recommendList中获取两个
@property (nonatomic) NSArray<TRIntroMobileModel * > *recommendRandomList;
- (void)changeRecommendRandomList;


/*********  其他页面    ************/
@property (nonatomic) NSArray<NSArray<TRIntroMobileModel *> *> *others;
- (NSInteger)rowNumberAtSection:(NSInteger)section;
- (NSURL *)iconURLAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)nickAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath;
- (NSURL *)videoURLAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)viewAtIndexPath:(NSIndexPath *)indexPath;

//某分组的题目
- (NSString *)categoryNameAtSection:(NSInteger)section;

- (NSString *)slugAtSection:(NSInteger)section;

@end
















