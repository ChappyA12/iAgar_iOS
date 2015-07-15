//
//  Cell.m
//  iAgar
//
//  Created by Chappy Asel on 6/20/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "Cell.h"

@implementation Cell

int sizeMultiplier = 5;

- (instancetype) initWithVolume:(int)vol {
    if (self = [super init]) {
        self.circle = [SKShapeNode node];
        [self setVol:vol];
        self.circle.strokeColor = [UIColor darkGrayColor];
        self.circle.lineWidth = 2.0;
        [self addChild:self.circle];
    }
    return self;
}

- (instancetype) initWithVolume:(int)vol Position:(CGPoint)position {
    if (self = [super init]) {
        self.circle = [SKShapeNode node];
        [self setVol:vol];
        self.circle.strokeColor = [UIColor darkGrayColor];
        self.circle.lineWidth = 2.0;
        [self addChild:self.circle];
        self.position = position;
    }
    return self;
}

- (void) setColor: (UIColor *) color {
    self.circle.fillColor = color;
}

- (void) applyPhysics {
    //PHYSICS
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.radius*sizeMultiplier];
    self.physicsBody.friction = 0.0;
    self.physicsBody.restitution = 1.0;
    self.physicsBody.linearDamping = 0.0;
    self.physicsBody.allowsRotation = NO;
    self.physicsBody.affectedByGravity = NO;
}

- (void) updatePositionWithTimeInvterval: (CFTimeInterval) interval Direction: (CGPoint) direction {
    //self.position = CGPointMake( self.position.x + direction.x * interval * (self.movementSpeed), self.position.y + direction.y * interval * (self.movementSpeed));
    [self.physicsBody setVelocity:CGVectorMake(direction.x*self.movementSpeed, direction.y*self.movementSpeed)];
}

- (void) setVol:(int)vol {
    self.volume = vol;
    self.radius = sqrtf(vol/3.1);
    //movement speed
    if (self.volume < 100) self.movementSpeed = 120-self.volume; //120-20
    else self.movementSpeed = 20;
    //visual
    self.circle.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.radius*sizeMultiplier*2, self.radius*sizeMultiplier*2)].CGPath;
    self.circle.position = CGPointMake(-self.radius*sizeMultiplier, -self.radius*sizeMultiplier);
    if (self.physicsBody) [self applyPhysics];
}

- (void) addVol:(int)vol {
    [self setVol:self.volume+vol];
}

- (void) collidedWith: (Cell *) cell {
    if (cell.radius < self.radius) {
        [self addVol:cell.volume];
    }
    else {
        [self.delegate cellShouldBeRemovedFromStorage:self];
        [self removeFromParent];
    }
}

@end
