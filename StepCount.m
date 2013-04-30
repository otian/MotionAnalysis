//
//  StepCount.m
//  MotionStateRecognition
//
//  Created by Ou Tian on 3/9/13.
//
//

#import "StepCount.h"

@implementation StepCount

-(id)init
{
    pos = 0;
    count = 0;
    const double f[] = {0.0035,-0.0042,-0.0041,-0.0045,-0.0046,-0.0040,-0.0025,-0.0001, 0.0030, 0.0062, 0.0090, 0.0105, 0.0102, 0.0078, 0.0031,-0.0034,-0.0107,-0.0178,-0.0230,-0.0248,-0.0221,-0.0139,-0.0001, 0.0188, 0.0413, 0.0655, 0.0890, 0.1094, 0.1244, 0.1324, 0.1324, 0.1244, 0.1094, 0.0890, 0.0655, 0.0413, 0.0188,-0.0001,-0.0139,-0.0221,-0.0248,-0.0230,-0.0178,-0.0107,-0.0034, 0.0031, 0.0078, 0.0102, 0.0105, 0.0090, 0.0062, 0.0030,-0.0001,-0.0025,-0.0040,-0.0046,-0.0045,-0.0041,-0.0042, 0.0035};
    //const double f[] = {0.0467, -0.0574, -0.0288, -0.0131, -0.0062, -0.0058, -0.0099, -0.0166, -0.0243, -0.0307, -0.0339, -0.0328, -0.0270, -0.0178, -0.0075, 0.0008, 0.0039, -0.0003, -0.0120, -0.0288, -0.0467, -0.0601, -0.0634, -0.0528, -0.0271, 0.0113, 0.0570, 0.1018, 0.1377, 0.1576, 0.1576, 0.1377, 0.1018, 0.0570, 0.0113, -0.0271, -0.0528, -0.0634, -0.0601, -0.0467, -0.0288, -0.0120, -0.0003, 0.0039, 0.0008, -0.0075, -0.0178, -0.0270, -0.0328, -0.0339, -0.0307, -0.0243, -0.0166, -0.0099, -0.0058, -0.0062, -0.0131, -0.0288, -0.0574, 0.0476};
    for (int i = 0; i < SDATALENGTH; i++) {
        filter[i] = f[i];
        data[i] = 0;
        fdata[i] = 0;
        peak[i] = NO;
    }
    hpos = 0;
    lpos = 0;
    hval = 0;
    lval = 0;
    high = NO;
    large = NO;
    stepsPerSec = 0;
    stepsPerSec2 = 0;
    return self;
}

-(void)conv
{
    double r = 0;
    for (int i = 0; i < SDATALENGTH; i++) {
        r += filter[i]*data[(i+pos)%SDATALENGTH];
    }
    //NSLog(@"%f", r);
    fdata[pos] = r;
}

-(void)count
{
    int prev = (pos+SDATALENGTH-1)%SDATALENGTH;
    if (fdata[pos] < fdata[prev]) {
        if (high && fdata[prev]-lval > .2) {
            if ((pos+SDATALENGTH-hpos)%SDATALENGTH > 60/5 && !large) {
                hpos = prev;
                hval = fdata[prev];
                large = YES;
                peak[pos] = YES;
                stepsPerSec2 = stepsPerSec;
                stepsPerSec++;
                count++;
            }
            else if (fdata[prev] > hval) {
                hpos = prev;
                hval = fdata[prev];
            }
        }
        high = NO;
    }
    else if (fdata[pos] > fdata[(pos+SDATALENGTH-1)%SDATALENGTH])
    {
        if (high && hval-fdata[prev] > .2) {
            if (large) {
                lpos = prev;
                lval = fdata[prev];
                large = NO;
            }
            else if (fdata[prev] < lval) {
                lpos = prev;
                lval = fdata[prev];
            }
        }
        high = YES;
    }
}

-(NSInteger)estState
{
    double min = 2, max = 0;
    for (int i = 0; i != SDATALENGTH; i++) {
        if (data[i] > max) max = data[i];
        if (data[i] < min) min = data[i];
    }
    if (max-min < 0.015) return 0;
    else if (stepsPerSec+stepsPerSec2 <= 3) return 1;
    else if (stepsPerSec+stepsPerSec2 <= 5) return 2;
    else return 3;
}

-(NSInteger)newData:(double)acc
{
    NSLog(@"%f", acc);
    if (peak[pos] == YES) {
        stepsPerSec2 = stepsPerSec;
        stepsPerSec--;
    }
    data[pos] = acc;
    peak[pos] = NO;
    
    //NSLog(@"stepsPerSec: %d", stepsPerSec);
    
    [self conv];
    [self count];
    
    pos = (pos+1)%SDATALENGTH;
    return count;
}

-(void)reset
{
    pos = 0;
    count = 0;
    for (int i = 0; i < SDATALENGTH; i++) {
        data[i] = 0;
        fdata[i] = 0;
    }
    hpos = 0;
    lpos = 0;
    hval = 0;
    lval = 0;
    high = NO;
    large = NO;
}


@end
