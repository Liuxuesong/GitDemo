//
//  NetworkAPIRecorder.h
//  GitDemo
//
//  Created by LiuXueSong on 17/6/5.
//  Copyright © 2017年 刘雪松. All rights reserved.
//

#import <Foundation/Foundation.h>



/*
 * 用于分页获取数据
 */


@interface NetworkAPIRecorder : NSObject
@property (strong, nonatomic) id rawValue;
@property (assign, nonatomic) int pageSize;
@property (assign, nonatomic) int currentPage;
@property (assign, nonatomic) NSInteger itemsCount;
@property (assign, nonatomic) NSInteger lastRequestTime;

- (void)reset;
- (BOOL)hasMoreData;
- (NSInteger)maxPage;
@end
