//
//  CDViewController.h
//  CollabDrawV2
//
//  Created by Rafael Castro Salazar on 23/11/11.
//  Copyright (c) 2011 ITESM CCM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import "Canvas.h"

@interface CDViewController : UIViewController <UIPopoverControllerDelegate, UIAccelerometerDelegate, UIAlertViewDelegate>
{
    IBOutlet Canvas *theCanvas;
    IBOutlet UISlider *strokeAlphaSlider;
    IBOutlet UISlider *strokeWidthSlider;
    IBOutlet UISlider *fillAlphaSlider;
    IBOutlet UISlider *excentricitySlider;
    IBOutlet UIButton *strokeColorButton;
    IBOutlet UIButton *fillColorButton;
    IBOutlet UIScrollView *menuScrollView;
    IBOutlet UISegmentedControl *toolButtons;
    IBOutlet UISegmentedControl *fontButtons;
    IBOutlet UISegmentedControl *lineStyleButtons;
    IBOutlet UILabel *excentricidadTextoLabel;
    IBOutlet UILabel *fuenteLabel;
    IBOutlet UITextField *texto;
    IBOutlet UISegmentedControl *pseudoTabBar;
    BOOL shaking;
    UIAcceleration *acceleration;
}

@property (retain) Canvas *theCanvas;
@property (retain) UISlider *strokeAlphaSlider;
@property (retain) UISlider *strokeWidthSlider;
@property (retain) UISlider *fillAlphaSlider;
@property (retain) UISlider *excentricitySlider;
@property (retain) UIButton *strokeColorButton;
@property (retain) UIButton *fillColorButton;
@property (retain) UIScrollView *menuScrollView;
@property (retain) UISegmentedControl *toolButtons;
@property (retain) UISegmentedControl *fontButtons;
@property (retain) UILabel *excentricidadTextoLabel;
@property (retain) UILabel *fuenteLabel;
@property (retain) UITextField *texto;
@property (retain) UISegmentedControl *pseudoTabBar;
@property (retain) UISegmentedControl *lineStyleButtons;
@property (retain) UIAcceleration *acceleration;

- (IBAction)strokeAlphaChange:(id)sender;
- (IBAction)strokeWidthChange:(id)sender;
- (IBAction)fillAlphaChange:(id)sender;
- (IBAction)excentricityChange:(id)sender;
- (IBAction)strokeColorChange:(id)sender;
- (IBAction)fillColorChange:(id)sender;
- (IBAction)toolChange:(id)sender;
- (IBAction)fontChange:(id)sender;
- (IBAction)lineStyleChange:(id)sender;
- (IBAction)textChange:(id)sender;
- (IBAction)pseudoTabChange:(id)sender;
- (IBAction)clearCanvas:(id)sender;
- (IBAction)saveCanvas:(id)sender;
- (IBAction)tweetCanvas:(id)sender;
- (IBAction)hostNewSession:(id)sender;
- (IBAction)joinSession:(id)sender;
- (IBAction)historyPopover:(id)sender;

- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration;
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

static BOOL L0AccelerationIsShaking(UIAcceleration* last, UIAcceleration* current, double threshold)
{
    double dx, dy, dz;
    dx = fabs(last.x - current.x),
    dy = fabs(last.y - current.y),
    dz = fabs(last.z - current.z);
    
    return (dx > threshold && dy > threshold) ||
    (dx > threshold && dz > threshold) ||
    (dy > threshold && dz > threshold);
}