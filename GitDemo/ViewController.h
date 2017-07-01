//
//  ViewController.h
//  GitDemo
//
//  Created by LiuXueSong on 17/5/22.
//  Copyright © 2017年 刘雪松. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef double(^sum)(NSString *,...);
@interface ViewController : UIViewController

@property (nonatomic, copy) sum sumBlock;
@end

