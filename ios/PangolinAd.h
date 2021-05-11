#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import <BUAdSDK/BUAdSDK.h>


@interface PangolinAd : RCTEventEmitter <RCTBridgeModule, BUSplashAdDelegate>
@property (nonatomic, assign) CFTimeInterval startTime;
@property (nonatomic, strong) BUSplashAdView *splashAdView;
@property UIImageView* IconView;
+ (void)init:(NSNumber *)appId;

@end
