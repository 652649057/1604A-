//
//  TRRoomListViewController.h
//  GameLive
//
//  Created by tarena on 16/8/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRRoomListViewController : UICollectionViewController
- (instancetype)initWithSlug:(NSString *)slug;
@property (nonatomic, readonly) NSString *slug;
@end
