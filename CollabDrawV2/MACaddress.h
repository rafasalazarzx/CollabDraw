//
//  MACaddress.h
//  CollabDrawV2
//
//  Created by Rafael Castro Salazar on 27/11/11.
//  Copyright (c) 2011 ITESM CCM. All rights reserved.
//
//  Fuente: http://www.makebetterthings.com/
//

#import <Foundation/Foundation.h>
#include <stdio.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@interface MACaddress : NSObject

+ (NSString *)getMacAddress;

@end
