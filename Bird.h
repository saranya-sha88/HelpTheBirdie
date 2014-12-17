//
//  Bird.h
//  HelpTheBirdie
//
//  Created by Pavana on 5/7/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Bird : NSObject
{
    SKTexture* birdTextureWingUp;
    SKTexture* birdTextureWingSlant;
    SKTexture* birdTextureWingDown;
    SKAction* birdFlyAction;
}


@property SKSpriteNode* bird;


- (void) setBirdPositionWithFrameWidth:(CGFloat) frameWidth
                              andFrame:(CGRect) frameRect;

@end
