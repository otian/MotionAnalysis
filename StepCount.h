//
//  StepCount.h
//  MotionStateRecognition
//
//  Created by Ou Tian on 3/9/13.
//
//

#import <Foundation/Foundation.h>

#define SDATALENGTH 60

@interface StepCount : NSObject
{
    int pos, hpos, lpos;
    double hval, lval;
    NSInteger count;
    double filter[SDATALENGTH];
    double data[SDATALENGTH];
    double fdata[SDATALENGTH];
    Boolean high, large;
    
    int stepsPerSec, stepsPerSec2;
    Boolean peak[SDATALENGTH];
}

-(NSInteger)newData:(double)acc;
-(void)conv;
-(void)count;
-(void)reset;
-(NSInteger)estState;

@end
