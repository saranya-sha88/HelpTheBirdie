//
//  MyScene.m
//  HelpTheBirdie
//
//  Created by Pavana on 5/7/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import "GameScene.h"
#import "Background.h"
#import "Bird.h"
#import "Apple.h"
#import "BalloonObstacle.h"
#import "ClearedLevelScene.h"
#import "MenuScene.h"
#import "ViewController.h"



@implementation GameScene

static const uint32_t birdCategory = 1 << 0;
static const uint32_t appleCategory = 1 << 1;
static const uint32_t obstacleCategory = 1 << 2;
static const uint32_t topBorderCategory = 1 << 3;
static const uint32_t bottomBorderCategory = 1 << 4;
static const uint32_t shieldCategory = 1 << 5;
static const int easyThreshold = 8,mediumThreshold = 10;
static int totalScore=0;
static NSString* startedLevel;
static BOOL isStartedLevelHasValue = NO;

@synthesize motionManager;

// Designated initializer with size and level.
-(id)initWithSize:(CGSize)size
         andLevel:(NSString*)currentLevel
{
    if (self = [super initWithSize:size]) {
        
        /* Setup your scene here */
        [bgSoundObject stopBgSound];
        self.physicsWorld.gravity = CGVectorMake( 0.0, -3.0 );
        self.physicsWorld.contactDelegate = self;
        self.physicsBody.restitution = 0.0;
        level = currentLevel;
        
        //Setting the started level for restart functionality.
        if(!isStartedLevelHasValue)
        {
            startedLevel = currentLevel;
            isStartedLevelHasValue = YES;
        }
        
        
        frameWidth = self.frame.size.width;
        frameHeight = self.frame.size.height;
        frameRect = self.frame;
        
        // Bird creation
        Bird* birdObj = [[Bird alloc] init];
        bird = [birdObj bird];
        [birdObj setBirdPositionWithFrameWidth:frameWidth
                                      andFrame:frameRect];
        
        bird.physicsBody.categoryBitMask = birdCategory;
        bird.physicsBody.collisionBitMask = topBorderCategory | bottomBorderCategory;
        bird.physicsBody.contactTestBitMask = appleCategory | obstacleCategory | bottomBorderCategory | shieldCategory;
        
        [self addChild:bird];
        
        // Score object creation.
        scoreObj = [[Score alloc] init];
        score = [scoreObj score];
        [scoreObj setScorePositionWithFrameHeight:frameHeight
                                         andFrame:frameRect];
        [scoreObj setScoreText:totalScore];
        [self addChild:score];
        
        // Background creation.
        Background *backGround = [[Background alloc]init];
        
        [backGround getBackGroundNode];
        
        for (backGroundNodeVal in backGround.backGroundNodes) {
            [self addChild:backGroundNodeVal];
        }
        backgroundNode = [backGround.backGroundNodes objectAtIndex:0];
        clonedBackgroundNode =[backGround.backGroundNodes objectAtIndex:1];
        
        
        // Spawns obstacles.
        if([level isEqualToString:@"Easy"])
        {
          [self spawnObstacles:8.0];
        }else 
        {
          [self spawnObstacles:6.0];
        }
        
          [self spawnFlyObstacle];
        
        if([level isEqualToString:@"Hard"])
        {
            [self spawnBallObstacle];
        }
         
       
       // Creates a barrier on top to restrict the bird flying off screen above.
        SKNode* topNode = [SKNode node];
        topNode.position = CGPointMake(0,frameHeight);
        topNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(frameWidth,0.1)];
        topNode.physicsBody.dynamic = NO;
        topNode.physicsBody.categoryBitMask = topBorderCategory;
        [self addChild:topNode];
        
        // Creates a barrier at the bottom to restrict the bird flying off screen below.
        SKNode* bottomNode = [SKNode node];
        bottomNode.position = CGPointMake(0,0);
        bottomNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(frameWidth,0.1)];
        bottomNode.physicsBody.dynamic = NO;
        bottomNode.physicsBody.categoryBitMask = bottomBorderCategory;
        [self addChild:bottomNode];
        
         // Adds level label and displays current level.
        SKLabelNode* levelLabel = [SKLabelNode labelNodeWithFontNamed:@"Cochin-BoldItalic"];
        levelLabel.fontColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        levelLabel.position = CGPointMake( CGRectGetMidX(frameRect), frameHeight/2 * 1.8);
        levelLabel.text = level;
        [self addChild:levelLabel];
        
        if(!isPlayModeTap)
        {
            self.motionManager = [[CMMotionManager alloc] init];
            [self.motionManager startAccelerometerUpdates];
        }

        // Initializes plist.
        highScoreArray = [[NSMutableArray alloc] init];
        [self initializePlist];
    }
    return self;
}

