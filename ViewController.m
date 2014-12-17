//
//  ViewController.m
//  HelpTheBirdie
//
//  Created by Pavana on 5/7/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import "ViewController.h"
#import "MenuScene.h"

@implementation ViewController

BackgroundSound *bgSoundObject;

- (void)viewDidLoad
{
    [super viewDidLoad];
    bgSoundObject = [[BackgroundSound alloc] init];
    // Configure the view.
    SKView *skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
  //  skView.showsPhysics = YES;
    
    // Create and configure the menu scene.
    SKScene *scene = [MenuScene sceneWithSize:skView.bounds.size];
    
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
