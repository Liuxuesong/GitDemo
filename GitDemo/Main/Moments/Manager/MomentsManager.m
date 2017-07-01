//
//  MomentsManager.m
//  GitDemo
//
//  Created by LiuXueSong on 17/6/5.
//  Copyright © 2017年 刘雪松. All rights reserved.
//

#import "MomentsManager.h"

@interface MomentsManager ()


@end

@implementation MomentsManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _networkAPIRecorder = [[NetworkAPIRecorder alloc] init];
        _networkAPIRecorder.pageSize = 20;
        _networkAPIRecorder.currentPage = 0;
    }
    return self;
}

- (void)refreshMomentListWithSuccess:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure {
    
    [_networkAPIRecorder reset];
    [self fetchMomentListWithPage:_networkAPIRecorder.currentPage success:success failure:failure];
}
- (void)loadmoreMomentListWithSuccess:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure {
    
    _networkAPIRecorder.currentPage ++;
    [self fetchMomentListWithPage:_networkAPIRecorder.currentPage success:success failure:failure];
}
- (void)fetchMomentListWithPage:(NSInteger)page success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure {
    
    // 封装网络请求
    [NetworkHelper GET:nil parameters:nil success:^(id responseObject) {
        
        // 处理数据保存起来，通知vc，vc可直接从manager中拿去数据，省去处理环节
        // 如果数据缺失 ...，在vc页判断是否还有更多数据
    } failure:^(NSError *error) {
        
        // 处理error，返回vc可直接显示的数据
        if (error) {
            
            failure([self formatError:error]);
        }
    }];
}

- (void)fetchMomentContentWithMomentId:(NSString *)momentId success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure {
    
    // 封装网络请求
    [NetworkHelper GET:nil parameters:nil success:^(id responseObject) {
        
        // 处理数据保存起来，通知vc，vc可直接从manager中拿去数据，省去处理环节
        // 如果数据缺失 ...，在vc页判断是否还有更多数据
    } failure:^(NSError *error) {
        
        // 处理error，返回vc可直接显示的数据
        if (error) {
            
            failure([self formatError:error]);
        }
    }];
}


- (NSError *)formatError:(NSError *)error {
    
    if (error != nil) {
        switch (error.code) {
            case NSURLErrorCancelled: {
                error = AppError(DefaultErrorNotice, NetworkTaskErrorCanceled);
            }   break;
                
            case NSURLErrorTimedOut: {
                error = AppError(TimeoutErrorNotice, NetworkTaskErrorTimeOut);
            }   break;
                
            case NSURLErrorCannotFindHost:
            case NSURLErrorCannotConnectToHost:
            case NSURLErrorNotConnectedToInternet: {//应产品要求, 所有连不上服务器都是用户网络的问题
                error = AppError(NetworkErrorNotice, NetworkTaskErrorCannotConnectedToInternet);
            }   break;
                
            default: {
                error = AppError(NoDataErrorNotice, NetworkTaskErrorDefault);
            }   break;
        }
    }
    return error;
}
@end
