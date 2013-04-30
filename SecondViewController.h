//
//  SecondViewController.h
//  Motion Analysis
//
//  Created by Ou Tian on 4/23/13.
//  Copyright (c) 2013 Ou Tian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SecondViewController : UITableViewController
{
    AppDelegate *appDelegate;
}

@property (weak, nonatomic) IBOutlet UILabel *totalStepsLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *walkStepsLabel;
@property (weak, nonatomic) IBOutlet UILabel *walkTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *runStepsLabel;
@property (weak, nonatomic) IBOutlet UILabel *runTimeLabel;

@end
