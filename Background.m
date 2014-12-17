//
//  Background.m
//  HelpTheBirdie
//
//  Created by saranyashanmugam on 5/7/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import "Background.h"

@implementation Background

@synthesize backGroundNodes;

    -(id)init
    {
        if(self = [super init])
        {
            backGroundNodes = [[NSMutableArray alloc]init];
        }
        return self;
    }

// Creates two background nodes and adds it to an array.
-(void) getBackGroundNode
{
    // create duplicate background and insert location
    SKSpriteNode *background = [[SKSpriteNode alloc] initWithImageNamed:@"goldfish-background-01"];
    SKSpriteNode *clonedBackground;

    background.anchorPoint = CGPointZero;
    background.position = CGPointMake(0, 0);
    
    clonedBackground = [background copy];
    clonedBackground.anchorPoint = CGPointZero;
    clonedBackground.position = CGPointMake(clonedBackground .size.width-1, 0);
    
    [self.backGroundNodes addObject:background];
    [self.backGroundNodes addObject:clonedBackground];
    
}





@end
