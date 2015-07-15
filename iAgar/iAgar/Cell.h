//
//  Cell.h
//  iAgar
//
//  Created by Chappy Asel on 6/20/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class Cell;

@protocol CellDelegate
-(void)cellShouldBeRemovedFromStorage: (Cell *) cell;
@end


@interface Cell : SKSpriteNode

@property (nonatomic) SKShapeNode *circle;
@property (nonatomic) int volume;
@property (nonatomic) float radius; //DO NOT WRITE
@property (nonatomic) float movementSpeed;

@property (nonatomic, weak) id<CellDelegate>  delegate;

- (instancetype) initWithVolume: (int) vol;

- (instancetype) initWithVolume: (int) vol Position: (CGPoint) position;

- (void) setVol: (int) vol;

- (void) addVol: (int) vol;

- (void) setColor: (UIColor *) color;

- (void) applyPhysics;

- (void) updatePositionWithTimeInvterval: (CFTimeInterval) interval Direction: (CGPoint) direction;

- (void) collidedWith: (Cell *) cell;

@end
