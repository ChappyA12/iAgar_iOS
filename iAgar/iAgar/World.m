//
//  World.m
//  iAgar
//
//  Created by Chappy Asel on 6/21/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "World.h"

@implementation World

- (instancetype) init {
    if (self = [super init]) {
        self.size = CGSizeMake(1000, 1000);
        self.food = [[NSMutableArray alloc] init];
        SKShapeNode *edge = [SKShapeNode shapeNodeWithRect:CGRectMake(0, 0, self.size.width, self.size.height)];
        edge.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, self.size.width, self.size.height)];
        edge.physicsBody.dynamic = NO;
        [self addChild:edge];
    }
    return self;
}

- (void) spawnFood: (int) amount {
    for (int i = 0; i < amount; i++) {
        Cell *c = [[Cell alloc] initWithVolume:1 Position:[self determineValidSpawn]];
        [self.food addObject:c];
        c.delegate = self;
        [self addChild:c];
    }
}

- (Cell *) spawnFood {
    Cell *c = [[Cell alloc] initWithVolume:1 Position:[self determineValidSpawn]];
    [self.food addObject:c];
    c.delegate = self;
    [self addChild:c];
    return c;
}

- (void) cellShouldBeRemovedFromStorage:(Cell *)cell {
    [self.food removeObject:cell];
}

- (CGPoint) determineValidSpawn {
    return CGPointMake(arc4random()%((int)self.size.width-40)+20, arc4random()%((int)self.size.width-40)+20);
}

@end
