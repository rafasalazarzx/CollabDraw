//
//  HistoryTable.m
//  CollabDrawV2
//
//  Created by Rafael Castro Salazar on 27/11/11.
//  Copyright (c) 2011 ITESM CCM. All rights reserved.
//

#import "HistoryTable.h"
#import "HistoryCell.h"

@implementation HistoryTable

@synthesize theCanvas;
@synthesize popoverController;

- (HistoryTable*) initWithCanvas:(Canvas*)canvas
{
    self = [super init];
    if(self)
        self.theCanvas = canvas;
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [theCanvas.objetos count]; 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Tool *tmp = [theCanvas.objetos objectAtIndex:indexPath.row];
	NSString *cellIdentifier = [tmp.creationDate description];
	//UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	//if (cell == nil) 
	//	cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdentifier] autorelease];
	//cell.text = [tmp description];
    
    HistoryCell *cell = (HistoryCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *outlets = [[NSBundle mainBundle] loadNibNamed:@"HistoryCell" owner:self options:nil];
        for (id currentObject in outlets) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell =  (HistoryCell *) currentObject;
                break;
            }
        }
    }
    cell.toolName.text = [tmp description];
    cell.toolInfo.text = [tmp creationDescription];
    cell.popoverController = popoverController;
    cell.modalController = self;
    cell.theIndex = indexPath.row;
    cell.theCanvas = theCanvas;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    theCanvas.historyIndex = indexPath.row;
    theCanvas.undoAvailable = NO;
    [theCanvas setNeedsDisplay];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        [self dismissModalViewControllerAnimated:YES];  
}

@end
