//
//  AppDelegate.m
//  MaxiOSDemo1
//
//  Created by game team on 2020/4/21.
//  Copyright © 2020 yjg. All rights reserved.
//

#import "AppDelegate.h"
#import <AppLovinSDK/AppLovinSDK.h>

@interface AppDelegate ()
@property (nonatomic, strong) MARewardedAd *rewardedAd;
@property (nonatomic, assign) NSInteger retryAttempt;

@property (nonatomic, strong) MAInterstitialAd *interstitialAd;
@property (nonatomic, assign) NSInteger retryAttemptInter;
@end

@implementation AppDelegate

//NSString *mRewardID = @"ee5718df87bc32dc";
//NSString *mInterID = @"e161529271a72201";

//+ (id)instance{
//    static dispatch_once_t onceToken;
//    static AppDelegate *_appDelegate;
//    dispatch_once(&onceToken, ^{
//        _appDelegate = [[AppDelegate alloc] init];
//    });
//    return _appDelegate;
//}
//
//
//- (void)createRewardedAd
//{
//    self.rewardedAd = [MARewardedAd sharedWithAdUnitIdentifier: mRewardID];
//    self.rewardedAd.delegate = self;
//
//    // Load the first ad
//    [self.rewardedAd loadAd];
//}
//
//#pragma mark - MAAdDelegate Protocol
//
//- (void)didLoadAd:(MAAd *)ad
//{
//    NSLog(@"yjg max reward ad loaded");
//    // Rewarded ad is ready to be shown. '[self.rewardedAd isReady]' will now return 'YES'
//    if(MAAdFormat.rewarded == ad.format){
//        NSLog(@"yjg max reward ad loaded");
//        // Reset retry attempt
//        self.retryAttempt = 0;
//    }else if (MAAdFormat.interstitial == ad.format){
//        NSLog(@"yjg max inter ad loaded");
//        // Reset retry attempt
//        self.retryAttemptInter = 0;
//    }
//}
//- (void)didFailToLoadAdForAdUnitIdentifier:(NSString *)adUnitIdentifier withErrorCode:(NSInteger)errorCode
//{
//    // Rewarded ad failed to load. We recommend retrying with exponentially higher delays.
//
//    if(adUnitIdentifier == mRewardID){
//        NSLog(@"yjg max reward ad fail to load");
//        self.retryAttempt++;
//        NSInteger delaySec = pow(2, self.retryAttempt);
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delaySec * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//            [self.rewardedAd loadAd];
//        });
//    }else if (adUnitIdentifier == mInterID){
//        NSLog(@"yjg max inter ad fail to load");
//        self.retryAttemptInter++;
//        NSInteger delaySec = pow(2, self.retryAttemptInter);
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delaySec * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//            [self.interstitialAd loadAd];
//        });
//    }
//}
//
//- (void)didDisplayAd:(MAAd *)ad {}
//
//- (void)didClickAd:(MAAd *)ad {}
//
//- (void)didHideAd:(MAAd *)ad
//{
//    // Rewarded ad is hidden. Pre-load the next ad
//    if(MAAdFormat.rewarded == ad.format){
//        [self.rewardedAd loadAd];
//    }else if (MAAdFormat.interstitial == ad.format){
//        [self.interstitialAd loadAd];
//    }
//}
//
//- (void)didFailToDisplayAd:(MAAd *)ad withErrorCode:(NSInteger)errorCode
//{
//    // Rewarded ad failed to display. We recommend loading the next ad
//    if(MAAdFormat.rewarded == ad.format){
//        [self.rewardedAd loadAd];
//    }else if (MAAdFormat.interstitial == ad.format){
//        [self.interstitialAd loadAd];
//    }
//}
//
//#pragma mark - MARewardedAdDelegate Protocol
//
//- (void)didStartRewardedVideoForAd:(MAAd *)ad {}
//
//- (void)didCompleteRewardedVideoForAd:(MAAd *)ad {}
//
//- (void)didRewardUserForAd:(MAAd *)ad withReward:(MAReward *)reward
//{
//    // Rewarded ad was displayed and user should receive the reward
//}
//
//- (void)createInterstitialAd
//{
//    self.interstitialAd = [[MAInterstitialAd alloc] initWithAdUnitIdentifier: mInterID];
//    self.interstitialAd.delegate = self;
//
//    // Load the first ad
//    [self.interstitialAd loadAd];
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    [ALSdk shared].mediationProvider = @"max";
//    [[ALSdk shared] initializeSdkWithCompletionHandler:^(ALSdkConfiguration *configuration) {
//        NSLog(@"yjg max sdk init finished");
//        [self createInterstitialAd];
//        [self createRewardedAd];
//    }];
    
    return YES;
}

- (void)ShowReward{
    NSLog(@"yjg max reward ad show");
    if ([self.rewardedAd isReady])
    {
        [self.rewardedAd showAd];
    }
}

- (void)ShowInter{
    NSLog(@"yjg max inter ad show");
    if ([self.interstitialAd isReady])
    {
        [self.interstitialAd showAd];
    }
}
@end
