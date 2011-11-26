//
//  ILColorPickerExampleViewController.h
//  ILColorPickerExample
//
//  Created by Jon Gilkison on 9/1/11.
//  Copyright 2011 Interfacelab LLC. All rights reserved.
//
//  New functionality added in November 2011 by @castrosalazr
//

#import <UIKit/UIKit.h>
#import "ILSaturationBrightnessPickerView.h"
#import "ILHuePickerView.h"
#import "Canvas.h"

@interface ILColorPickerDualExampleController : UIViewController<ILSaturationBrightnessPickerViewDelegate> {
    IBOutlet UIView *colorChip;
    IBOutlet ILSaturationBrightnessPickerView *colorPicker;
    IBOutlet ILHuePickerView *huePicker;
    CGFloat colorRed;
    CGFloat colorGreen;
    CGFloat colorBlue;
    IBOutlet UIBarButtonItem *closeButton;
    Canvas *theCanvas;
    UIButton *customButton;
    BOOL foreground;
    UIPopoverController* popoverController;
}

@property CGFloat colorRed;
@property CGFloat colorGreen;
@property CGFloat colorBlue;
@property BOOL foreground;
@property (retain) UIBarButtonItem *closeButton;
@property (retain) Canvas *theCanvas;
@property (retain) UIButton *customButton;
@property (retain) UIPopoverController* popoverController;

-(ILColorPickerDualExampleController*)initWithColorR:(CGFloat)red andG:(CGFloat)green andB:(CGFloat)blue;
-(ILColorPickerDualExampleController*)initWithButton:(UIButton*)button andCanvas:(Canvas*)canvas foreground:(BOOL)isForeground;
-(IBAction)setColorAndClose:(id)sender;

@end
