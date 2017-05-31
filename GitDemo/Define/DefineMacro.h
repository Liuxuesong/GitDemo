//
//  DefineMacro.h
//  GitDemo
//
//  Created by LiuXueSong on 17/5/22.
//  Copyright © 2017年 刘雪松. All rights reserved.
//

/*
 * 定义全局宏定义
 */
#ifndef DefineMacro_h
#define DefineMacro_h

#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
//随机颜色
#define KRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

#endif /* DefineMacro_h */
