//
//  AppDelegate.h
//  Motion Analysis
//
//  Created by Ou Tian on 4/23/13.
//  Copyright (c) 2013 Ou Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, assign) NSInteger totalSteps;
@property (nonatomic, assign) NSInteger walkSteps;
@property (nonatomic, assign) NSInteger runSteps;
@property (nonatomic, retain) NSString* totalTime;
@property (nonatomic, retain) NSString* walkTime;
@property (nonatomic, retain) NSString* runTime;

@end
