//
//  DefineRequest.h
//  GitDemo
//
//  Created by LiuXueSong on 17/5/22.
//  Copyright © 2017年 刘雪松. All rights reserved.
//

/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */
#ifndef DefineRequest_h
#define DefineRequest_h

#define DevelopSever 0
#define TestSever    1
#define ProductSever 0


#if DevelopSever
/** 接口前缀-开发服务器*/
static NSString *const kApiPrefix = @"接口服务器的请求前缀 例: http://192.168.10.10:8080";
#elif TestSever
/** 接口前缀-测试服务器*/
static NSString *const kApiPrefix = @"https://www.baidu.com";

#elif ProductSever
/** 接口前缀-生产服务器*/
static NSString *const kApiPrefix = @"https://www.baidu.com";
#endif


#pragma mark - 详细接口地址
/** 登录*/
static NSString *const kLogin = @"/login";
/** 平台会员退出*/
static NSString *const kExit = @"/exit";






#endif /* DefineRequest_h */
