//
//  LevelSelectionScene.m
//  HelpTheBirdie
//
//  Created by Pavana on 5/17/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import "LevelSelectionScene.h"
#import "GameStartScene.h"
#import "MenuScene.h"
#import "GameScene.h"

@implementation LevelSelectionScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
    
        SKLabelNode* title = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
        title.position = CGPointMake(160,420);
        title.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        title.text = @"Select Level";
        [self addChild:title];
        
        SKLabelNode* easyLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        easyLabel.position = CGPointMake(160,370);
        easyLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        easyLabel.fontSize = 20;
        easyLabel.text = @"Easy";
        easyLabel.name = @"easyLevelButton";
        [self addChild:easyLabel];
        
        SKLabelNode* mediumLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        mediumLabel.position = CGPointMake(160,320);
        mediumLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        mediumLabel.fontSize = 20;
        mediumLabel.text = @"Medium";
        mediumLabel.name = @"mediumLevelButton";
        [self addChild:mediumLabel];
        
        SKLabelNode* hardLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        hardLabel.position = CGPointMake(160,270);
        hardLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        hardLabel.fontSize = 20;
        hardLabel.text = @"Hard";
        hardLabel.name = @"hardLevelButton";
        [self addChild:hardLabel];
        
        SKLabelNode* backLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
        backLabel.position = CGPointMake(160,180);
        backLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        backLabel.text = @"Back";
        backLabel.name = @"backButton";
        [self addChild:backLabel];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    SKTransition *sceneTransition = [SKTransition flipHorizontalWithDuration:0.5];
    
    [GameScene setIsStartedLevelHasValue:NO];
    
    if ([node.name isEqualToString:@"easyLevelButton"]) {
        GameStartScene *scene = [[GameStartScene alloc ]initWithSize:self.view.bounds.size
                                                            andLevel:@"Easy"];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: sceneTransition];
    }
    
    if ([node.name isEqualToString:@"mediumLevelButton"]) {
        GameStartScene *scene = [[GameStartScene alloc ]initWithSize:self.view.bounds.size
                                                            andLevel:@"Medium"];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: sceneTransition];
    }
    
    if ([node.name isEqualToString:@"hardLevelButton"]) {
        GameStartScene *scene = [[GameStartScene alloc ]initWithSize:self.view.bounds.size
                                                            andLevel:@"Hard"];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: sceneTransition];
    }
    
    if ([node.name isEqualToString:@"backButton"]) {
        MenuScene * scene = [MenuScene sceneWithSize:self.view.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: sceneTransition];
    }
    
}

@end
