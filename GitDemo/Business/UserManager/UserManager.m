//
//  UserManager.m
//  GitDemo
//
//  Created by LiuXueSong on 17/6/4.
//  Copyright © 2017年 刘雪松. All rights reserved.
//

#import "UserManager.h"

static UserManager *_userManager = nil;

@interface UserManager ()
{
    UserInfo *_userInfo;
}

@end

@implementation UserManager

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _userManager = [[self alloc] init];
    });
    
    return _userManager;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        // create...
    }
    return self;
}

- (UserInfo *)getUserInfo {
    
    return  _userInfo;
}
@end
