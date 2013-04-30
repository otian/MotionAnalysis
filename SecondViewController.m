//
//  SecondViewController.m
//  Motion Analysis
//
//  Created by Ou Tian on 4/23/13.
//  Copyright (c) 2013 Ou Tian. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

@synthesize totalStepsLabel, totalTimeLabel, walkStepsLabel, walkTimeLabel, runStepsLabel, runTimeLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = [[UIApplication sharedApplication] delegate];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    if (appDelegate.totalTime == NULL) {
        appDelegate.totalTime = @"00 : 00 : 00";
        appDelegate.walkTime = @"00 : 00 : 00";
        appDelegate.runTime = @"00 : 00 : 00";
    }
    [totalStepsLabel setText:[NSString stringWithFormat:@"%i", appDelegate.totalSteps]];
    [totalTimeLabel setText:appDelegate.totalTime];
    [walkStepsLabel setText:[NSString stringWithFormat:@"%i", appDelegate.walkSteps]];
    [walkTimeLabel setText:appDelegate.walkTime];
    [runStepsLabel setText:[NSString stringWithFormat:@"%i", appDelegate.runSteps]];
    [runTimeLabel setText:appDelegate.runTime];
}

- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg waitUntilDone:(BOOL)wait
{
    
}

@end
