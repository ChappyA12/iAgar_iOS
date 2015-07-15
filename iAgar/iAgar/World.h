//
//  World.h
//  iAgar
//
//  Created by Chappy Asel on 6/21/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Cell.h"

@interface World : SKNode <CellDelegate>

@property (nonatomic) CGSize size;
@property (nonatomic) NSMutableArray *food;

- (instancetype) init;

- (void) spawnFood: (int) amount;

- (Cell *) spawnFood;

- (CGPoint) determineValidSpawn;

@end
