//
//  MomentsManager.h
//  GitDemo
//
//  Created by LiuXueSong on 17/6/5.
//  Copyright © 2017年 刘雪松. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkAPIRecorder.h"

/*
 * 朋友圈模块接口
 */
@interface MomentsManager : NSObject

@property (nonatomic, strong) NetworkAPIRecorder *networkAPIRecorder;

- (void)refreshMomentListWithSuccess:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure;//第一页
- (void)loadmoreMomentListWithSuccess:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure;//当前页的下一页
- (void)fetchMomentListWithPage:(NSInteger)page success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure;//指定页(一般外部用不到, 看情况暴露)

- (void)fetchMomentContentWithMomentId:(NSString *)momentId success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure;
@end
