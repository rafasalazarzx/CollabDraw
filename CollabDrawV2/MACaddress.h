//
//  MACaddress.h
//  CollabDrawV2
//
//  Created by Rafael Castro Salazar on 27/11/11.
//  Copyright (c) 2011 ITESM CCM. All rights reserved.
//
//  Fuentes: http://www.makebetterthings.com/ http://iphonedevelopertips.com/core-services/getting-the-iphone-user-name.html
//

#import <Foundation/Foundation.h>
#include <stdio.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@interface MACaddress : NSObject

+ (NSString *)getMacAddress;
+ (NSString *)getUserName;

@end
