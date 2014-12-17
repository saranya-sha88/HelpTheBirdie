//
//  BackgroundSound.m
//  HelpTheBirdie
//
//  Created by Pavana on 5/16/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import "BackgroundSound.h"

@implementation BackgroundSound

@synthesize birdJumpSound,clashSound,eatAppleSound,bgSound, shieldSound, birdJumpSoundFileURL, eatAppleSoundFileURL, clashSoundFileURL, bgSoundFileURL, shieldSoundFileURL;

-(id)init
{
    if(self = [super init])
    {
        birdJumpSoundFileURL = [self getURLWithName:@"jump" andWithExtension:@"wav"];
        birdJumpSound = [self audioPlayerForSound:birdJumpSoundFileURL];
        [birdJumpSound prepareToPlay];
        
        eatAppleSoundFileURL = [self getURLWithName:@"AppleCrunch" andWithExtension:@"wav"];
        eatAppleSound = [self audioPlayerForSound:eatAppleSoundFileURL];
        [eatAppleSound prepareToPlay];
        
        clashSoundFileURL = [self getURLWithName:@"clash" andWithExtension:@"wav"];
        clashSound = [self audioPlayerForSound:clashSoundFileURL];
        [clashSound prepareToPlay];
        
        bgSoundFileURL = [self getURLWithName:@"GameBackground" andWithExtension:@"wav"];
        bgSound = [self audioPlayerForSound:bgSoundFileURL];
        [bgSound prepareToPlay];
        
        shieldSoundFileURL = [self getURLWithName:@"Shield" andWithExtension:@"aiff"];
        shieldSound = [self audioPlayerForSound:shieldSoundFileURL];
        [shieldSound prepareToPlay];

    }
    return self;
}

// Gets the url containing the sound file path.
- (NSURL*) getURLWithName:(NSString*) resourceName
         andWithExtension:(NSString*) extension
{
    return [[NSBundle mainBundle] URLForResource:resourceName
                                   withExtension:extension];
}

// Creates audio player for the respective url.
- (AVAudioPlayer*) audioPlayerForSound:(NSURL*) resourceFileURL
{
    return [[AVAudioPlayer alloc] initWithContentsOfURL:resourceFileURL
                                                  error:nil];
}

// Plays bird jump sound.
- (void) playBirdJumpSound
{
    [birdJumpSound play];
    birdJumpSound.volume = 0.5;
}

// Pauses bird jump sound.
- (void) stopBirdJumpSound
{
    [birdJumpSound pause];
}

// Plays apple eating sound.
- (void) playEatAppleSound
{
    [eatAppleSound play];
    eatAppleSound.volume = 1.0;
}

// Plays collision sound.
- (void) playClashSound
{
    [clashSound play];
}

// Plays background sound.
- (void) playBgSound
{
    [bgSound play];
    bgSound.volume = 0.1;
    bgSound.numberOfLoops = -1;
}

// Stops background sound.
- (void) stopBgSound
{
    [bgSound stop];
}

// Checks whether background sound is playing.
- (BOOL) isBgSoundPlaying
{
    return bgSound.playing;
}

// Plays getting shield sound.
- (void) playShieldSound
{
    [shieldSound play];
}

// Handles interruptions.
- (void) audioPlayerBeginInterruption: (AVAudioPlayer *) player
{
    [bgSound pause];
    [eatAppleSound pause];
    [clashSound pause];
    [birdJumpSound pause];
}

// Stops all audio players.
-(void) stopAllSounds
{
    [bgSound stop];
    [eatAppleSound stop];
    [clashSound stop];
    [birdJumpSound stop];
}

@end
