//
//  Apple.h
//  HelpTheBirdie
//
//  Created by Pavana on 5/7/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Apple : NSObject
{
    SKTexture* imageTexture;
}

@property SKSpriteNode *power;

//Designated initialilizer.
-(id) initWithImage:(NSString*) imageName;

- (void) setPositionWithFrameWidth:(CGFloat) frameWidth
                    andFrameHeight:(CGFloat) frameHeight
                     andBirdHeight:(CGFloat) birdHeight
                      andImageName:(NSString *) imageName;



@end
