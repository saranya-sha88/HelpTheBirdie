//
//  HelpScene2.m
//  HelpTheBirdie
//
//  Created by Pavana on 6/3/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import "HelpScene2.h"
#import "MenuScene.h"
#import "HelpScene.h"

@implementation HelpScene2

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
        
        
        [self addLabelWithX:112
                   andWithY:370
                andWithText:@"6. These are the obstacles:"];
        
        
        SKSpriteNode *balloonNode = [[SKSpriteNode alloc] initWithImageNamed:@"baloon"];
        balloonNode.position = CGPointMake(230,370);
        [balloonNode setScale:0.1];
        [self addChild:balloonNode];
        
        SKSpriteNode *kiteNode = [[SKSpriteNode alloc] initWithImageNamed:@"kite1"];
        kiteNode.position = CGPointMake(255,370);
        [kiteNode setScale:0.5];
        [self addChild:kiteNode];
        
        SKSpriteNode *flyNode = [[SKSpriteNode alloc] initWithImageNamed:@"flyUp"];
        flyNode.position = CGPointMake(280,370);
        [flyNode setScale:0.3];
        [self addChild:flyNode];
        
        SKSpriteNode *ballNode = [[SKSpriteNode alloc] initWithImageNamed:@"ballx"];
        ballNode.position = CGPointMake(300,370);
        [ballNode setScale:0.09];
        [self addChild:ballNode];
        
        
        [self addLabelWithX:150
                   andWithY:320
                andWithText:@"7. Obtain 'Shield' power by collecting"];
        
        [self addLabelWithX:50
                   andWithY:300
                andWithText:@"stars"];
        
        
        SKSpriteNode *starNode = [[SKSpriteNode alloc] initWithImageNamed:@"star"];
        starNode.position = CGPointMake(85,305);
        [starNode setScale:1];
        [self addChild:starNode];
                
        [self addLabelWithX:140
                   andWithY:250
                andWithText:@"8. As the level increases,the game"];
        
        [self addLabelWithX:90
                   andWithY:230
                andWithText:@"becomes harder"];
        
        [self addChild:instructionsNode];
        
        SKLabelNode* menuLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
        menuLabel.position = CGPointMake(50,60);
        menuLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        menuLabel.text = @"Menu";
        menuLabel.name = @"menuButton";
        [self addChild:menuLabel];
        
        SKLabelNode* backLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
        backLabel.position = CGPointMake(280,60);
        backLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        backLabel.text = @"Back";
        backLabel.name = @"backButton";
        [self addChild:backLabel];
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
    
    if ([node.name isEqualToString:@"menuButton"]) {
        SKTransition *sceneTransition = [SKTransition flipHorizontalWithDuration:0.5];
        MenuScene *scene = [MenuScene sceneWithSize:self.view.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: sceneTransition];
    }
    
    if ([node.name isEqualToString:@"backButton"]) {
        SKTransition *sceneTransition = [SKTransition flipHorizontalWithDuration:0.5];
        HelpScene *scene = [HelpScene sceneWithSize:self.view.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: sceneTransition];
    }
}

@end

