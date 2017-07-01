//
//  ViewController.m
//  GitDemo
//
//  Created by LiuXueSong on 17/5/22.
//  Copyright © 2017年 刘雪松. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _sumBlock = ^(NSString *args,...) {
        
        double sum = [args doubleValue];;
        int count = 0;
        va_list list;
        va_start(list, args);
        NSString *arg;
        
        while ((arg = va_arg(list, NSString *))) {

            if (!arg) {
                break;
            }
            sum += [arg doubleValue];
            count++;
        }
        
        NSLog(@"count == %d",count);
        va_end(list);
        return sum;
    };
    
    NSLog(@"sunBlock ==== %lf",_sumBlock(@"1",@"2",@"3",@"4",@"5",nil));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
