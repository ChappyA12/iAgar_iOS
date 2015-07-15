//
//  Buttons.h
//  iAgar
//
//  Created by Chappy Asel on 6/23/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class Buttons;

@protocol ButtonsDelegate
-(void)buttonAPressed;
-(void)buttonBPressed;
@end

@interface Buttons : SKNode

@property (nonatomic, weak) id<ButtonsDelegate> delegate;

- (instancetype)initWithRect:(CGRect)rect;

@end
