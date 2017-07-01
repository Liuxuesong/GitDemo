//
//  NetworkAPIRecorder.m
//  GitDemo
//
//  Created by LiuXueSong on 17/6/5.
//  Copyright © 2017年 刘雪松. All rights reserved.
//

#import "NetworkAPIRecorder.h"

@implementation NetworkAPIRecorder

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _currentPage = 0;
        _pageSize = 20;
    }
    return self;
}

- (void)reset {
    
    _currentPage = 0;
}

- (BOOL)hasMoreData {
    
    if (_currentPage+1 * _pageSize < _itemsCount) {
        
        return YES;
    }
    
    return NO;
}

- (NSInteger)maxPage {
    
    return _itemsCount % _pageSize > 0? _itemsCount / _pageSize+1:_itemsCount / _pageSize;
}
@end
