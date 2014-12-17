//
//  Obstacle.m
//  HelpTheBirdie
//
//  Created by saranyashanmugam on 5/11/14.
//  Copyright (c) 2014 SaranyaAndPavana. All rights reserved.
//

#import "Obstacle.h"

@implementation Obstacle

@synthesize balloonObstacle,kiteObstacle,flyObstacle,ballObstacle;


SKTexture* balloonTexture,*kiteTexture,*flyTexture1, *flyTexture2, *ballTexture;
NSTimeInterval durationForObstacle;

// Designated initializer with speed for obstacle.
-(id)initWithDuration:(NSTimeInterval) duration
{
    if(self = [super init])
    {
        durationForObstacle = duration;
        balloonTexture = [SKTexture textureWithImageNamed:@"baloon"];
        balloonTexture.filteringMode = SKTextureFilteringNearest;
        
        kiteTexture = [SKTexture textureWithImageNamed:@"kite1"];
        kiteTexture.filteringMode = SKTextureFilteringNearest;
        
        flyTexture1 = [SKTexture textureWithImageNamed:@"flyUp"];
        flyTexture1.filteringMode = SKTextureFilteringNearest;
        
        flyTexture2 = [SKTexture textureWithImageNamed:@"flyDown"];
        flyTexture2.filteringMode = SKTextureFilteringNearest;
        
        ballTexture = [SKTexture textureWithImageNamed:@"ballx"];
        ballTexture.filteringMode = SKTextureFilteringNearest;
        
    }
    return self;
}

// Creates kites and sets their position and animation.
-(SKSpriteNode *) addKiteObstacle:(CGRect) frame
{
    self.kiteObstacle = [SKSpriteNode spriteNodeWithTexture:kiteTexture];
    [self.kiteObstacle setScale:1];
    self.kiteObstacle.name = @"kite";
    self.kiteObstacle.position = CGPointMake(frame.size.width,0);
    self.kiteObstacle.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.kiteObstacle.size.width/2];
    self.kiteObstacle.physicsBody.restitution = 0.0;
    self.kiteObstacle.physicsBody.friction = 0.4;
    self.kiteObstacle.physicsBody.usesPreciseCollisionDetection = YES;
    self.kiteObstacle.physicsBody.dynamic = NO;
    
    SKAction* moveObstacle = [SKAction repeatActionForever:[SKAction moveByX:-3 y:2 duration:0.02]];
    [kiteObstacle runAction:moveObstacle];
    
    return self.kiteObstacle;
}

// Creates flies and sets their position and animation.
-(SKSpriteNode *) addFliesObstacle:(CGRect) frame
{
    
    NSNumber *height = @(frame.size.height);
    int randomY = arc4random() % [height intValue];
    self.flyObstacle = [SKSpriteNode spriteNodeWithTexture:flyTexture1];
    [self.flyObstacle  setScale:0.4];
    self.flyObstacle.name = @"flies";
    self.flyObstacle .position = CGPointMake(frame.size.width,randomY);
    self.flyObstacle .physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.flyObstacle.size.width/2];
    self.flyObstacle .physicsBody.restitution = 0.0;
    self.flyObstacle .physicsBody.friction = 0.4;
    self.flyObstacle .physicsBody.usesPreciseCollisionDetection = YES;
    self.flyObstacle .physicsBody.dynamic = NO;
    
    [self fliesAction:randomY];
    
    return self.flyObstacle ;
}

// Action for flies.
-(void) fliesAction:(int) yPosition
{
    wings = [SKAction repeatActionForever:[SKAction animateWithTextures:@[flyTexture1, flyTexture2] timePerFrame:0.00001]];
    [self.flyObstacle runAction:wings];
    SKAction* move = [SKAction moveTo:CGPointMake(-10, yPosition) duration:2.0];
    SKAction* remove = [SKAction removeFromParent];
    [self.flyObstacle runAction:[SKAction sequence:@[move,remove]]];
}

// Creates balloons and sets their position and animation.
- (SKSpriteNode*)addBalloonObstacle:(CGRect) frame
{
    NSNumber *num = @(frame.size.width);
    int random = arc4random() % [num intValue];
    
    self.balloonObstacle = [SKSpriteNode spriteNodeWithTexture:balloonTexture];
    [self.balloonObstacle setScale:0.2];
    self.balloonObstacle.name = @"balloon";
    self.balloonObstacle.position = CGPointMake(random, self.balloonObstacle.size.height/4);
    self.balloonObstacle.physicsBody.usesPreciseCollisionDetection = YES;
    self.balloonObstacle.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.balloonObstacle.size.height/2];
    self.balloonObstacle.physicsBody.restitution = 0.0;
    self.balloonObstacle.physicsBody.friction = 0.4;
    self.balloonObstacle.physicsBody.dynamic = NO;

    SKAction* moveObstacle = [SKAction repeatActionForever:[SKAction moveByX:-1 y:3 duration:durationForObstacle]];
    [balloonObstacle runAction:moveObstacle];
    
    return self.balloonObstacle;
}

// Creates balls and sets their position and animation.
-(SKSpriteNode *) addBallObstacle:(CGRect) frame
{
    self.ballObstacle = [SKSpriteNode spriteNodeWithTexture:ballTexture];
    [self.ballObstacle setScale:0.14];
    self.ballObstacle.name = @"ball";
    self.ballObstacle.position = CGPointMake(-10,-20);
    self.ballObstacle.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.ballObstacle.size.height/2];
    self.ballObstacle.physicsBody.restitution = 0.0;
    self.ballObstacle.physicsBody.friction = 0.4;
    self.ballObstacle.physicsBody.usesPreciseCollisionDetection = YES;
    self.ballObstacle.physicsBody.dynamic = NO;
    
    SKAction *oneRevolution = [SKAction rotateByAngle:-M_PI*2 duration:4.0];
    
    UIBezierPath *circle = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0,0, 300,300)
                                                      cornerRadius:100];
    SKAction *followCircle = [SKAction followPath:circle.CGPath asOffset:YES orientToPath:NO duration:5.0];

    SKAction *group = [SKAction group:@[oneRevolution, followCircle]];
    [ballObstacle runAction:group];
    
    return self.ballObstacle;
}

@end