// Getter for startedLevel.
+ (NSString*) startedLevel
{
    return startedLevel;
}

// Sets a variable to indicate that the started level value is set properly. 
+ (void) setIsStartedLevelHasValue:(BOOL) isStartedLevelSet
{
    isStartedLevelHasValue = isStartedLevelSet;
}

// Initialises plist with default high score values for each level.
-(void)initializePlist
{
    NSString *filename = [self savedHighScoreFilename];

    if (! [[NSFileManager defaultManager] fileExistsAtPath:filename])
    {
        [highScoreArray insertObject:[NSNumber numberWithInt:0] atIndex:0];
        [highScoreArray insertObject:[NSNumber numberWithInt:0] atIndex:1];
        [highScoreArray insertObject:[NSNumber numberWithInt:0] atIndex:2];
        [highScoreArray writeToFile:filename atomically:YES];
      
    }
}

// Spawns balloons and kites randomly at a particular interval.
-(void) spawnObstacles:(NSTimeInterval)delayTime
{
    SKAction* spawnBalloon = [SKAction performSelector:@selector(addBalloonObstacle) onTarget:self];
    SKAction* delay = [SKAction waitForDuration:delayTime];
    SKAction* spawnThenDelay = [SKAction sequence:@[spawnBalloon, delay]];
    SKAction* spawnThenDelayForever = [SKAction repeatActionForever:spawnThenDelay];
    [self runAction:spawnThenDelayForever];
    
    SKAction* spawnKite = [SKAction performSelector:@selector(addKiteObstacle) onTarget:self];
    SKAction* kiteDelay = [SKAction waitForDuration:2.0];
    SKAction* kiteSpawnThenDelay = [SKAction sequence:@[spawnKite, kiteDelay]];
    SKAction* kiteSpawnpawnThenDelayForever = [SKAction repeatActionForever:kiteSpawnThenDelay];
    [self runAction:kiteSpawnpawnThenDelayForever];
}

// Spawns flies randomly at a particular interval.
-(void) spawnFlyObstacle
{
    SKAction* spawnFlies = [SKAction performSelector:@selector(addFliesObstacle) onTarget:self];
    SKAction* delay = [SKAction waitForDuration:[self setDelayForFlies]];
    SKAction* spawnThenDelay = [SKAction sequence:@[spawnFlies, delay]];
    SKAction* spawnThenDelayForever = [SKAction repeatActionForever:spawnThenDelay];
    [self runAction:spawnThenDelayForever];
 
}

//Spawns ball obstacle
-(void) spawnBallObstacle
{
    SKAction* spawnBall = [SKAction performSelector:@selector(addBallObstacle) onTarget:self];
    SKAction* ballDelay = [SKAction waitForDuration:5.0];
    SKAction* ballSpawnThenDelay = [SKAction sequence:@[spawnBall, ballDelay]];
    SKAction* ballSpawnpawnThenDelayForever = [SKAction repeatActionForever:ballSpawnThenDelay];
    [self runAction:ballSpawnpawnThenDelayForever];
}

// Sets delay for spawning flies depending on the level.
-(NSTimeInterval) setDelayForFlies
{
    NSTimeInterval delay;
    
    if([level isEqualToString:@"Easy"])
    {
        delay = 4;
        
    }else if([level isEqualToString:@"Medium"])
    {
        delay = 2;
        
    }else if([level isEqualToString:@"Hard"])
    {
        delay = 0.5;
    }
    return delay;
}

// Sets the speed of the obstacles according to each level.
-(NSTimeInterval) setSpeedForObstacles
{
    NSTimeInterval duration;
    
    if([level isEqualToString:@"Easy"])
    {
        duration = 0.08;

    }else if([level isEqualToString:@"Medium"])
    {
        duration = 0.05;

    }else if([level isEqualToString:@"Hard"])
    {
        duration = 0.03;

    }
    return duration;
}

// Adds kites to the scene.
-(void)addKiteObstacle
{
    obstacle = [[Obstacle alloc] initWithDuration:[self setSpeedForObstacles]];
    kiteObstacle = [obstacle addKiteObstacle:self.frame];
    kiteObstacle.physicsBody.categoryBitMask = obstacleCategory;
    kiteObstacle.physicsBody.collisionBitMask = birdCategory;
    kiteObstacle.physicsBody.contactTestBitMask = birdCategory;
    [self addChild:kiteObstacle];
}

