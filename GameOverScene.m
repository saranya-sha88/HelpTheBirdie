//
//  GameOverScene.m
//  HelpTheBirdie
//
//  Created by saranyashanmugam on 5/14/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import "GameOverScene.h"
#import "MenuScene.h"
#import "GameStartScene.h"
#import "GameScene.h"
#import "ViewController.h"

@implementation GameOverScene

int totalScore;

int highScoreEasy, highScoreMedium, highScoreHard;

// Designated Initializer with total score and size.
-(id) initWithTotalScore:(int) scoreValue
                withSize:(CGSize)size
{
    if(self = [super initWithSize:size])
    {
        
        if(isMusicOn)
        {
            [bgSoundObject playBgSound];
        }
        else
        {
            [bgSoundObject stopBgSound];
        }
        
        totalScore = scoreValue;
        [self addChildNode];
    }
    
    return self;
}

// Adds score details.
-(void) addChildNode
{
    SKLabelNode* title = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
    title.position = CGPointMake(160,420);
    title.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
    title.text = @"Game Over";
    [self addChild:title];
    
    SKLabelNode* totalScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
    totalScoreLabel.position = CGPointMake(160,350);
    totalScoreLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    totalScoreLabel.text = @"Your Score";
    totalScoreLabel.fontSize = 28;
    [self addChild:totalScoreLabel];
    
    SKLabelNode* totalScoreValueLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
    totalScoreValueLabel.position = CGPointMake(160,300);
    totalScoreValueLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    totalScoreValueLabel.fontSize = 22;
    totalScoreValueLabel.text = [NSString stringWithFormat:@"%d",totalScore];
    [self addChild:totalScoreValueLabel];
    
    [self getHighScoreFromFile];

    SKLabelNode* highScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
    highScoreLabel.position = CGPointMake(160,250);
    highScoreLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    highScoreLabel.text = @"High Score";
    highScoreLabel.fontSize = 28;
    [self addChild:highScoreLabel];
    
    SKLabelNode* easyScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
    easyScoreLabel.position = CGPointMake(160,190);
    easyScoreLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    easyScoreLabel.fontSize = 22;
    easyScoreLabel.text = [NSString stringWithFormat:@"Easy: %d",highScoreEasy];
    [self addChild:easyScoreLabel];
    
    SKLabelNode* mediumScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
    mediumScoreLabel.position = CGPointMake(160,140);
    mediumScoreLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    mediumScoreLabel.fontSize = 22;
    mediumScoreLabel.text = [NSString stringWithFormat:@"Medium: %d",highScoreMedium];
    [self addChild:mediumScoreLabel];
    
    SKLabelNode* hardScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
    hardScoreLabel.position = CGPointMake(160,90);
    hardScoreLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    hardScoreLabel.text = [NSString stringWithFormat:@"Hard: %d",highScoreHard];
    hardScoreLabel.fontSize = 22;
    [self addChild:hardScoreLabel];
    
    SKLabelNode* backLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
    backLabel.position = CGPointMake(40,40);
    backLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    backLabel.text = @"Menu";
    backLabel.name = @"backButton";
    [self addChild:backLabel];
    
    SKLabelNode* restart = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
    restart.position = CGPointMake(270,40);
    restart.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    restart.text = @"Restart";
    restart.name = @"Restart";
    [self addChild:restart];
    
    
}

// Fetches score of each level from plist.
-(void) getHighScoreFromFile
{
    NSString *filename = [self savedHighScoreFilename];
        
        
    NSMutableArray* highScoreArray = [[NSMutableArray alloc] initWithContentsOfFile:filename];
    
    highScoreEasy = [[highScoreArray objectAtIndex:0] integerValue];
    highScoreMedium = [[highScoreArray objectAtIndex:1] integerValue];
    highScoreHard = [[highScoreArray objectAtIndex:2] integerValue];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSString *level;
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"backButton"]) {
        SKTransition *sceneTransition = [SKTransition flipHorizontalWithDuration:0.5];
        MenuScene * scene = [MenuScene sceneWithSize:self.view.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: sceneTransition];
    }else if([node.name isEqualToString:@"Restart"]){
        SKTransition *sceneTransition = [SKTransition flipHorizontalWithDuration:0.5];
        level = [GameScene startedLevel];
        [GameScene setIsStartedLevelHasValue:NO];
        GameStartScene *scene = [[GameStartScene alloc] initWithSize:self.view.bounds.size
                                                            andLevel:level];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: sceneTransition];
    }

}

// Fetches the plist filename.
- (NSString *) savedHighScoreFilename
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filename = [documentsDirectory stringByAppendingPathComponent: @"HighScore.plist"];
    return filename;
}

@end
