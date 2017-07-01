//
//  UserManager.h
//  GitDemo
//
//  Created by LiuXueSong on 17/6/4.
//  Copyright © 2017年 刘雪松. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface UserManager : NSObject


+ (instancetype)sharedInstance;
- (UserInfo *)getUserInfo;

@end

