//
//  GameBoard.m
//  Ankh Morpork
//
//  Created by Eric Lanz on 8/5/12.
//  Copyright (c) 2012 200 Monkeys. All rights reserved.
//

#import "GameBoard.h"

#define cityArea_none 0
#define cityArea_dollySisters 1
#define cityArea_unrealEstate 2
#define cityArea_dragonsLanding 3
#define cityArea_smallGods 4
#define cityArea_theScours 5
#define cityArea_theHippo 6
#define cityArea_theShades 7
#define cityArea_dimwell 8
#define cityArea_longwall 9
#define cityArea_isleOfGods 10
#define cityArea_sevenSleepers 11
#define cityArea_napHill 12

@implementation GameBoard

- (NSString*) keyForRegion:(int)region
{
    switch (region) {
        case cityArea_dollySisters: return @"dolly_sisters";
        case cityArea_unrealEstate: return @"unreal_estate";
        case cityArea_dragonsLanding: return @"dragons_landing";
        case cityArea_smallGods: return @"small_gods";
        case cityArea_theScours: return @"the_scours";
        case cityArea_theHippo: return @"the_hippo";
        case cityArea_theShades: return @"the_shades";
        case cityArea_dimwell: return @"dimwell";
        case cityArea_longwall: return @"longwall";
        case cityArea_isleOfGods: return @"isle_of_gods";
        case cityArea_sevenSleepers: return @"seven_sleepers";
        case cityArea_napHill: return @"nap_hill";
        default: return nil;
    }
}

- (int) regionForPoint:(CGPoint)point
{
    static CFDataRef pixelData;
    if (!pixelData)
    {
        pixelData = CGDataProviderCopyData(CGImageGetDataProvider([UIImage imageNamed:@"boardhitregions"].CGImage));
    }
    const UInt8* data = CFDataGetBytePtr(pixelData);
    int pixelInfo = ((771 * (int)point.y) + (int)point.x ) * 4;
    UInt8 blue = data[pixelInfo + 2];
    
    switch (blue) {
        case 10: return cityArea_dollySisters;
        case 53: return cityArea_unrealEstate;
        case 40: return cityArea_dragonsLanding;
        case 139: return cityArea_smallGods;
        case 99: return cityArea_theScours;
        case 109: return cityArea_theHippo;
        case 119: return cityArea_theShades;
        case 129: return cityArea_dimwell;
        case 88: return cityArea_longwall;
        case 77: return cityArea_isleOfGods;
        case 65: return cityArea_sevenSleepers;
        case 26: return cityArea_napHill;
        default: return cityArea_none;
    }
}

- (UIImage*) overlayForRegion:(int)cityRegion
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"highlight_%@", [self keyForRegion:cityRegion]]];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchLoc = [[touches anyObject] locationInView:self.view];
    int cityArea = [self regionForPoint:touchLoc];
    if (cityArea != cityArea_none)
    {
        [self pulseOverlayForRegion:cityArea];
    }
}

- (void) pulseOverlayForRegion:(int)region
{
    UIImage * overlay = [self overlayForRegion:region];
    UIImageView * overlayView = [[UIImageView alloc] initWithImage:overlay];
    [overlayView setAlpha:0];
    [self.view addSubview:overlayView];
    [UIView animateWithDuration:0.3 animations:^{
        [overlayView setAlpha:1.0];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            [overlayView setAlpha:0.0];
        } completion:^(BOOL finished) {
            [overlayView removeFromSuperview];
        }];
    }];
}

@end
