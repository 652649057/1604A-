//
//  TRIntroModel.h
//  GameLive
//
//  Created by tarena on 16/8/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TRIntroMobileModel, TRIntroListModel, TRIntroLinkObjectModel;
@interface TRIntroModel : NSObject

@property (nonatomic, strong) NSArray<TRIntroMobileModel *> *moblieWebgame;

@property (nonatomic, strong) NSArray<TRIntroMobileModel *> *moblieMinecraft;

@property (nonatomic, strong) NSArray<TRIntroMobileModel *> *mobileTvgame;

@property (nonatomic, strong) NSArray<TRIntroMobileModel *> *moblieSport;

@property (nonatomic, strong) NSArray<TRIntroMobileModel *> *mobileStar;

@property (nonatomic, strong) NSArray<TRIntroMobileModel *> *mobileRecommendation;

@property (nonatomic, strong) NSArray<TRIntroMobileModel *> *mobileIndex;

@property (nonatomic, strong) NSArray<TRIntroMobileModel *> *mobileLol;

@property (nonatomic, strong) NSArray<TRIntroMobileModel *> *mobileBeauty;

@property (nonatomic, strong) NSArray<TRIntroMobileModel *> *mobileHeartstone;

@property (nonatomic, strong) NSArray<TRIntroMobileModel *> *moblieBlizzard;

@property (nonatomic, strong) NSArray<TRIntroListModel *> *list;

@property (nonatomic, strong) NSArray<TRIntroMobileModel *> *mobileDota2;

@property (nonatomic, strong) NSArray<TRIntroMobileModel *> *moblieDnf;

@end

@interface TRIntroMobileModel : NSObject
//id - ID
@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, assign) NSInteger slot_id;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, assign) NSInteger priority;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *create_at;
//link_object - linkObject
@property (nonatomic, strong) TRIntroLinkObjectModel *linkObject;

@property (nonatomic, copy) NSString *ext;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *fk;

@end

@interface TRIntroLinkObjectModel : NSObject

@property (nonatomic, copy) NSString *default_image;

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, copy) NSString *weight;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *category_name;

@property (nonatomic, assign) BOOL hidden;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, copy) NSString *category_slug;

@property (nonatomic, copy) NSString *recommend_image;

@property (nonatomic, copy) NSString *play_at;

@property (nonatomic, copy) NSString *app_shuffling_image;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, copy) NSString *grade;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *announcement;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, copy) NSString *view;

@property (nonatomic, copy) NSString *create_at;

@property (nonatomic, copy) NSString *video_quality;

@property (nonatomic, copy) NSString *category_id;

@property (nonatomic, copy) NSString *follow;

@end

@interface TRIntroListModel : NSObject

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *category_slug;

@end
