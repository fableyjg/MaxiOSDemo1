//
//  ViewController.m
//  MaxiOSDemo1
//
//  Created by game team on 2020/4/21.
//  Copyright © 2020 yjg. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

#import <AppLovinSDK/AppLovinSDK.h>
@interface ViewController ()<MARewardedAdDelegate, MAAdDelegate>

@property (nonatomic, strong) MARewardedAd *rewardedAd;
@property (nonatomic, assign) NSInteger retryAttempt;

@property (nonatomic, strong) MAInterstitialAd *interstitialAd;
@property (nonatomic, assign) NSInteger retryAttemptInter;

@end
AppDelegate *appDelegate;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"yjg max viewDidLoad");
    
    // Do any additional setup after loading the view.
    
    //插屏显示按钮
    UIButton *buttonInterShow = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonInterShow setTitle:@"插屏显示" forState:UIControlStateNormal];
    [buttonInterShow setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    
    buttonInterShow.frame = CGRectMake(50, 100, 100, 100);
    //注册点击事件
    [buttonInterShow addTarget:self action:@selector(ShowInter) forControlEvents:UIControlEventTouchUpInside];
    //把动态创建的按钮添加到控制器所管理的那个view中
    [self.view addSubview:buttonInterShow];
    
    //1.创建按钮（UIButton）
    UIButton *buttonReward = [UIButton buttonWithType:UIButtonTypeCustom];
    //2.设置按钮上显示的文字
    [buttonReward setTitle:@"显示激励" forState:UIControlStateNormal];
    //3.设置文字颜色
    [buttonReward setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //5.设置frame属性（位置和大小）
    buttonReward.frame = CGRectMake(50, 200, 100, 100);
    //6.通过代码为控件注册一个单机事件
    [buttonReward addTarget:self action:@selector(ShowReward) forControlEvents:UIControlEventTouchUpInside];
    //7.把动态创建的控件添加到控制器的view中
    [self.view addSubview:buttonReward];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [ALSdk shared].mediationProvider = @"max";
    [[ALSdk shared] initializeSdkWithCompletionHandler:^(ALSdkConfiguration *configuration) {
        NSLog(@"yjg max sdk init finished");
        [self createInterstitialAd];
        [self createRewardedAd];
    }];
}

NSString *mRewardID = @"ee5718df87bc32dc";
NSString *mInterID = @"e161529271a72201";

//+ (id)instance{
//    static dispatch_once_t onceToken;
//    static AppDelegate *_appDelegate;
//    dispatch_once(&onceToken, ^{
//        _appDelegate = [[AppDelegate alloc] init];
//    });
//    return _appDelegate;
//}

- (void)createRewardedAd
{
    self.rewardedAd = [MARewardedAd sharedWithAdUnitIdentifier: mRewardID];
    self.rewardedAd.delegate = self;

    // Load the first ad
    [self.rewardedAd loadAd];
}

#pragma mark - MAAdDelegate Protocol

- (void)didLoadAd:(MAAd *)ad
{
    // Rewarded ad is ready to be shown. '[self.rewardedAd isReady]' will now return 'YES'
    if(MAAdFormat.rewarded == ad.format){
        NSLog(@"yjg max reward ad loaded");
        // Reset retry attempt
        self.retryAttempt = 0;
    }else if (MAAdFormat.interstitial == ad.format){
        NSLog(@"yjg max inter ad loaded");
        // Reset retry attempt
        self.retryAttemptInter = 0;
    }
}
- (void)didFailToLoadAdForAdUnitIdentifier:(NSString *)adUnitIdentifier withErrorCode:(NSInteger)errorCode
{
    // Rewarded ad failed to load. We recommend retrying with exponentially higher delays.
    
    if(adUnitIdentifier == mRewardID){
        NSLog(@"yjg max reward ad fail to load");
        self.retryAttempt++;
        NSInteger delaySec = pow(2, self.retryAttempt);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delaySec * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self.rewardedAd loadAd];
        });
    }else if (adUnitIdentifier == mInterID){
        NSLog(@"yjg max inter ad fail to load");
        self.retryAttemptInter++;
        NSInteger delaySec = pow(2, self.retryAttemptInter);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delaySec * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self.interstitialAd loadAd];
        });
    }
}

- (void)didDisplayAd:(MAAd *)ad {}

- (void)didClickAd:(MAAd *)ad {}

- (void)didHideAd:(MAAd *)ad
{
    // Rewarded ad is hidden. Pre-load the next ad
    if(MAAdFormat.rewarded == ad.format){
        [self.rewardedAd loadAd];
    }else if (MAAdFormat.interstitial == ad.format){
        [self.interstitialAd loadAd];
    }
}

- (void)didFailToDisplayAd:(MAAd *)ad withErrorCode:(NSInteger)errorCode
{
    // Rewarded ad failed to display. We recommend loading the next ad
    if(MAAdFormat.rewarded == ad.format){
        [self.rewardedAd loadAd];
    }else if (MAAdFormat.interstitial == ad.format){
        [self.interstitialAd loadAd];
    }
}

#pragma mark - MARewardedAdDelegate Protocol

- (void)didStartRewardedVideoForAd:(MAAd *)ad {}

- (void)didCompleteRewardedVideoForAd:(MAAd *)ad {}

- (void)didRewardUserForAd:(MAAd *)ad withReward:(MAReward *)reward
{
    // Rewarded ad was displayed and user should receive the reward
}

- (void)createInterstitialAd
{
    self.interstitialAd = [[MAInterstitialAd alloc] initWithAdUnitIdentifier: mInterID];
    self.interstitialAd.delegate = self;

    // Load the first ad
    [self.interstitialAd loadAd];
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
