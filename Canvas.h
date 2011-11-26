//
//  Canvas.h
//  CollabDrawV2
//
//  Created by Rafael Castro Salazar on 23/11/11.
//  Copyright (c) 2011 ITESM CCM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tool.h"

@interface Canvas : UIView
{
    NSMutableDictionary *objetos;
    Tool *tempTool;
    NSInteger selectedTool; //0: FreeHand, 1: Curve, 2: Ellipse, 3: Rectangle, 4: Text
    // Tool Options
    CGFloat excentricity;
    NSInteger x, y;
    NSInteger width;
    NSInteger height;
    CGFloat strokeWidth;
    CGFloat strokeAlpha;
    CGFloat fillAlpha;
    UIColor *strokeColor;
    UIColor *fillColor;
    NSString *font;
    NSString *text;
    NSDate *lastAdded;
}

@property (retain) NSMutableDictionary *objetos;
@property (retain) Tool *tempTool;
@property CGFloat excentricity;
@property CGFloat strokeWidth;
@property CGFloat strokeAlpha;
@property CGFloat fillAlpha;
@property (retain) UIColor *strokeColor;
@property (retain) UIColor *fillColor;
@property NSInteger selectedTool;
@property (retain) NSString *font;
@property (retain) NSString *text;
@property (retain) NSDate *lastAdded;

- (void) undo;
- (void) reset;
- (UIImage*) takeScreenshot;
@end