// Adds balloons to the scene.
-(void) addBalloonObstacle
{
    obstacle = [[Obstacle alloc] initWithDuration:[self setSpeedForObstacles]];
    balloonObstacle = [obstacle  addBalloonObstacle:self.frame];
    balloonObstacle .physicsBody.categoryBitMask = obstacleCategory;
    balloonObstacle .physicsBody.collisionBitMask = birdCategory;
    balloonObstacle .physicsBody.contactTestBitMask = birdCategory;
    [self addChild:balloonObstacle];
    
}

// Adds flies to the scene.
-(void) addFliesObstacle
{
    obstacle = [[Obstacle alloc] initWithDuration:[self setSpeedForObstacles]];
    flyObstacle = [obstacle  addFliesObstacle:self.frame];
    flyObstacle .physicsBody.categoryBitMask = obstacleCategory;
    flyObstacle .physicsBody.collisionBitMask = birdCategory;
    flyObstacle .physicsBody.contactTestBitMask = birdCategory;
    [self addChild:flyObstacle];
}

//Adds balls to the scene
-(void) addBallObstacle
{
    obstacle = [[Obstacle alloc] initWithDuration:[self setSpeedForObstacles]];
    ballObstacle = [obstacle  addBallObstacle:self.frame];
    ballObstacle .physicsBody.categoryBitMask = obstacleCategory;
    ballObstacle .physicsBody.collisionBitMask = birdCategory;
    ballObstacle .physicsBody.contactTestBitMask = birdCategory;
    [self addChild:ballObstacle];
}

// Creates apples at a specific time interval.
- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLastUpdate
{
    lastAppleSpawnTimeInterval += timeSinceLastUpdate;

    if (lastAppleSpawnTimeInterval > 2.5) {
        appleCount ++;
        lastAppleSpawnTimeInterval = 0;
        Apple* appleObj = [[Apple alloc] initWithImage:@"apple3"];
        [appleObj setPositionWithFrameWidth:frameWidth
                             andFrameHeight:frameHeight
                              andBirdHeight:bird.size.height
                               andImageName:@"apple3"];
        apple = [appleObj power];
        apple.physicsBody.categoryBitMask = appleCategory;
        apple.physicsBody.contactTestBitMask = birdCategory;
        [self addChild:apple];
    }
    
    if (appleCount > 5 && !([timer isValid])) {
        appleCount = 0;
        Apple* starObj = [[Apple alloc] initWithImage:@"star"];
        [starObj setPositionWithFrameWidth:frameWidth
                             andFrameHeight:frameHeight
                              andBirdHeight:bird.size.height
                               andImageName:@"star"];
        star = [starObj power];
        star.physicsBody.categoryBitMask = shieldCategory;
        star.physicsBody.contactTestBitMask = birdCategory;
        [self addChild:star];
    }
    
}


// Bird is moved according to user acceleration.
-(void)processUserMotionForUpdate{
    
    CMAccelerometerData* data = self.motionManager.accelerometerData;
    
    //If the device is moved in upward direction
    if ((data.acceleration.y) > 0) {
        bird.physicsBody.velocity = CGVectorMake(0, 0);
        [bird.physicsBody applyImpulse:CGVectorMake(0,data.acceleration.y*4)];
        
    //If the device is moved in downward direction
    }else if ((data.acceleration.y) < -0.7) {
        bird.physicsBody.velocity = CGVectorMake(0, 0);
        [bird.physicsBody applyImpulse:CGVectorMake(0,data.acceleration.y*2)];
        
    //If the device is moved very slowly in any direction
    }else if(data.acceleration.y >= -0.7 && data.acceleration.y < -0.1)
    {
        bird.physicsBody.velocity = CGVectorMake(0, 0);
        [bird.physicsBody applyImpulse:CGVectorMake(0,data.acceleration.y*(-4))];
    }
}

