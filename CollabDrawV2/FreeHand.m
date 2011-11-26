//
//  FreeHand.m
//  CollabDrawV2
//
//  Created by Rafael Castro Salazar on 23/11/11.
//  Copyright (c) 2011 ITESM CCM. All rights reserved.
//

#import "Tool.h"

@implementation FreeHand

@synthesize puntos;

- (void) drawWithContext:(CGContextRef)context
{
    CGContextMoveToPoint(context, x, y);
    for( NSValue* tmp in self.puntos )
    {
        CGPoint ctmp = [tmp CGPointValue];
        CGContextAddLineToPoint(context, ctmp.x, ctmp.y);
    }
    CGContextStrokePath(context);
}

-(FreeHand*) initWithX: (int)_x andY: (int)_y
{
    self = [super initWithX:_x andY:_y];
    if( self )
        puntos = [[NSMutableArray alloc] init];
    return self;
}

@end
