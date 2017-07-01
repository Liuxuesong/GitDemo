//
//  TCPSocket.m
//  JJM
//
//  Created by tianfeng on 16/7/13.
//  Copyright © 2016年 Allan. All rights reserved.
//

#import "TCPSocket.h"
#import "GCDAsyncSocket.h"

@interface TCPSocket()<GCDAsyncSocketDelegate>
@property(nonatomic,strong)GCDAsyncSocket *tcpS;
@property (nonatomic,strong)GCDAsyncSocket *clientSocket;
@end
@implementation TCPSocket



//-(void)startTCPSocketIP:(NSString *)ip port:(uint16_t)port;
//{
//    self.tcpS = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
//    NSError *err = nil;
//    if([self.tcpS acceptOnPort:port error:&err])
//    {
//        NSLog(@"accept ok.");
//    }else {
//        NSLog(@"accept failed.");
//    }
//    
//    if (err) {
//        NSLog(@"error: %@",err);
//    }
//    
//}

//- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
//{
//    self.clientSocket = newSocket;
//    NSString * dataStr =@"11111";
//    NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
//    [self.clientSocket writeData:data withTimeout:-1 tag:0];
//}

-(void)initTCPSocket
{
    self.tcpS = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
}
-(void)connectTCPSocket:(NSString *)host port:(uint16_t)port
{
    NSError *err = nil;
    BOOL rest = [self.tcpS connectToHost:host onPort:port error:&err];
    NSLog(@"Socket Host---%@  port---%d",host,port);
    if (err) {
        NSLog(@"Sockect ERROR%@",err);
    }
    if (rest) {
        NSLog(@"登陆成功");
    }else
    {
        NSLog(@"失败");
    }
}



//判断是否连接成功
- (void)socket:(GCDAsyncSocket *)sender didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"已连接到%@服务器  ---port %d",host,port);
    
    if ([_delegate respondsToSelector:@selector(didconnectTCPSocket:port:)]) {
        [_delegate didconnectTCPSocket:host port:port];
    }
    [self.tcpS readDataWithTimeout:-1 tag:0];
    
}
-(void)TCPSocketSendMessage:(NSString *)string
{
    NSString * token =[NSString stringWithFormat:@"{\"action\":\"deviceToken\",\"data\":{\"value\":\"%@\"}}",string];
    NSLog(@"   tcp send%@",token);
    NSData *data = [token dataUsingEncoding:NSUTF8StringEncoding];
    [self.tcpS writeData:data withTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket*)sock didReadData:(NSData*)data withTag:(long)tag
{
    NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSError *error =nil;
    NSLog(@"TCPdidReadData---%@",s);
    id json = [NSJSONSerialization JSONObjectWithData:[s dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    if ([_delegate respondsToSelector:@selector(didReadDataDic:)]) {
        [_delegate didReadDataDic:json];
    }
    [self.tcpS readDataWithTimeout:-1 tag:tag];
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"发发发发送了");
}
-(void)closeTcpSocket
{
    [self.tcpS disconnectAfterReadingAndWriting];
}
@end
