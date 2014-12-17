//
//  BalloonObstacle.h
//  HelpTheBirdie
//
//  Created by saranyashanmugam on 5/16/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>


@interface BalloonObstacle : NSObject
{
    SKTexture* balloonTexture,*kiteTexture;
}

@property SKSpriteNode* balloonObstacle;

- (void) setBalloonPositionWithFrameWidth:(CGFloat) frameWidth
                         andFrameHeight:(CGFloat) frameHeight
                          andBirdHeight:(CGFloat) birdHeight;

@end
