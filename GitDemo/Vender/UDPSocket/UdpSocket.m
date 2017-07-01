//
//  UdpSocket.m
//  Activatewifi
//
//  Created by tianfeng on 16/4/12.
//  Copyright © 2016年 王晓睿. All rights reserved.
//

#import "UdpSocket.h"

#import "GCDAsyncUdpSocket.h"
#define UDPBTNPort  13476
@interface UdpSocket()<GCDAsyncUdpSocketDelegate>

@property (strong, nonatomic) GCDAsyncUdpSocket *gcdUdpSocket;
@property (nonatomic,copy)NSString *sendMessage;
@property (nonatomic,copy)NSString *sendIp;
@property (nonatomic,strong)NSTimer *udpTimer;
@property (nonatomic,assign) int  index;
@property (nonatomic,copy)NSString *keyStr;
@property (nonatomic,assign) int resultNum;
@property (nonatomic,assign) int deviceCode;
@property (nonatomic,assign) int deviceNum;
@end
@implementation UdpSocket

-(void)initUDPSocket
{
    //初始化udp
    self.gcdUdpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error;
    
    [ self.gcdUdpSocket bindToPort:UDPBTNPort error:&error];
    
    if (nil != error) {
        
        NSLog(@"failed.:%@",[error description]);
        
    }
    //
    [self.gcdUdpSocket enableBroadcast:YES error:&error];
    
    if (nil != error) {
        
        NSLog(@"failed.:%@",[error description]);
        
    }
    
    [self.gcdUdpSocket beginReceiving:&error];
    
    if (nil != error) {
        NSLog(@"failed.:%@",[error description]);
    }
    [self.gcdUdpSocket setIPv4Enabled:YES];
    [self.gcdUdpSocket setIPv6Enabled:NO];
    
    [self.gcdUdpSocket beginReceiving:nil];
    self.resultNum = 0;
    self.deviceCode = 0;
    self.deviceNum= 0;
}
//初始化socket通信
- (void)udpSocketSendMessageIp:(NSString *)ip message:(NSString *)str{
    self.sendMessage = str;
    self.sendIp = ip;
    self.index = 1;
    //设置时间
   
    //创建一个调度时间,相对于默认时钟或修改现有的调度时间
    double delayInSeconds = 1.0;
    dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    
    dispatch_queue_t concurrentQueue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void){
        
        dispatch_async(dispatch_get_main_queue(), ^{
               self.udpTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(sendUdpMsg) userInfo:nil repeats:YES];
        });
    });
    
}

-(void)sendUdpMsg
{
    if (self.index == 7) {
        [self.udpTimer invalidate];
        if ([_delegate respondsToSelector:@selector(didUdpSendMessage)]) {
            
            [_delegate didUdpSendMessage];
        }
    }else{
        
        NSData *data = [self.sendMessage dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"%@",self.sendMessage);
        
        [self sendMsgwithIp:self.sendIp withData:data];

        self.index ++;
        NSLog(@"第%d次发送udp ---- %@----%@",self.index,data,self.sendMessage);
    }
}


-(void)closeUdp
{
    if (self.gcdUdpSocket) {
        
        [self.gcdUdpSocket close];
    }
}
- (void)dealloc
{
    if (self.gcdUdpSocket) {
        
        [self.gcdUdpSocket close];
    }
}
//UDP发送消息
- (void) sendMsgwithIp:(NSString *)host withData:(NSData *)data{
    
    uint16_t port = UDPBTNPort;
    //开始发送
    //改函数只是启动一次发送 它本身不进行数据的发送, 而是让后台的线程慢慢的发送 也就是说这个函数调用完成后,数据并没有立刻发送,异步发送
    [self.gcdUdpSocket sendData:data toHost:host port:port withTimeout:60 tag:100];

}

-(void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    if ([_delegate respondsToSelector:@selector(didUdpSendMessage)]) {
        
        [_delegate didUdpSendMessage];
    }
    NSLog(@"%s",__func__);
}

-(void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext{
    

    NSString *ip = [GCDAsyncUdpSocket hostFromAddress:address];
    uint16_t port = [GCDAsyncUdpSocket portFromAddress:address];
    
    NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSString *ss = [NSString stringWithFormat:@"{\"action\":\"deviceCode\",\"data\":{\"deviceCode\":\"5ccf7f866266\",\"IP\":\"192.168.0.103\",\"Port\":\"12476\"}}"];
    
    NSError *error =nil;
    id json = [NSJSONSerialization JSONObjectWithData:[s dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    
    NSLog(@"error = %@",error);
    
    
    NSDictionary *dic = (NSDictionary *)json;
    
    NSLog(@"这里--udp-dic%@--------%@",s,dic);
    
    NSString *keyValue = [dic objectForKey:@"action"];
    if ([keyValue isEqualToString:@"deviceCode"]) {
        if(self.deviceCode ==0)
        {
            [_delegate didFromUdpReceiveDictionary:dic withTag:0 fromHost:ip port:port];
            self.deviceCode ++;
        }else
        {
            
        }
    }
    else if ([keyValue isEqualToString:@"receivedIdentify"])
    {
        if (self.resultNum ==0) {
            [_delegate didFromUdpReceiveDictionary:dic withTag:0 fromHost:ip port:port];
            self.resultNum ++;
        }
    }
//    }else
//    {
//        NSDictionary *resultValue = [dic objectForKey:@"result"];
//        NSString *appcode = [resultValue objectForKey:@"appcode"];
//        if ([keyValue isEqualToString:@"deviceinfo"]) {
//            if(self.deviceNum ==0)
//            {
//                [_delegate didFromUdpReceiveDictionary:dic withTag:0 fromHost:ip port:port];
//                self.deviceNum ++;
//            }else
//            {
//                
//            }
//            
//        }
//        
//        if ([appcode isEqualToString:self.identifierForVendor]) {
//            
//            if ([keyValue isEqualToString:@"serverstatus"]) {
//                if(self.connectedNum ==0)
//                {
//                    [_delegate didFromUdpReceiveDictionary:dic withTag:0 fromHost:ip port:port];
//                    self.connectedNum ++;
//                }else
//                {
//                    
//                }
//                
//            }
//
//            else if ([keyValue isEqualToString:@"configresult"]) {
//                if(self.resultNum ==0)
//                {
//                    [_delegate didFromUdpReceiveDictionary:dic withTag:0 fromHost:ip port:port];
//                    self.resultNum ++;
//                }else
//                {
//                    
//                }
//                
//            }
//            
//        }
  

}

@end
