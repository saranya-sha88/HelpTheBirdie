//
//  Apple.m
//  HelpTheBirdie
//
//  Created by Pavana on 5/7/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import "Apple.h"

@implementation Apple

@synthesize power;

//Designated initialilizer with image name.
-(id) initWithImage:(NSString*) imageName
{
    [self applyTextureAndSize:imageName];
    [self addPhysics];
    return self;
}

// Creates power node using an image.
- (void) applyTextureAndSize:(NSString*) imageName
{
    imageTexture = [SKTexture textureWithImageNamed:imageName];
    imageTexture.filteringMode = SKTextureFilteringNearest;
    self.power = [SKSpriteNode spriteNodeWithTexture:imageTexture];
    if([imageName isEqualToString:@"star"])
    {
        self.power.name = @"star";
        [self.power setScale:1.5];
    }
    else
    {
        self.power.name = @"apple";
    }
    
}

// Creates moving animation.
- (void) action:(int) yPosition
   andXPosition:(CGFloat) xPosition
    andDuration:(NSTimeInterval) speed
{
     // Create the actions
    SKAction* move = [SKAction moveTo:CGPointMake(-xPosition, yPosition) duration:speed];
    SKAction* remove = [SKAction removeFromParent];
    [self.power runAction:[SKAction sequence:@[move, remove]]];
}


// Sets physics property.
- (void) addPhysics
{
    self.power.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.power.size.height / 2];
    self.power.physicsBody.restitution = 0.0;
    self.power.physicsBody.dynamic = NO;
}

// Sets the position.
- (void) setPositionWithFrameWidth:(CGFloat) frameWidth
                    andFrameHeight:(CGFloat) frameHeight
                     andBirdHeight:(CGFloat) birdHeight
                      andImageName:(NSString *) imageName
{
    int minimumY = birdHeight + 7;
    int maximumY = frameHeight - self.power.size.height / 2;
    int rangeY = maximumY - minimumY;
    int yPosition = (arc4random() % rangeY) + minimumY;
    
    self.power.position = CGPointMake(frameWidth + self.power.size.width/2, yPosition);
    if([imageName isEqualToString:@"star"])
    {
        [self action:yPosition andXPosition:-10 andDuration:4.0];
    }else{
        [self action:yPosition andXPosition:-self.power.size.width/2 andDuration:2.0];
    }

}


@end

