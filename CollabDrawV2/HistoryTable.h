//
//  HistoryTable.h
//  CollabDrawV2
//
//  Created by Rafael Castro Salazar on 27/11/11.
//  Copyright (c) 2011 ITESM CCM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Canvas.h"

@interface HistoryTable : UITableViewController <UITableViewDelegate, UITableViewDataSource>
{
    Canvas *theCanvas;
    UIPopoverController* popoverController;
}

- (HistoryTable*) initWithCanvas:(Canvas*)canvas;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, retain) Canvas *theCanvas;
@property (nonatomic, retain) UIPopoverController *popoverController;

@end
