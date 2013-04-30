//
//  FirstViewController.h
//  Motion Analysis
//
//  Created by Ou Tian on 4/23/13.
//  Copyright (c) 2013 Ou Tian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import "AppDelegate.h"
#import "StepCount.h"

@class StepCount;

@interface FirstViewController : UIViewController<UIAccelerometerDelegate>
{
    AppDelegate *appDelegate;
}

@property (nonatomic, assign) Boolean running;
@property (nonatomic, assign) NSInteger stepCount, walkSteps, runSteps;
@property (nonatomic, assign) NSInteger motionState;
@property (nonatomic, retain) CMMotionManager *motionManager;
@property (nonatomic, retain) StepCount *stepData;
//@property (nonatomic, retain) NSDate *startTime;
//@property (nonatomic, assign) NSInteger startTimer;
@property (nonatomic, assign) NSInteger timer, walkTimer, runTimer;

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *resetButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepsLabel;
@property (weak, nonatomic) IBOutlet UILabel *state0Label;
@property (weak, nonatomic) IBOutlet UILabel *state1Label;
@property (weak, nonatomic) IBOutlet UILabel *state2Label;
@property (weak, nonatomic) IBOutlet UILabel *state3Label;

- (IBAction)startOrPause:(id)sender;
- (IBAction)onReset:(id)sender;

@end
