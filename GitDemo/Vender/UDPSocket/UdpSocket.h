//
//  UdpSocket.h
//  Activatewifi
//
//  Created by tianfeng on 16/4/12.
//  Copyright © 2016年 王晓睿. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UdpSocket;
@protocol UdpSocketDelegat <NSObject>
@optional
-(void)didUdpSendMessage;
-(void)didFromUdpReceiveDictionary:(NSDictionary *)dicInfo withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port;

@end



@interface UdpSocket : NSObject<UdpSocketDelegat>

- (void)initUDPSocket;
- (void)udpSocketSendMessageIp:(NSString *)ip message:(NSString *)str;

- (void)broadcastEntry:(NSString *)host;

- (void) sendMsgwithIp:(NSString *)host withData:(NSData *)data;

-(void)closeUdp;

@property (nonatomic, assign) id<UdpSocketDelegat> delegate;
@end
