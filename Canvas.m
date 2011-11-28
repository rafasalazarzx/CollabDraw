//
//  Canvas.m
//  CollabDrawV2
//
//  Created by Rafael Castro Salazar on 23/11/11.
//  Copyright (c) 2011 ITESM CCM. All rights reserved.
//

#import "Canvas.h"
#import "Tool.h"
#import <QuartzCore/QuartzCore.h>

@implementation Canvas

@synthesize objetos;
@synthesize tempTool;
@synthesize excentricity;
@synthesize strokeWidth;
@synthesize strokeAlpha;
@synthesize fillAlpha;
@synthesize strokeColor;
@synthesize fillColor;
@synthesize selectedTool;
@synthesize font;
@synthesize text;
@synthesize lineStyle;
@synthesize historyIndex;
@synthesize undoAvailable;

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if ( self.objetos == NULL )
    {
        self.objetos = [NSMutableArray new];
        self.excentricity = 0;
        self.strokeWidth = 1;
        self.strokeAlpha = 1;
        self.fillAlpha = 0.5;
        self.strokeColor = [UIColor blackColor];
        self.fillColor = [UIColor blackColor];
        self.selectedTool = 0;
        self.font = @"Helvetica";
        self.text = @"Lorem Ipsum";
        self.historyIndex = -1;
        self.undoAvailable = NO;
    }
    
    if(historyIndex <0)
        for (Tool *tmp in self.objetos) [tmp draw];
    else
        for (int i=0; i<=historyIndex; i++)
            [[objetos objectAtIndex:i] draw];
    
    if ( tempTool != NULL )
        [tempTool draw];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    switch( selectedTool )
    {
        case 1: // Curve
            tempTool = [[Curve alloc] initWithX:touchLocation.x andY:touchLocation.y andWidth:1 andHeight:1];
            break;
        case 2: // Ellipse
            tempTool = [[Ellipse alloc] initWithX:touchLocation.x andY:touchLocation.y andWidth:1 andHeight:1];
            break;
        case 3: // Rectangle
            tempTool = [[Rectangle alloc] initWithX:touchLocation.x andY:touchLocation.y andWidth:1 andHeight:1];
            break;
        case 4: // Text
            tempTool = [[Text alloc] initWithX:touchLocation.x andY:touchLocation.y andText:self.text andFont:self.font];
            break;
        default: // Freehand
            tempTool = [[FreeHand alloc] initWithX:touchLocation.x andY:touchLocation.y];
            break;
    }
    tempTool.strokeAlpha = self.strokeAlpha;
    tempTool.fillAlpha = self.fillAlpha;
    tempTool.strokeWidth = self.strokeWidth;
    tempTool.excentricity = self.excentricity;
    tempTool.strokeColor = self.strokeColor;
    tempTool.fillColor = self.fillColor;
    tempTool.lineStyle = self.lineStyle;
    historyIndex = -1;
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    if( selectedTool == 0 ) // Freehand
    {
        NSMutableArray *points = [(FreeHand*)tempTool puntos];
        if(!excentricity)
            [points addObject:[NSValue valueWithCGPoint:touchLocation]];
        else
        {
            
            CGPoint lastPoint = [[((FreeHand*)tempTool).puntos lastObject] CGPointValue];
            if( sqrt( pow(touchLocation.x-lastPoint.x, 2) + pow(touchLocation.y-lastPoint.y, 2) ) > excentricity*100 )
               [points addObject:[NSValue valueWithCGPoint:touchLocation]];
        }
    }
    else if( selectedTool == 4 ) // Text
    {
        tempTool.x = touchLocation.x;
        tempTool.y = touchLocation.y;
    }
    else
    {
        tempTool.width = touchLocation.x - tempTool.x;
        tempTool.height = touchLocation.y - tempTool.y;
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.objetos addObject:tempTool];
    tempTool = NULL;
    undoAvailable = YES;
    [self setNeedsDisplay];
}

- (void)undo
{
    if(undoAvailable)
    {
        [objetos removeLastObject];
        undoAvailable = NO;
        [self setNeedsDisplay];
    }
}

- (void)reset
{
    [objetos removeAllObjects];
    tempTool = NULL;
    undoAvailable = NO;
    historyIndex = -1;
    [self setNeedsDisplay];
}

- (UIImage *) takeScreenshot
{
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



@end
