//
//  RequestPath.h
//  GameLive
//
//  Created by tarena on 16/8/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#ifndef RequestPath_h
#define RequestPath_h

#define kBasePath       @"http://www.quanmin.tv"

//直播房间列表
#define kLiveRoomListPath       @"/json/play/list%@.json"

//栏目列表
#define kCategoriesPath         @"/json/categories/list.json"

//某栏目下的直播房间列表
#define kRoomListPath       @"/json/categories/%@/list%@.json"

//搜索功能
#define kSearchPath         @"/api/v1"

//推荐页
#define kIntroPath      @"/json/page/app-index/info.json"

#endif /* RequestPath_h */
