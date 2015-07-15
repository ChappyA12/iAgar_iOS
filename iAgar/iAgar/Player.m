//
//  Player.m
//  iAgar
//
//  Created by Chappy Asel on 6/20/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "Player.h"

@implementation Player

- (instancetype) init {
    if ((self = [super init])) {
        self.color = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        self.cells = [[NSMutableArray alloc] initWithObjects:[[Cell alloc] initWithVolume:10], nil];
        ((Cell *)self.cells[0]).delegate = self;
        [((Cell *)self.cells[0]) setColor:self.color];
        [self addChild: self.cells[0]];
    }
    return self;
}

- (void) updatePositionWithTimeInvterval: (CFTimeInterval) interval {
    for (Cell *c in self.cells) [c updatePositionWithTimeInvterval: interval Direction: self.direction];
    self.center = ((Cell *)self.cells[0]).position;
}

- (void) setCenterP:(CGPoint)center {
    self.center = center;
    ((Cell *)self.cells[0]).position = center;
}

- (NSInteger) totalVolume {
    int total = 0;
    for (Cell *c in self.cells) total += c.volume;
    return total;
}

- (void) cellShouldBeRemovedFromStorage:(Cell *)cell {
    [self.cells removeObject:cell];
}

- (void) split {
    for (int i = 0; i < self.cells.count; i++) {
        Cell *c = self.cells[i];
        if (c.volume > 20) {
            int totalVol = c.volume;
            [c setVol:c.volume/2];
            Cell *c2 = [[Cell alloc] initWithVolume:totalVol-c.volume Position:CGPointMake(c.position.x+self.direction.x*c.radius, c.position.y+self.direction.y*c.radius)];
            c2.delegate = self;
            [c2 setColor:[UIColor redColor]];
            [self.cells addObject:c2];
            [self addChild: c2];
            [c2 applyPhysics];
            c2.physicsBody.velocity = CGVectorMake(self.direction.x*500, self.direction.y*500);
        }
    }
}

- (void) ejectMass {
    for (int i = 0; i < self.cells.count; i++) {
        Cell *c = self.cells[i];
        if (c.volume > 20) [c addVol:-10];
    }
}

- (CGPoint) center {
    return ((Cell *)self.cells[0]).position;
}

@end
