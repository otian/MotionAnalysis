//
//  FirstViewController.m
//  Motion Analysis
//
//  Created by Ou Tian on 4/23/13.
//  Copyright (c) 2013 Ou Tian. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize running, motionManager, motionState, stepData;
@synthesize stepCount, walkSteps, runSteps;
@synthesize timer, walkTimer, runTimer;
@synthesize startButton, stepsLabel, timeLabel;
@synthesize state0Label, state1Label, state2Label, state3Label;

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication] delegate];
	
    [self setRunning:NO];
    [self setStepCount:0];
    [self setWalkSteps:0];
    [self setRunSteps:0];
    [self setMotionState:0];
    [self setStepData:[[StepCount alloc] init]];
    [self setMotionManager:[[CMMotionManager alloc] init]];
    
//    [self setStartTime:[[NSDate alloc] init]];
    [self setTimer:0];
    [self setWalkTimer:0];
    [self setRunTimer:0];
//    [self setStartTimer:0];
    
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0 / 60.0];
	[[UIAccelerometer sharedAccelerometer] setDelegate:self];
    motionManager = [[CMMotionManager alloc] init];
    if (motionManager.deviceMotionAvailable)
    {
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0;
        [motionManager startDeviceMotionUpdates];
    }
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    CMDeviceMotion *deviceMotion = motionManager.deviceMotion;
    CMAcceleration gravity = deviceMotion.gravity;
    
	if(running)
	{
        // Timer
        timer++;
        [timeLabel setText:[NSString stringWithFormat:@"%02i : %02i : %02i", timer/60/3600, (timer/3600)%60, (timer/60)%60]];
        
        // Counter
        NSInteger oldCount = stepCount;
        stepCount = [stepData newData:acceleration.x*gravity.x+acceleration.y*gravity.y+acceleration.z*gravity.z];
        [stepsLabel setText:[NSString stringWithFormat:@"%d", stepCount]];
        
        // State
        NSInteger state = [stepData estState];
        switch (state) {
            case 0:         // stop
                [state0Label setAlpha:0.9];
                [state1Label setAlpha:0.1];
                [state2Label setAlpha:0.1];
                [state3Label setAlpha:0.1];
                break;
            case 1:         // still
                [state0Label setAlpha:0.1];
                [state1Label setAlpha:0.9];
                [state2Label setAlpha:0.1];
                [state3Label setAlpha:0.1];
                break;
            case 2:         // walk
                walkSteps += stepCount-oldCount;
                walkTimer++;
                [state0Label setAlpha:0.1];
                [state1Label setAlpha:0.1];
                [state2Label setAlpha:0.9];
                [state3Label setAlpha:0.1];
                break;
            case 3:         // run
                runSteps += stepCount-oldCount;
                runTimer++;
                [state0Label setAlpha:0.1];
                [state1Label setAlpha:0.1];
                [state2Label setAlpha:0.1];
                [state3Label setAlpha:0.9];
                break;
            default:
                break;
        }
        
        
        // Set delegate
        [appDelegate setTotalSteps:stepCount];
        [appDelegate setTotalTime:[NSString stringWithFormat:@"%02i : %02i : %02i", timer/60/3600, (timer/3600)%60, (timer/60)%60]];
        [appDelegate setWalkSteps:walkSteps];
        [appDelegate setWalkTime:[NSString stringWithFormat:@"%02i : %02i : %02i", walkTimer/60/3600, (walkTimer/3600)%60, (walkTimer/60)%60]];
        [appDelegate setRunSteps:runSteps];
        [appDelegate setRunTime:[NSString stringWithFormat:@"%02i : %02i : %02i", runTimer/60/3600, (runTimer/3600)%60, (runTimer/60)%60]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startOrPause:(id)sender
{
    if(running)
	{
		// If we're paused, then resume and set the title to "Pause"
		running = NO;
        [startButton setTitle:@"RESUME" forState:UIControlStateNormal];
        
        [timeLabel setTextColor:[UIColor redColor]];
    }
	else
	{
		// If we are not paused, then pause and set the title to "Resume"
		running = YES;
        [startButton setTitle:@"PAUSE" forState:UIControlStateNormal];
        
        [timeLabel setTextColor:[UIColor whiteColor]];
    }
}

- (IBAction)onReset:(id)sender {
    //UIAlertView *confirm = [[UIAlertView alloc] initWithTitle:@"Reset" message:@"Reset timer and counter?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Reset", nil];
    //[confirm show];
    [self setRunning:NO];
    
    [self setStepCount:0];
    [self setWalkSteps:0];
    [self setRunSteps:0];
    
    [startButton setTitle:@"START" forState:UIControlStateNormal];
    [timeLabel setText:@"00 : 00 : 00"];
    [timeLabel setTextColor:[UIColor redColor]]; 
    [stepsLabel setText:@"0"];
    [stepData reset];
    
    [state0Label setAlpha:0.1];
    [state1Label setAlpha:0.1];
    [state2Label setAlpha:0.1];
    [state3Label setAlpha:0.1];
    
    [self setTimer:0];
    [self setWalkTimer:0];
    [self setRunTimer:0];
    
    [appDelegate setTotalSteps:0];
    [appDelegate setTotalTime:@"00 : 00 : 00"];
    [appDelegate setWalkSteps:0];
    [appDelegate setWalkTime:@"00 : 00 : 00"];
    [appDelegate setRunSteps:0];
    [appDelegate setRunTime:@"00 : 00 : 00"];
}

@end
