//
//  Player.h
//  iAgar
//
//  Created by Chappy Asel on 6/20/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Cell.h"

@interface Player : SKNode <CellDelegate>

@property (nonatomic) NSMutableArray *cells;
@property (nonatomic) CGPoint direction;
@property (nonatomic) CGPoint center;
@property (nonatomic, assign) NSInteger totalVolume;
@property (nonatomic) UIColor *color;

- (instancetype) init;

- (void) updatePositionWithTimeInvterval: (CFTimeInterval) interval;

- (void) setCenterP: (CGPoint)center;

- (void) split;

- (void) ejectMass;

@end
