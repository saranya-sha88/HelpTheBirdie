//
//  MenuScene.m
//  HelpTheBirdie
//
//  Created by Pavana on 5/11/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import "MenuScene.h"
#import "GameStartScene.h"
#import "HelpScene.h"
#import "HighScoreScene.h"
#import "LevelSelectionScene.h"
#import "GameScene.h"
#import "BackgroundSound.h"
#import "ViewController.h"

@implementation MenuScene

BOOL isMusicOn = YES;
BOOL isPlayModeTap = YES;

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        BOOL isBgSoundPlaying = bgSoundObject.isBgSoundPlaying;
        
        if(!isBgSoundPlaying)
        {
            if(isMusicOn)
            {
                [bgSoundObject playBgSound];
            }
            else
            {
                [bgSoundObject stopBgSound];
            }
        }
        [self addTitle];
        [self addMenuLabels];
    }
    return self;
}

// Adds game title.
- (void) addTitle
{
    SKLabelNode* gameTitle = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
    gameTitle.position = CGPointMake(160,420);
   // gameTitle.fontSize = 12;
    gameTitle.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
    gameTitle.text = @"Help The Birdie!";
    [self addChild:gameTitle];
}

// Adds menu items.
- (void) addMenuLabels
{
    SKLabelNode* playLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
    playLabel.position = CGPointMake(160,350);
    playLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    playLabel.text = @"Play";
    playLabel.name = @"playButton";
    [self addChild:playLabel];
    
    SKLabelNode* helpLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
    helpLabel.position = CGPointMake(160,290);
    helpLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    helpLabel.text = @"Help";
    helpLabel.name = @"helpButton";
    [self addChild:helpLabel];
    
    SKLabelNode* highScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
    highScoreLabel.position = CGPointMake(160,230);
    highScoreLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    highScoreLabel.text = @"High Score";
    highScoreLabel.name = @"highScoreButton";
    [self addChild:highScoreLabel];
    
    SKLabelNode* levelLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
    levelLabel.position = CGPointMake(160,180);
    levelLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    levelLabel.text = @"Level";
    levelLabel.name = @"levelButton";
    [self addChild:levelLabel];
    
    if(isPlayModeTap)
    {
        SKLabelNode* playModeLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
        playModeLabel.position = CGPointMake(160,130);
        playModeLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        playModeLabel.text = @"Play Mode - Tilt";
        playModeLabel.name = @"playModeTilt";
        [self addChild:playModeLabel];
        
    }else{
        
        SKLabelNode* playModeLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
        playModeLabel.position = CGPointMake(160,130);
        playModeLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        playModeLabel.text = @"Play Mode - Tap";
        playModeLabel.name = @"playModeTap";
        [self addChild:playModeLabel];
    }
    
    if(isMusicOn)
    {
        SKLabelNode* musicOffLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
        musicOffLabel.position = CGPointMake(160,80);
        musicOffLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        musicOffLabel.text = @"Music Off";
        musicOffLabel.name = @"musicOffButton";
        [self addChild:musicOffLabel];
    }
    else
    {
        SKLabelNode* musicOnLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
        musicOnLabel.position = CGPointMake(160,80);
        musicOnLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        musicOnLabel.text = @"Music On";
        musicOnLabel.name = @"musicOnButton";
        [self addChild:musicOnLabel];
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    SKTransition *sceneTransition = [SKTransition flipHorizontalWithDuration:0.5];
    
    if ([node.name isEqualToString:@"playButton"]) {
        [GameScene setIsStartedLevelHasValue:NO];
        GameStartScene *scene = [[GameStartScene alloc ]initWithSize:self.view.bounds.size
                                                            andLevel:@"Easy"];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: sceneTransition];
    }
    
    if ([node.name isEqualToString:@"helpButton"]) {
        HelpScene *scene = [[HelpScene alloc]initWithSize:self.view.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: sceneTransition];
    }
    
    if ([node.name isEqualToString:@"highScoreButton"]) {
        HighScoreScene *scene = [[HighScoreScene alloc] initWithSize:self.view.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: sceneTransition];
    }
    
    if ([node.name isEqualToString:@"levelButton"]) {
        LevelSelectionScene *scene = [[LevelSelectionScene alloc] initWithSize:self.view.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: sceneTransition];
    }
    
    if ([node.name isEqualToString:@"musicOnButton"]) {
        [node removeFromParent];
        
        isMusicOn = YES;
        
        [bgSoundObject playBgSound];
        
        SKLabelNode* musicOffLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
        musicOffLabel.position = CGPointMake(160,80);
        musicOffLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        musicOffLabel.text = @"Music Off";
        musicOffLabel.name = @"musicOffButton";
        [self addChild:musicOffLabel];
    }
    
    if ([node.name isEqualToString:@"musicOffButton"]) {
        [node removeFromParent];
        
        isMusicOn = NO;
        
        [bgSoundObject stopBgSound];
        
        SKLabelNode* musicOnLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
        musicOnLabel.position = CGPointMake(160,80);
        musicOnLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        musicOnLabel.text = @"Music On";
        musicOnLabel.name = @"musicOnButton";
        [self addChild:musicOnLabel];
    }
    
    
    if ([node.name isEqualToString:@"playModeTap"]) {
        [node removeFromParent];
        
        isPlayModeTap = YES;
        
        SKLabelNode* playMode = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
        playMode.position = CGPointMake(160,130);
        playMode.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        playMode.text = @"Play Mode - Tilt";
        playMode.name = @"playModeTilt";
        [self addChild:playMode];

    }
    
    if ([node.name isEqualToString:@"playModeTilt"]) {
        [node removeFromParent];
        
        isPlayModeTap = NO;
        
        SKLabelNode* playMode = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
        playMode.position = CGPointMake(160,130);
        playMode.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        playMode.text = @"Play Mode - Tap";
        playMode.name = @"playModeTap";
        [self addChild:playMode];
    }
}

@end
