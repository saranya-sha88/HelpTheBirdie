//
//  Bird.m
//  HelpTheBirdie
//
//  Created by Pavana on 5/7/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import "Bird.h"
#import "MenuScene.h"

@implementation Bird

@synthesize bird;

- (id) init
{
    if(self = [super init])
    {
        [self applyTextureAndSize];
        [self birdAction];
        [self addPhysicsToBird];
    }
    return self;
}

// Creates a bird node using three images and sets its size.
- (void) applyTextureAndSize
{
    birdTextureWingUp = [SKTexture textureWithImageNamed:@"BirdWingUp"];
    birdTextureWingUp.filteringMode = SKTextureFilteringNearest;
    birdTextureWingSlant = [SKTexture textureWithImageNamed:@"BirdWingSlant"];
    birdTextureWingSlant.filteringMode = SKTextureFilteringNearest;
    birdTextureWingDown = [SKTexture textureWithImageNamed:@"BirdWingDown"];
    birdTextureWingDown.filteringMode = SKTextureFilteringNearest;
    self.bird = [SKSpriteNode spriteNodeWithTexture:birdTextureWingUp];
    [self.bird setScale:0.3];
}

// Creates flying bird animation.
- (void) birdAction
{
    birdFlyAction = [SKAction repeatActionForever:[SKAction animateWithTextures:@[birdTextureWingUp, birdTextureWingSlant,birdTextureWingDown] timePerFrame:0.2]];
    [self.bird runAction:birdFlyAction];
}

// Sets bird's physics property.
- (void) addPhysicsToBird
{
    self.bird.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.bird.size.height / 2];
    self.bird.physicsBody.dynamic = YES;
    self.bird.physicsBody.allowsRotation = NO;
    
    if(!isPlayModeTap)
    {
        self.bird.physicsBody.affectedByGravity = NO;
        self.bird.physicsBody.mass = 0.02;
    }
    self.bird.physicsBody.restitution = 0.0;
}

// Sets bird position.
- (void) setBirdPositionWithFrameWidth:(CGFloat) frameWidth
                              andFrame:(CGRect) frameRect
{
    self.bird.position = CGPointMake(frameWidth / 4, CGRectGetMidY(frameRect));
}

@end

