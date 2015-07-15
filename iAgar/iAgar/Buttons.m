//
//  Buttons.m
//  iAgar
//
//  Created by Chappy Asel on 6/23/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "Buttons.h"

@implementation Buttons {
    SKShapeNode *buttonA;
    SKShapeNode *buttonB;
    // Touch handling
    CFMutableDictionaryRef trackedTouches;
}

- (instancetype)initWithRect:(CGRect)rect {
    if ((self = [super init])) {
        // Touch handling
        trackedTouches = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        self.position = rect.origin;
        //Button A
        buttonA = [SKShapeNode node];
        buttonA.fillColor = [UIColor grayColor];
        buttonA.strokeColor = [UIColor clearColor];
        buttonA.lineWidth = 0;
        buttonA.path = CGPathCreateWithEllipseInRect(CGRectMake(rect.size.width/2, rect.size.width/2, rect.size.width/2, rect.size.width/2), NULL);
        buttonA.alpha = 0.4;
        [self addChild:buttonA];
        //text A
        SKLabelNode *labelA = [[SKLabelNode alloc]initWithFontNamed:@"Arial-BoldMT"];
        labelA.text = @"Eject";
        labelA.fontSize = 20;
        labelA.fontColor = [UIColor whiteColor];
        labelA.position = CGPointMake(rect.size.width/2+35, rect.size.width/2+28);
        [self addChild:labelA];
        //Button B
        buttonB = [SKShapeNode node];
        buttonB.fillColor = [UIColor grayColor];
        buttonB.strokeColor = [UIColor clearColor];
        buttonB.lineWidth = 0;
        buttonB.path = CGPathCreateWithEllipseInRect(CGRectMake(0, 0, rect.size.width/2, rect.size.width/2), NULL);
        buttonB.alpha = 0.4;
        [self addChild:buttonB];
        //text B
        SKLabelNode *labelB = [[SKLabelNode alloc]initWithFontNamed:@"Arial-BoldMT"];
        labelB.text = @"Split";
        labelB.fontSize = 20;
        labelB.fontColor = [UIColor whiteColor];
        labelB.position = CGPointMake(35, 28);
        [self addChild:labelB];
    }
    return self;
}

#pragma mark Touch Handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        UITouch *touch = (UITouch *)obj;
        CGPoint location = [touch locationInNode:self];
        if ([buttonA containsPoint:location]) {
            [self.delegate buttonAPressed];
            CFDictionarySetValue(trackedTouches, (__bridge void *)touch, (__bridge void *)touch);
        }
        if ([buttonB containsPoint:location]) {
            [self.delegate buttonBPressed];
            CFDictionarySetValue(trackedTouches, (__bridge void *)touch, (__bridge void *)touch);
        }
    }];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    // Determine if any of the touches are one of those being tracked
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        UITouch *touch = (UITouch *) CFDictionaryGetValue(trackedTouches, (__bridge void *)(UITouch *)obj);
        if (touch != NULL) { // This touch is being tracked
            //CGPoint location = [touch locationInNode:self];
        }
    }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        UITouch *touch = (UITouch *) CFDictionaryGetValue(trackedTouches, (__bridge void *)(UITouch *)obj);
        if (touch != NULL) { // This touch was being tracked
            CFDictionaryRemoveValue(trackedTouches, (__bridge void *)touch);
        }
    }];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}


@end
