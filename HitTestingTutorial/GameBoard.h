//
//  GameBoard.h
//  Ankh Morpork
//
//  Created by Eric Lanz on 8/5/12.
//  Copyright (c) 2012 200 Monkeys. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GameBoardDelegate <NSObject>

@optional
- (void) cityRegionTapped:(int)region;

@end

@interface GameBoard : UIViewController
{
    UIImageView * _boardImageView;
    id<GameBoardDelegate> _gameBoardDelegate;
}

- (void) pulseOverlayForRegion:(int)region;

@end
