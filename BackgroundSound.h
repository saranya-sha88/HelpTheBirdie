//
//  BackgroundSound.h
//  HelpTheBirdie
//
//  Created by Pavana on 5/16/14.
//  Copyright (c) 2014 Saranya And Pavana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface BackgroundSound : NSObject <AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *birdJumpSound;
@property (nonatomic, strong) AVAudioPlayer *eatAppleSound;
@property (nonatomic, strong) AVAudioPlayer *clashSound;
@property (nonatomic, strong) AVAudioPlayer *bgSound;
@property (nonatomic, strong) AVAudioPlayer *shieldSound;
@property (nonatomic, strong) NSURL *birdJumpSoundFileURL;
@property (nonatomic, strong) NSURL *eatAppleSoundFileURL;
@property (nonatomic, strong) NSURL *clashSoundFileURL;
@property (nonatomic, strong) NSURL *bgSoundFileURL;
@property (nonatomic, strong) NSURL *shieldSoundFileURL;

- (void) playBirdJumpSound;
- (void) stopBirdJumpSound;
- (void) playEatAppleSound;
- (void) playClashSound;
- (void) playBgSound;
- (void) stopBgSound;
- (BOOL) isBgSoundPlaying;
- (void) playShieldSound;
-(void) stopAllSounds;

@end
