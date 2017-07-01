//
//  VenderMacros.h
//  GitDemo
//
//  Created by LiuXueSong on 17/6/4.
//  Copyright © 2017年 刘雪松. All rights reserved.
//

#ifndef VenderMacros_h
#define VenderMacros_h

/*
 * 定义一些第三方库需要的宏定义和常量
 */

// 设置加载提示框（第三方框架：MBProgressHUD）
// 加载
#define kShowNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
// 收起加载
#define kHideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
// 设置加载
#define NetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x

#define kWindow [UIApplication sharedApplication].keyWindow

#define kBackView         for (UIView *item in kWindow.subviews) { \
if(item.tag == 10000) \
{ \
[item removeFromSuperview]; \
UIView * aView = [[UIView alloc] init]; \
aView.frame = [UIScreen mainScreen].bounds; \
aView.tag = 10000; \
aView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3]; \
[kWindow addSubview:aView]; \
} \
} \

// 显示菊花和暗色遮罩
#define kShowHUDAndActivity kBackView;[MBProgressHUD showHUDAddedTo:kWindow animated:YES];kShowNetworkActivityIndicator()


#define kHiddenHUD [MBProgressHUD hideAllHUDsForView:kWindow animated:YES]

#define kRemoveBackView         for (UIView *item in kWindow.subviews) { \
if(item.tag == 10000) \
{ \
[UIView animateWithDuration:0.4 animations:^{ \
item.alpha = 0.0; \
} completion:^(BOOL finished) { \
[item removeFromSuperview]; \
}]; \
} \
} \
// 隐藏菊花和暗色遮罩
#define kHiddenHUDAndAvtivity kRemoveBackView;kHiddenHUD;HideNetworkActivityIndicator()


static NSString * const wxAppId = @"wx23hiwdhfw3hr";
static NSString * const wxAppSecret = @"fb23f2749cb1fcce4faf4f16d940aec3";
// ...
#endif /* VenderMacros_h */
