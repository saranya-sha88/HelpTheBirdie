//
//  ClearedLevelScene.h
//  HelpTheBirdie
//
//  Created by saranyashanmugam on 5/16/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import "CommonScene.h"

@interface ClearedLevelScene : CommonScene
{
    NSString *level;
}

// Designated initializer.
-(id)initWithSize:(CGSize)size
         andLevel:(NSString*)currentLevel;

@end
