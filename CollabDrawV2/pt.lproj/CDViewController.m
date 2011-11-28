//
//  CDViewController.m
//  CollabDrawV2
//
//  Created by Rafael Castro Salazar on 23/11/11.
//  Copyright (c) 2011 ITESM CCM. All rights reserved.
//

#import "CDViewController.h"
#import "Tool.h"
#import "ILColorPickerDualExampleController.h"
#import "HistoryTable.h"

@implementation CDViewController

@synthesize theCanvas;
@synthesize strokeAlphaSlider;
@synthesize strokeWidthSlider;
@synthesize fillAlphaSlider;
@synthesize excentricitySlider;
@synthesize strokeColorButton;
@synthesize fillColorButton;
@synthesize menuScrollView;
@synthesize toolButtons;
@synthesize fontButtons;
@synthesize excentricidadTextoLabel;
@synthesize fuenteLabel;
@synthesize texto;
@synthesize acceleration;
@synthesize pseudoTabBar;
@synthesize lineStyleButtons;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [UIAccelerometer sharedAccelerometer].delegate = self;
    [menuScrollView setContentSize:CGSizeMake(320.0, 725.0)];
    //theCanvas = [[Canvas alloc] init];
    //[self.view addSubview:theCanvas];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    } else {
        return (interfaceOrientation == UIInterfaceOrientationLandscapeRight ||
                interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
    }
}

#pragma mark - IBActions

- (IBAction)strokeAlphaChange:(id)sender
{
    theCanvas.strokeAlpha = strokeAlphaSlider.value;
}

- (IBAction)strokeWidthChange:(id)sender
{
    theCanvas.strokeWidth = strokeWidthSlider.value;
}

- (IBAction)fillAlphaChange:(id)sender
{
    theCanvas.fillAlpha = fillAlphaSlider.value;
}

- (IBAction)excentricityChange:(id)sender
{
    theCanvas.excentricity = excentricitySlider.value;
}

