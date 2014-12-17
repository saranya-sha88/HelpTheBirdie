//
//  HighScoreScene.m
//  HelpTheBirdie
//
//  Created by Pavana on 5/14/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import "HighScoreScene.h"
#import "MenuScene.h"
#import "GameScene.h"

@implementation HighScoreScene

int highScoreEasy, highScoreMedium, highScoreHard;

- (id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        
        [self getSavedHighScoreFromFile];

        
        SKLabelNode* highScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
        highScoreLabel.position = CGPointMake(160,420);
        highScoreLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
        highScoreLabel.text = @"High Score";
        highScoreLabel.fontSize = 28;
        [self addChild:highScoreLabel];
        
        SKLabelNode* easyScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        easyScoreLabel.position = CGPointMake(160,360);
        easyScoreLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        easyScoreLabel.fontSize = 22;
        easyScoreLabel.text = [NSString stringWithFormat:@"Easy: %d",highScoreEasy];
        [self addChild:easyScoreLabel];
        
        SKLabelNode* mediumScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        mediumScoreLabel.position = CGPointMake(160,300);
        mediumScoreLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        mediumScoreLabel.fontSize = 22;
        mediumScoreLabel.text = [NSString stringWithFormat:@"Medium: %d",highScoreMedium];
        [self addChild:mediumScoreLabel];
        
        SKLabelNode* hardScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        hardScoreLabel.position = CGPointMake(160,240);
        hardScoreLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        hardScoreLabel.text = [NSString stringWithFormat:@"Hard: %d",highScoreHard];
        hardScoreLabel.fontSize = 22;
        [self addChild:hardScoreLabel];
        
        
        SKLabelNode* backLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
        backLabel.position = CGPointMake(160,180);
        backLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        backLabel.text = @"Back";
        backLabel.name = @"backButton";
        [self addChild:backLabel];
    }
    return self;
}

// Fetches the high scores for each level from plist.
- (void) getSavedHighScoreFromFile
{
    NSString *filename = [self savedHighScoreFilename];
   
        NSMutableArray* highScoreArray = [[NSMutableArray alloc] initWithContentsOfFile:filename];
    
        highScoreEasy = [[highScoreArray objectAtIndex:0] integerValue];
        highScoreMedium = [[highScoreArray objectAtIndex:1] integerValue];
        highScoreHard = [[highScoreArray objectAtIndex:2] integerValue];
}

// Fetches the plist name.
- (NSString *) savedHighScoreFilename
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filename = [documentsDirectory stringByAppendingPathComponent: @"HighScore.plist"];
    return filename;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    [GameScene setIsStartedLevelHasValue:NO];
    
    if ([node.name isEqualToString:@"backButton"]) {
        SKTransition *sceneTransition = [SKTransition flipHorizontalWithDuration:0.5];
        MenuScene * scene = [MenuScene sceneWithSize:self.view.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: sceneTransition];
    }
}

@end
