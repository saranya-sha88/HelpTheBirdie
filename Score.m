//
//  Score.m
//  HelpTheBirdie
//
//  Created by Pavana on 5/11/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import "Score.h"

@implementation Score

@synthesize score;

- (id) init
{
    if(self = [super init])
    {
        self.score = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        self.score.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    }
    return self;
}

// Sets the score position.
- (void) setScorePositionWithFrameHeight:(CGFloat) frameHeight
                               andFrame:(CGRect) frameRect
{
    self.score.position = CGPointMake( CGRectGetMidX(frameRect), 3 * frameHeight/4 );
}

// Sets the score value text.
- (void) setScoreText:(int) scoreValue
{
    self.score.text = [NSString stringWithFormat:@"%d", scoreValue];
}

@end
