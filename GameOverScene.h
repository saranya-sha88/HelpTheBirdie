//
//  GameOverScene.h
//  HelpTheBirdie
//
//  Created by saranyashanmugam on 5/14/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CommonScene.h"

@interface GameOverScene : CommonScene

// Designated Initializer
-(id) initWithTotalScore:(int) scoreValue
                withSize:(CGSize)size;


@end
