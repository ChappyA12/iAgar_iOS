//
//  GameScene.h
//  iAgar
//

//  Copyright (c) 2015 CD. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Buttons.h"

@interface GameScene : SKScene <SKPhysicsContactDelegate, ButtonsDelegate>

- (instancetype)initWithSize:(CGSize)size;

@end
