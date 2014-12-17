//
//  Obstacle.h
//  HelpTheBirdie
//
//  Created by saranyashanmugam on 5/11/14.
//  Copyright (c) 2014 SaranyaAndPavana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Obstacle : NSObject
{
    SKAction *wings;
}

@property (nonatomic, strong) SKSpriteNode *balloonObstacle;

@property (nonatomic, strong) SKSpriteNode *kiteObstacle;

@property (nonatomic, strong) SKSpriteNode *flyObstacle;

@property (nonatomic, strong) SKSpriteNode *ballObstacle;

-(SKSpriteNode*) addBalloonObstacle:(CGRect) size;
-(SKSpriteNode *) addKiteObstacle:(CGRect) frame;
-(SKSpriteNode *) addFliesObstacle:(CGRect) frame;
-(SKSpriteNode *) addBallObstacle:(CGRect) frame;

// Designated intializer.
-(id)initWithDuration:(NSTimeInterval) duration;

@end