-(void)update:(CFTimeInterval)currentTime  {
    /* Called before each frame is rendered */
    CFTimeInterval timeSinceLastUpdate = currentTime - timeOfPrevUpdate;
    timeOfPrevUpdate = currentTime;
    [self updateWithTimeSinceLastUpdate:timeSinceLastUpdate];
    
    if(!isPlayModeTap)
    {
        [self processUserMotionForUpdate];
    }
    
    SKSpriteNode *bg = backgroundNode;
    SKSpriteNode *cBg = clonedBackgroundNode;
    
    // Gives a moving illusion of the background.
    bg.position = CGPointMake(bg.position.x-4, bg.position.y);
    bg.zPosition = -20;
    cBg.position = CGPointMake(cBg.position.x-4, cBg.position.y);
    cBg.zPosition = -20;

    // Continious display of background.
    if (bg.position.x < -bg.size.width){
        bg.position = CGPointMake(cBg.position.x + cBg.size.width, bg.position.y);
    }
    
    if (cBg.position.x < -cBg.size.width) {
        cBg.position = CGPointMake(bg.position.x + bg.size.width, cBg.position.y);
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
     /*Called when a touch begins */
    if(isPlayModeTap)
    {
        if(isMusicOn)
        {
            [bgSoundObject playBirdJumpSound];
        }
        bird.physicsBody.velocity = CGVectorMake(0, 0);
        [bird.physicsBody applyImpulse:CGVectorMake(0, 12)];
    }
}

// Deletes created nodes when it moves off screen.
-(void) deleteNode: (NSString*)nodeName
{
    [self enumerateChildNodesWithName:nodeName usingBlock:^(SKNode *node,BOOL *stop){
        
        if([nodeName isEqualToString:@"flies"] || [nodeName isEqualToString:@"apple"] || [nodeName isEqualToString:@"ball"] || [nodeName isEqualToString:@"star"])
        {
            if(node.position.x < 0)
            {
                [node removeFromParent];
            }

        }else{
            
            if(node.position.y > self.frame.size.height)
            {
                [node removeFromParent];
            }
            
        }
        
    }];
}

-(void)didSimulatePhysics
{
 
    [self deleteNode:@"kite"];
    [self deleteNode:@"balloon"];
    [self deleteNode:@"flies"];
    [self deleteNode:@"apple"];
    [self deleteNode:@"ball"];
    [self deleteNode:@"star"];
}

-(void) didBeginContact:(SKPhysicsContact*)contact
{
    SKPhysicsBody *birdBody,*appleBody, *bottomBorder,*obstacleBody, *shieldBody;
    
    if((contact.bodyA.categoryBitMask & birdCategory) != 0)
    {
        birdBody = contact.bodyA;
    }
    else if((contact.bodyB.categoryBitMask & birdCategory) != 0)
    {
        birdBody = contact.bodyB;
    }
    
    if((contact.bodyA.categoryBitMask & appleCategory) != 0)
    {
        appleBody = contact.bodyA;
    }
    else if((contact.bodyB.categoryBitMask & appleCategory) != 0)
    {
        appleBody = contact.bodyB;
    }
    
    
    if((contact.bodyA.categoryBitMask & shieldCategory) != 0)
    {
        shieldBody = contact.bodyA;
    }
    else if((contact.bodyB.categoryBitMask & shieldCategory) != 0)
    {
        shieldBody = contact.bodyB;
    }
    
    if((contact.bodyA.categoryBitMask & bottomBorderCategory) != 0)
    {
        bottomBorder = contact.bodyA;
    }
    else if((contact.bodyB.categoryBitMask & bottomBorderCategory) != 0)
    {
        bottomBorder = contact.bodyB;
    }
    
    if((contact.bodyA.categoryBitMask & obstacleCategory) != 0)
    {
        obstacleBody = contact.bodyA;
    }else if((contact.bodyB.categoryBitMask & obstacleCategory) !=0)
    {
        obstacleBody = contact.bodyB;
    }
    
    if(birdBody != nil && obstacleBody != nil)
    {
       [self collisionOfObstacle];
    }
    
    if(birdBody != nil && appleBody != nil)
    {
       [self CollisionOfBirdAndAppleWithAppleNode:(SKSpriteNode*) appleBody.node];
    }
    
    if(birdBody != nil && bottomBorder != nil)
    {
      [self CollisionOfBirdAndBottom];
    }
    
    
    if(birdBody != nil && shieldBody != nil)
    {
        [self addShieldPower];
    }

}

// Bird gets the shield power for a few sec.
-(void) addShieldPower
{
    if(isMusicOn)
    {
        [bgSoundObject stopBirdJumpSound];
        [bgSoundObject playShieldSound];
    }
    isShieldOn = YES;
    [star removeFromParent];
    SKAction *blink = [SKAction sequence:@[[SKAction fadeOutWithDuration:0.1],
                                           [SKAction fadeInWithDuration:0.1]]];
    
    SKAction *blinkForTime = [SKAction repeatActionForever:blink ];
    [bird runAction:blinkForTime withKey:@"blinkAction"];
    timer = [NSTimer scheduledTimerWithTimeInterval: 20.0
                                             target: self
                                           selector:@selector(removeShieldPower)
                                           userInfo: nil
                                            repeats:NO];

}

// Removes bird's shield power.
-(void) removeShieldPower
{
    isShieldOn = NO;
    [timer invalidate];
    [bird removeActionForKey:@"blinkAction"];
    bird.alpha = 1.0;
}

// Method handling when bird collides with obstacles.
-(void) collisionOfObstacle
{
    if(!isShieldOn)
    {
        if(isMusicOn)
        {
            [bgSoundObject stopBirdJumpSound];
            [bgSoundObject playClashSound];
        }
        bird.physicsBody.velocity = CGVectorMake(-1, -1);
        [bird.physicsBody applyImpulse:CGVectorMake(0, -200)];
        [self updateHighScore];
        [self showGameOverScene];
    }
}

// Displays game over scene with score details.
-(void) showGameOverScene
{
    SKTransition *screenTransition = [SKTransition flipHorizontalWithDuration:0.5];
    gameOverScene = [[GameOverScene alloc]initWithTotalScore:totalScore
                                                    withSize:self.view.bounds.size];
    gameOverScene.scaleMode = SKSceneScaleModeAspectFill;
    totalScore = 0;
    if(!isPlayModeTap)
    {
        [self.motionManager stopAccelerometerUpdates];
    }
    [self.view presentScene:gameOverScene transition: screenTransition];
    
}

// Method handling when bird collides with apple.
-(void) CollisionOfBirdAndAppleWithAppleNode:(SKSpriteNode*) appleNode
{
    if(isMusicOn)
    {
        [bgSoundObject stopBirdJumpSound];
        [bgSoundObject playEatAppleSound];
    }
    currentLevelScore = currentLevelScore + 1;
    totalScore = totalScore + 1;
    [appleNode removeFromParent];
    [scoreObj setScoreText:totalScore];
    [self checkForLevelChange];
}

// Checks and updates the level depending on the current level score and threshold.
-(void) checkForLevelChange
{
    
    if([level isEqualToString:@"Easy"] && currentLevelScore >= easyThreshold)
    {
        [self displayClearedLevelSceneWithLevel:@"Medium"];
        
    }else if([level isEqualToString:@"Medium"] && currentLevelScore >= mediumThreshold)
    {
        [self displayClearedLevelSceneWithLevel:@"Hard"];

    }
}

// Displays the new scene when a level is cleared.
-(void) displayClearedLevelSceneWithLevel:(NSString*) changedLevel
{
    ClearedLevelScene *clearedLevelScene;
    [self updateHighScore];
    level = changedLevel;
    clearedLevelScene = [[ClearedLevelScene alloc]initWithSize:self.view.bounds.size
                                                      andLevel:level];
    SKTransition *screenTransition = [SKTransition flipHorizontalWithDuration:0.5];
    clearedLevelScene.scaleMode = SKSceneScaleModeAspectFill;
    if(!isPlayModeTap)
    {
        [self.motionManager stopAccelerometerUpdates];
    }
    [self.view presentScene:clearedLevelScene transition: screenTransition];
    
}

// Method handling when bird hits the bottom.
-(void) CollisionOfBirdAndBottom
{
    if(isMusicOn)
    {
        [bgSoundObject stopBirdJumpSound];
        [bgSoundObject playClashSound];
    }
    [self updateHighScore];
    [self showGameOverScene];
}

// updates high score in the plist if current score is greater than previous high score.
- (void) updateHighScore
{
    int prevHighScore = 0;
    NSString *filename = [self savedHighScoreFilename];
    
    highScoreArray = [[NSMutableArray alloc] initWithContentsOfFile:filename];
    
    if([level isEqualToString:@"Easy"])
    {
        prevHighScore = [[highScoreArray objectAtIndex:0] integerValue];
    } else if([level isEqualToString:@"Medium"])
    {
        prevHighScore = [[highScoreArray objectAtIndex:1] integerValue];
    }else if ([level isEqualToString:@"Hard"])
    {
        
        prevHighScore = [[highScoreArray objectAtIndex:2] integerValue];
    }
    
    if(prevHighScore < currentLevelScore)
    {
        prevHighScore = currentLevelScore;
        highScore = [[NSNumber alloc] initWithInt:prevHighScore];
        [self saveHighScoreIntoFile:filename];
    }
}

// Writes the new score into plist.
- (void) saveHighScoreIntoFile:(NSString*) filename
{
    if([level isEqualToString:@"Easy"])
    {
        [highScoreArray replaceObjectAtIndex:0 withObject:highScore];
        
    } else if([level isEqualToString:@"Medium"])
    {
        [highScoreArray replaceObjectAtIndex:1 withObject:highScore];
        
    }else if ([level isEqualToString:@"Hard"])
    {
        [highScoreArray replaceObjectAtIndex:2 withObject:highScore];
        
    }
    
    [highScoreArray writeToFile:filename atomically:YES];
}

// Fetches the filename for plist.
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
