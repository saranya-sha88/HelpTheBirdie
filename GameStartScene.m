//
//  GameStartScene.m
//  HelpTheBirdie
//
//  Created by Pavana on 5/11/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import "GameStartScene.h"
#import "Bird.h"
#import "GameScene.h"

@implementation GameStartScene

NSString *level;

// Designated initializer with size and level.
-(id)initWithSize:(CGSize)size
         andLevel:(NSString*)currentLevel
{
    
    if (self = [super initWithSize:size]) {
        
        level = currentLevel;
        frameWidth = self.frame.size.width;
        frameHeight = self.frame.size.height;
        frameRect = self.frame;
        
        Bird* birdObj = [[Bird alloc] init];
        bird = [birdObj bird];
        [birdObj setBirdPositionWithFrameWidth:frameWidth
                                      andFrame:frameRect];
        bird.physicsBody.dynamic = NO;
        [self addChild:bird];
        
        [self addStartLabel];
    }
    return self;
}

- (void) addStartLabel
{
    SKLabelNode* startLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
    startLabel.position = CGPointMake(160,350);
    startLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
    startLabel.fontSize = 20;
    startLabel.text = @"Tap to start!";
    [self addChild:startLabel];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    GameScene * scene = [[GameScene alloc ]initWithSize:self.view.bounds.size
                                               andLevel:level];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [self.view presentScene:scene];
}

@end
