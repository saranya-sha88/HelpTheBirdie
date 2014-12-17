//
//  MyScene.h
//  HelpTheBirdie
//

//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>
#import "GameOverScene.h"
#import "Obstacle.h"
#import "Score.h"
#import "BackgroundSound.h"

@interface GameScene : SKScene <SKPhysicsContactDelegate>
{
    int currentLevelScore;
    SKSpriteNode *bird;
    SKSpriteNode *apple;
    SKSpriteNode *star;
    SKSpriteNode *balloon;
    SKSpriteNode *backgroundNode;
    SKSpriteNode *clonedBackgroundNode;
    SKSpriteNode *balloonObstacle;
    SKSpriteNode *kiteObstacle;
    SKSpriteNode *flyObstacle;
    SKSpriteNode *ballObstacle;
    CGFloat frameWidth;
    CGFloat frameHeight;
    CGRect frameRect;
    SKLabelNode *score;
    NSTimeInterval lastAppleSpawnTimeInterval;
    NSTimeInterval timeOfPrevUpdate;
    SKSpriteNode *backGroundNodeVal;
    Obstacle *obstacle;
    NSString *level;
    NSNumber *highScore;
    NSMutableArray *highScoreArray;
    GameOverScene *gameOverScene;
    Score *scoreObj;
    int appleCount;
    BOOL isShieldOn;
    NSTimer* timer;
}

@property (strong) CMMotionManager *motionManager;

+ (NSString*) startedLevel;
+ (void) setIsStartedLevelHasValue:(BOOL) isStartedLevelSet;
// Designated initializer.
-(id)initWithSize:(CGSize)size
         andLevel:(NSString*)currentLevel;

@end