- (IBAction)strokeColorChange:(id)sender
{
    ILColorPickerDualExampleController *content = [[ILColorPickerDualExampleController alloc] initWithButton:sender andCanvas:theCanvas foreground:NO]; 
    // @castrosalazr: Mostrar como Modal FullScreen en iPhone o como Popover en iPad.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [self presentModalViewController:content animated:YES];
    } else {
        content.contentSizeForViewInPopover = CGSizeMake(320, 410);
        UIPopoverController* popover = [[UIPopoverController alloc] initWithContentViewController:content];
        popover.delegate = self;
        content.popoverController = popover;
        [popover presentPopoverFromRect:strokeColorButton.frame inView:self.menuScrollView  permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

- (IBAction)fillColorChange:(id)sender
{
    ILColorPickerDualExampleController *content = [[ILColorPickerDualExampleController alloc] initWithButton:sender andCanvas:theCanvas foreground:YES]; 
    // @castrosalazr: Mostrar como Modal FullScreen en iPhone o como Popover en iPad.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [self presentModalViewController:content animated:YES];
    } else {
        content.contentSizeForViewInPopover = CGSizeMake(320, 410);
        UIPopoverController* popover = [[UIPopoverController alloc] initWithContentViewController:content];
        popover.delegate = self;
        content.popoverController = popover;
        [popover presentPopoverFromRect:strokeColorButton.frame inView:self.menuScrollView  permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

- (IBAction)toolChange:(id)sender
{
    theCanvas.selectedTool = [toolButtons selectedSegmentIndex];
    if( theCanvas.selectedTool == 4 ) // Text
    {
        excentricidadTextoLabel.text = @"Texto:";
        texto.hidden = NO;
        excentricitySlider.hidden = YES;
        fuenteLabel.hidden = NO;
        fontButtons.hidden = NO;
    }
    else
    {
        excentricidadTextoLabel.text = @"Excentricidad:";
        texto.hidden = YES;
        excentricitySlider.hidden = NO;
        fuenteLabel.hidden = YES;
        fontButtons.hidden = YES;
    }
}

- (IBAction)fontChange:(id)sender
{
    switch ([fontButtons selectedSegmentIndex]) {
        case 1:
            theCanvas.font = @"Georgia";
            break;
        case 2:
            theCanvas.font = @"Optima-Regular";
            break;
        case 3:
            theCanvas.font = @"Zapfino";
            break;
        default:
            theCanvas.font = @"Helvetica";
            break;
    }
}

- (IBAction)textChange:(id)sender
{
    theCanvas.text = [NSString stringWithString:texto.text];
}

- (IBAction)lineStyleChange:(id)sender
{
    theCanvas.lineStyle = [lineStyleButtons selectedSegmentIndex];
}

- (void) accelerometer:(UIAccelerometer *)_accelerometer didAccelerate:(UIAcceleration *)_acceleration
{   
    if (self.acceleration) {
        if (!shaking && L0AccelerationIsShaking(self.acceleration, _acceleration, 0.7)) {
            shaking = YES;
            [theCanvas undo];
        } else if (shaking && !L0AccelerationIsShaking(self.acceleration, _acceleration, 0.2))
            shaking = NO;
    }
    
    self.acceleration = _acceleration;
}

- (IBAction)pseudoTabChange:(id)sender
{
    HistoryTable *tableModal;
    switch ([pseudoTabBar selectedSegmentIndex])
    {
        case 0:
            menuScrollView.hidden = YES;
            theCanvas.hidden = NO;
            break;
        case 1:
            menuScrollView.hidden = NO;
            theCanvas.hidden = YES;
            break;
        case 2:
            if( [theCanvas.objetos count] > 0 )
            {
                tableModal = [[HistoryTable alloc] initWithCanvas:theCanvas];
                [self presentModalViewController:tableModal animated:YES];
            }
            [pseudoTabBar setSelectedSegmentIndex:0];
            menuScrollView.hidden = YES;
            theCanvas.hidden = NO;
            break;
    }
}

- (IBAction)clearCanvas:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] init];
	[alert setTitle:@"CollabDraw"];
	[alert setMessage:@"Você tem certeza de que deseja limpar a tela?"];
	[alert setDelegate:self];
	[alert addButtonWithTitle:@"Sim"];
	[alert addButtonWithTitle:@"Não"];
	[alert show];
	[alert release];
}

- (IBAction)saveCanvas:(id)sender
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [pseudoTabBar setSelectedSegmentIndex:0];
        menuScrollView.hidden = YES;
        theCanvas.hidden = NO;
    }
    [theCanvas setNeedsDisplay];
    UIImage *canvasScreenshot = [theCanvas takeScreenshot];
    UIImageWriteToSavedPhotosAlbum(canvasScreenshot, nil, nil, nil);
}

- (IBAction)tweetCanvas:(id)sender
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [pseudoTabBar setSelectedSegmentIndex:0];
        menuScrollView.hidden = YES;
        theCanvas.hidden = NO;
    }
    UIImage *canvasScreenshot = [theCanvas takeScreenshot];
    
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
    
    [twitter setInitialText:@"Meu desenho #CollabDraw" ];
    [twitter addImage:canvasScreenshot];
    
    [self presentViewController:twitter animated:YES completion:nil];
    
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult res) {
        
        if(res == TWTweetComposeViewControllerResultDone)
        {
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"CollabDraw" message:@"Sucesso! Seu desenho foi compartilhado." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertView show];
            
        }else if(res == TWTweetComposeViewControllerResultCancelled)
        {
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"CollabDraw" message:@"Erro ao enviar tweet." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertView show];
            
        }
        
        [self dismissModalViewControllerAnimated:YES];
        
    };
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( !buttonIndex )
		[theCanvas reset];
}

- (IBAction)hostNewSession:(id)sender
{
    
    
}

- (IBAction)joinSession:(id)sender
{
    
}

- (IBAction)historyPopover:(id)sender
{
    HistoryTable *table = [[HistoryTable alloc] initWithCanvas:theCanvas];
    CGFloat popoverHeight = [theCanvas.objetos count]*44 > 400 ? 400 : [theCanvas.objetos count]*44;
    table.contentSizeForViewInPopover = CGSizeMake(320, popoverHeight);
    UIPopoverController* popover = [[UIPopoverController alloc] initWithContentViewController:table];
    popover.delegate = self;
    table.popoverController = popover;
    [popover presentPopoverFromRect:[(UIButton*)sender frame] inView:self.menuScrollView  permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

@end
