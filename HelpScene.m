//
//  HelpScene.m
//  HelpTheBirdie
//
//  Created by Pavana on 5/12/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import "HelpScene.h"
#import "MenuScene.h"
#import "GameScene.h"
#import "HelpScene2.h"

@implementation HelpScene

SKNode* instructionsNode;

- (id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        SKLabelNode *helpLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
        helpLabel.position = CGPointMake(160,420);
        helpLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
        helpLabel.text = @"Help";
        [self addChild:helpLabel];
        
        instructionsNode = [SKNode node];
        
        
        [self addLabelWithX:163
                   andWithY:370
                andWithText:@"1. Start by tapping on the “Play” button"];
        
        [self addLabelWithX:140
                   andWithY:320
                andWithText:@"2. Tap/Tilt to keep the bird flying"];
        
        [self addLabelWithX:150
                   andWithY:270
                andWithText:@"3. Collect as many apples as possible"];
        
        [self addLabelWithX:135
                   andWithY:250
                andWithText:@"without hitting any obstacle"];
        
        [self addLabelWithX:123
                   andWithY:200
                andWithText:@"4. Number of apples collected"];
        
        [self addLabelWithX:100
                   andWithY:180
                andWithText:@"decides the score"];
        
        [self addLabelWithX:130
                   andWithY:130
                andWithText:@"5. If bird touches any obstacle,"];
        
        [self addLabelWithX:96
                   andWithY:110
                andWithText:@"the game is over"];
        
        
        [self addChild:instructionsNode];
        
        SKLabelNode* menuLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
        menuLabel.position = CGPointMake(50,60);
        menuLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        menuLabel.text = @"Menu";
        menuLabel.name = @"menuButton";
        [self addChild:menuLabel];
        
        SKLabelNode* nextLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
        nextLabel.position = CGPointMake(280,60);
        nextLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        nextLabel.text = @"Next";
        nextLabel.name = @"nextButton";
        [self addChild:nextLabel];
    }
    return self;
}

// Adds label at specific position with specific text.
-(void) addLabelWithX:(CGFloat) x
             andWithY:(CGFloat) y
          andWithText:(NSString*) text
{
    SKLabelNode* instructionsLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
    instructionsLabel.position = CGPointMake(x,y);
    instructionsLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    instructionsLabel.fontSize = 16;
    instructionsLabel.text = text;
    [instructionsNode addChild:instructionsLabel];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    [GameScene setIsStartedLevelHasValue:NO];
    
    if ([node.name isEqualToString:@"menuButton"]) {
        SKTransition *sceneTransition = [SKTransition flipHorizontalWithDuration:0.5];
        MenuScene * scene = [MenuScene sceneWithSize:self.view.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: sceneTransition];
    }
    
    if ([node.name isEqualToString:@"nextButton"]) {
        SKTransition *sceneTransition = [SKTransition flipHorizontalWithDuration:0.5];
        HelpScene2 *scene = [HelpScene2 sceneWithSize:self.view.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: sceneTransition];
    }
}

@end
