//
//  NetworkErrorMacros.h
//  GitDemo
//
//  Created by LiuXueSong on 17/6/5.
//  Copyright © 2017年 刘雪松. All rights reserved.
//



#ifndef NetworkErrorMacros_h
#define NetworkErrorMacros_h

//AppNetworkTaskError.h 通用错误

typedef NS_ENUM(NSUInteger, NetworkTaskError) {
    NetworkTaskErrorTimeOut = 101,
    NetworkTaskErrorCannotConnectedToInternet = 102,
    NetworkTaskErrorCanceled = 103,
    NetworkTaskErrorDefault = 104,
    NetworkTaskErrorNoData = 105,
    NetworkTaskErrorNoMoreData = 106
};


static NSError *AppError(NSString *domain, int code) {
    return [NSError errorWithDomain:domain code:code userInfo:nil];
}

static NSString * const NoDataErrorNotice = @"这里什么也没有~";
static NSString * const NetworkErrorNotice = @"当前网络差, 请检查网络设置~";
static NSString * const TimeoutErrorNotice = @"请求超时了~";
static NSString * const DefaultErrorNotice = @"请求失败了~";
static NSString * const NoMoreDataErrorNotice = @"没有更多了~";
#endif /* NetworkErrorMacros_h */
