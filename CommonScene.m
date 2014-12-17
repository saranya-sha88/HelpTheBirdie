//
//  CommonScene.m
//  HelpTheBirdie
//
//  Created by Pavana on 5/12/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import "CommonScene.h"

@implementation CommonScene


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        [self addBackGround];
    }
    return self;
}

// Adds static background image.
- (void) addBackGround
{
    SKSpriteNode *backGround = [[SKSpriteNode alloc] initWithImageNamed:@"goldfish-background-01"];
    backGround.anchorPoint = CGPointZero;
    backGround.position = CGPointMake(-100, backGround.position.y);
    [self addChild:backGround];
}

@end
