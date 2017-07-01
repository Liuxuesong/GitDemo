//
//  AppManager.m
//  GitDemo
//
//  Created by LiuXueSong on 17/6/4.
//  Copyright © 2017年 刘雪松. All rights reserved.
//

#import "AppManager.h"

static AppManager *_appManager;
@implementation AppManager

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _appManager = [[self alloc] init];
    });
    return _appManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end
