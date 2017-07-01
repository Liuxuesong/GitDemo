//
//  TCPSocket.h
//  JJM
//
//  Created by tianfeng on 16/7/13.
//  Copyright © 2016年 Allan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TCPSocket;
@protocol TCPSocketDelegat <NSObject>
-(void)didconnectTCPSocket:(NSString *)host port:(UInt16)port;
-(void)didReadDataDic:(NSDictionary *)dic;
@end
@interface TCPSocket : NSObject<TCPSocketDelegat>
//-(void)startTCPSocketIP:(NSString *)ip port:(uint16_t)port;

-(void)initTCPSocket;
-(void)connectTCPSocket:(NSString *)host port:(uint16_t)port;
-(void)TCPSocketSendMessage:(NSString *)string;
-(void)closeTcpSocket;
@property (nonatomic, assign) id<TCPSocketDelegat> delegate;
@end
