//
//  ClearedLevelScene.m
//  HelpTheBirdie
//
//  Created by saranyashanmugam on 5/16/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import "ClearedLevelScene.h"
#import "GameStartScene.h"
#import "MenuScene.h"
#import "ViewController.h"

@implementation ClearedLevelScene

// Designated initializer with size and level.
-(id)initWithSize:(CGSize)size
         andLevel:(NSString*)currentLevel
{
    if (self = [super initWithSize:size]) {
        
        if(isMusicOn)
        {
            [bgSoundObject playBgSound];
        }
        else
        {
            [bgSoundObject stopBgSound];
        }
        
        level = currentLevel;
        NSString* clearedLevel;
        
        if([level isEqualToString:@"Medium"])
        {
            clearedLevel = @"Easy";
        }else if ([level isEqualToString:@"Hard"])
        {
           clearedLevel = @"Medium";
        }

        SKLabelNode* wonMsgLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
        wonMsgLabel.position = CGPointMake(160,350);
        wonMsgLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        wonMsgLabel.fontSize = 20;
        wonMsgLabel.text = [NSString stringWithFormat:@"Yay! You cleared %@ level!!",clearedLevel];
        [self addChild:wonMsgLabel];
        
        SKLabelNode* playLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
        playLabel.position = CGPointMake(160,200);
        playLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
        playLabel.text = @"Play";
        playLabel.name = @"playButton";
        [self addChild:playLabel];

    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"playButton"]) {
        SKTransition *screenTransition = [SKTransition flipHorizontalWithDuration:0.5];
         GameStartScene *scene = [[GameStartScene alloc ]initWithSize:self.view.bounds.size
                                                             andLevel:level];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: screenTransition];
    }
}

@end
