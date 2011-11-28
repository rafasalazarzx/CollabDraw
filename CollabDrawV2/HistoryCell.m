//
//  HistoryCell.m
//  CollabDrawV2
//
//  Created by Rafael Castro Salazar on 28/11/11.
//  Copyright (c) 2011 ITESM CCM. All rights reserved.
//

#import "HistoryCell.h"

@implementation HistoryCell

@synthesize toolInfo;
@synthesize toolName;
@synthesize theCanvas;
@synthesize theIndex;
@synthesize popoverController;
@synthesize modalController;

-(IBAction)setAsCurrent:(id)sender
{
    for( int i=[theCanvas.objetos count]-1; i>theIndex; i--)
        [theCanvas.objetos removeObjectAtIndex:i];
    theCanvas.historyIndex = -1;
    theCanvas.undoAvailable = NO;
    [theCanvas setNeedsDisplay];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        [modalController dismissModalViewControllerAnimated:YES];        
    else
        [popoverController dismissPopoverAnimated:YES];
}

@end
