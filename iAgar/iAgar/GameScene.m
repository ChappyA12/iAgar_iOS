//
//  GameScene.m
//  iAgar
//
//  Created by Chappy Asel on 6/14/15.
//  Copyright (c) 2015 CD. All rights reserved.
//

#import "GameScene.h"
#import "Player.h"
#import "Cell.h"
#import "World.h"
#import "DPad.h"

typedef enum : uint8_t {
    ColliderTypePlayer   = 1,
    ColliderTypeFood     = 2,
    ColliderTypeWall     = 4,
} ColliderType;

@interface GameScene()
@property (assign, nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (strong, nonatomic) World *world;
@property (strong, nonatomic) Player *player;
@property (strong, nonatomic) SKNode *hud;
@property (strong, nonatomic) DPad *dPad;
@property (strong, nonatomic) Buttons *buttons;
@property (strong, nonatomic) SKLabelNode *playerSize;
@end

@implementation GameScene

- (instancetype) initWithSize:(CGSize)size {
    if ((self = [super initWithSize:size])) {
        self.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
        self.scaleMode = SKSceneScaleModeAspectFit;
        self.physicsWorld.contactDelegate = self;
        // WORLD
        self.world = [[World alloc] init];
        self.world.name = @"WORLD";
        [self addChild:self.world];
        [self.world spawnFood:100];
        // PLAYER
        self.player = [[Player alloc] init];
        [self.world addChild:self.player];
        [self.player.cells[0] applyPhysics];
        ((Cell *)self.player.cells[0]).physicsBody.categoryBitMask = ColliderTypePlayer;
        ((Cell *)self.player.cells[0]).physicsBody.collisionBitMask = ColliderTypePlayer | ColliderTypeWall;
        ((Cell *)self.player.cells[0]).physicsBody.contactTestBitMask = ColliderTypeFood;
        [self.player setCenterP:CGPointMake(self.world.size.width/2, self.world.size.height/2)];
        // HUD
        self.hud = [SKNode node];
        self.hud.name = @"HUD";
        self.dPad = [[DPad alloc] initWithRect:CGRectMake(0, 0, 120, 120)];
        self.dPad.name = @"DPAD";
        self.dPad.position = CGPointMake(30,30);
        self.buttons = [[Buttons alloc] initWithRect:CGRectMake(550, 30, 150, 100)];
        self.buttons.name = @"BUTTONS";
        self.buttons.delegate = self;
        [self.hud addChild:self.dPad];
        [self.hud addChild:self.buttons];
        SKShapeNode *playerSizeBG = [SKShapeNode shapeNodeWithRect:CGRectMake(10, self.frame.size.height-35, 124, 30)];
        playerSizeBG.fillColor = [UIColor blackColor];
        playerSizeBG.alpha = 0.4;
        [self.hud addChild:playerSizeBG];
        self.playerSize = [SKLabelNode labelNodeWithText:@"Size: -"];
        self.playerSize.fontColor = [UIColor whiteColor];
        self.playerSize.fontSize = 20;
        self.playerSize.fontName = @"Arial-BoldMT";
        self.playerSize.position = CGPointMake(67, self.frame.size.height-30);
        [self.hud addChild:self.playerSize];
        [self addChild:self.hud];
    }
    return self;
}

- (void) didMoveToView:(nonnull SKView *)view {
    for (Cell *c in self.world.food) {
        [c applyPhysics];
        c.physicsBody.categoryBitMask = ColliderTypeFood;
        c.physicsBody.collisionBitMask = ColliderTypeFood | ColliderTypeWall;
        c.physicsBody.contactTestBitMask = ColliderTypePlayer;
        [c setColor:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]];
    }
}

- (void) update:(CFTimeInterval)currentTime {
    //self.size = CGSizeMake(200, 200);
    /*
    if (self.world.children.count < 150 && arc4random() % 20 == 1) {
        Cell *c = [self.world spawnFood];
        [c applyPhysics];
        c.physicsBody.categoryBitMask = ColliderTypeFood;
        c.physicsBody.collisionBitMask = ColliderTypeFood | ColliderTypeWall;
        c.physicsBody.contactTestBitMask = ColliderTypePlayer;
    }
     */
    // Calculate the time since last update
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) {timeSinceLast = 1.0/60.0; self.lastUpdateTimeInterval = currentTime;}
    // PLAYER MOVEMENT
    self.player.direction = self.dPad.velocity; //velocity from dPad to Player (player only)
    [self.player updatePositionWithTimeInvterval:timeSinceLast]; //actual player movement
    // LABEL UPDATE
    self.playerSize.text = [NSString stringWithFormat:@"Size: %d",(int)self.player.totalVolume];
    // CAMERA
    self.world.position = CGPointMake(-self.player.center.x + CGRectGetMidX(self.frame), -self.player.center.y + CGRectGetMidY(self.frame));
}

- (void) didBeginContact:(SKPhysicsContact *)contact {
    SKNode *nodeA = contact.bodyA.node;
    SKNode *nodeB = contact.bodyB.node;
    if ([nodeA isKindOfClass:[Cell class]] && [nodeB isKindOfClass:[Cell class]]) {
        [(Cell *)nodeA collidedWith:(Cell *)nodeB];
        [(Cell *)nodeB collidedWith:(Cell *)nodeA];
    }
}

#pragma mark - touch handeling

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.view.multipleTouchEnabled = YES;
    [self.dPad touchesBegan:touches withEvent:event];
    [self.buttons touchesBegan:touches withEvent:event];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.dPad touchesMoved:touches withEvent:event];
    [self.buttons touchesMoved:touches withEvent:event];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.dPad touchesEnded:touches withEvent:event];
    [self.buttons touchesEnded:touches withEvent:event];
}

#pragma mark - delegate methods

- (void) buttonAPressed { //EJECT
    NSLog(@"BUTTON A");
    [self.player ejectMass];
}

- (void) buttonBPressed { //SPLIT
    NSLog(@"BUTTON B");
    [self.player split];
}

@end
