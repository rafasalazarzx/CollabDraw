//
//  ILColorPickerExampleViewController.m
//  ILColorPickerExample
//
//  Created by Jon Gilkison on 9/1/11.
//  Copyright 2011 Interfacelab LLC. All rights reserved.
//

#import "ILColorPickerDualExampleController.h"

@implementation ILColorPickerDualExampleController

@synthesize colorRed;
@synthesize colorGreen;
@synthesize colorBlue;
@synthesize closeButton;
@synthesize customButton;
@synthesize theCanvas;
@synthesize foreground;
@synthesize popoverController;

-(ILColorPickerDualExampleController*)initWithColorR:(CGFloat)red andG:(CGFloat)green andB:(CGFloat)blue
{
    self = [super init];
    if (self)
    {
        self.colorRed = red;
        self.colorGreen = green;
        self.colorBlue = blue;
    }
    return self;
}

-(ILColorPickerDualExampleController*)initWithButton:(UIButton*)button andCanvas:(Canvas*)canvas foreground:(BOOL)isForeground
{
    self = [super init];
    if(self)
    {
        self.customButton = button;
        self.theCanvas = canvas;
        self.foreground = isForeground;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Build a random color to show off setting the color on the pickers
    /*
    UIColor *c=[UIColor colorWithRed:(arc4random()%100)/100.0f 
                               green:(arc4random()%100)/100.0f
                                blue:(arc4random()%100)/100.0f
                               alpha:1.0];
    */
    //UIColor *c = [UIColor colorWithRed:colorRed green:colorGreen blue:colorBlue alpha:1.0];
    UIColor *c;
    if( customButton == nil )
        c = [UIColor colorWithRed:colorRed green:colorGreen blue:colorBlue alpha:1.0];
    else
        c = customButton.backgroundColor;
    colorChip.backgroundColor=c;
    colorPicker.color=c;
    huePicker.color=c;
}

#pragma mark - ILSaturationBrightnessPickerDelegate implementation

-(void)colorPicked:(UIColor *)newColor forPicker:(ILSaturationBrightnessPickerView *)picker
{
    colorChip.backgroundColor=newColor;
}

-(IBAction)setColorAndClose:(id)sender
{
    if ( customButton )
        customButton.backgroundColor = colorChip.backgroundColor;

    if ( theCanvas )
    {
        if( foreground )
            theCanvas.fillColor = colorChip.backgroundColor;
        else
            theCanvas.strokeColor = colorChip.backgroundColor;
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [self dismissModalViewControllerAnimated:YES];        
    }
    else
    {
        [popoverController dismissPopoverAnimated:YES];
    }
}

@end
