//
//  Score.h
//  HelpTheBirdie
//
//  Created by Pavana on 5/11/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Score : NSObject

@property SKLabelNode* score;

- (void) setScorePositionWithFrameHeight:(CGFloat) frameHeight
                               andFrame:(CGRect) frameRect;
- (void) setScoreText:(int) scoreValue;

@end
