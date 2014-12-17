//
//  GameStartScene.h
//  HelpTheBirdie
//
//  Created by Pavana on 5/11/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CommonScene.h"
#import "BackgroundSound.h"

@interface GameStartScene : CommonScene
{
    SKSpriteNode* bird;
    CGFloat frameWidth;
    CGFloat frameHeight;
    CGRect frameRect;
}

// Designated initializer.
-(id)initWithSize:(CGSize)size
         andLevel:(NSString*)currentLevel;
@end
