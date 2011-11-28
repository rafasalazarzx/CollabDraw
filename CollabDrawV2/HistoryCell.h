//
//  HistoryCell.h
//  CollabDrawV2
//
//  Created by Rafael Castro Salazar on 28/11/11.
//  Copyright (c) 2011 ITESM CCM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Canvas.h"

@interface HistoryCell : UITableViewCell
{
    IBOutlet UILabel *toolName;
    IBOutlet UILabel *toolInfo;
    Canvas *theCanvas;
    NSInteger theIndex;
    UIPopoverController* popoverController;
    UITableViewController* modalController;
}

@property (nonatomic, retain) UILabel *toolName;
@property (nonatomic, retain) UILabel *toolInfo;
@property (nonatomic, retain) Canvas *theCanvas;
@property (nonatomic, retain) UIPopoverController* popoverController;
@property (nonatomic, retain) UITableViewController* modalController;
@property NSInteger theIndex;

-(IBAction)setAsCurrent:(id)sender;

@end
