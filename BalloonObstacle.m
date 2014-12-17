//
//  BalloonObstacle.m
//  HelpTheBirdie
//
//  Created by saranyashanmugam on 5/16/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import "BalloonObstacle.h"

@implementation BalloonObstacle

@synthesize balloonObstacle;

- (id) init
{
    [self applyTextureAndSize];
    [self addPhysicsToBalloonObstacle];
    return self;
}

- (void) applyTextureAndSize
{
    balloonTexture = [SKTexture textureWithImageNamed:@"baloon"];
    balloonTexture.filteringMode = SKTextureFilteringNearest;
    

    self.balloonObstacle = [SKSpriteNode spriteNodeWithTexture:balloonTexture];
    [self.balloonObstacle setScale:0.2];
}


- (void) balloonAction:(int) yPosition
{
    /* SKAction* moveApples = [SKAction repeatActionForever:[SKAction moveByX:-1 y:0 duration:0.06]];
     SKAction* removeApples = [SKAction removeFromParent];
     moveAndRemoveApples = [SKAction sequence:@[moveApples, removeApples]];
     [self.apple runAction:moveAndRemoveApples]; */
    
    //Speed of apple
    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    NSLog(@"%d actual duration",actualDuration);
    NSLog(@"%d yPosition",yPosition);
    // Create the actions
    SKAction* moveBalloon = [SKAction moveTo:CGPointMake(-self.balloonObstacle.size.width/2, yPosition) duration:0.5];
    SKAction* removeBalloon = [SKAction removeFromParent];
    [self.balloonObstacle runAction:[SKAction sequence:@[moveBalloon, removeBalloon]]];
}

- (void) addPhysicsToBalloonObstacle
{
    self.balloonObstacle.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.balloonObstacle.size.height / 2];
    self.balloonObstacle.physicsBody.dynamic = NO;
}

- (void) setBalloonPositionWithFrameWidth:(CGFloat) frameWidth
                         andFrameHeight:(CGFloat) frameHeight
                          andBirdHeight:(CGFloat) birdHeight
{
    int minY = birdHeight + 7;
    int maxY = frameWidth - self.balloonObstacle.size.width / 2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    self.balloonObstacle.position = CGPointMake(actualY,self.balloonObstacle.size.height);
    [self balloonAction:actualY];
}


@end
