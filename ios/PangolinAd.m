#import "PangolinAd.h"
@import AdSupport;
@import AppTrackingTransparency;

@implementation PangolinAd
{
   BOOL hasListeners;
}

// 在添加第一个监听函数时触发
- (void)startObserving
{
  hasListeners = YES;
}

- (void)stopObserving
{
  hasListeners = NO;
}

RCT_EXPORT_MODULE()

- (NSArray<NSString *> *)supportedEvents
{
  return @[@"splashEventReminder"];
}

// Example method
// See // https://reactnative.dev/docs/native-modules-ios
RCT_REMAP_METHOD(multiply,
                 multiplyWithA:(nonnull NSNumber*)a withB:(nonnull NSNumber*)b
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
  NSNumber *result = @([a floatValue] * [b floatValue]);

  resolve(result);
}

RCT_EXPORT_METHOD(showSplashAd:(NSString *)codeId)
{
    dispatch_async(dispatch_get_main_queue(), ^{
      CGRect frame = [UIScreen mainScreen].bounds;

      NSString *splashBottomPath = [[NSBundle mainBundle] pathForResource:@"splash_bottom.png" ofType:nil];
      BOOL hasLogoIcon = splashBottomPath;
      float windowHeight = CGRectGetMaxY(frame);
      float logoIconHeight = windowHeight * 0.14f;
      float splashAdHegiht = hasLogoIcon ? (windowHeight - logoIconHeight) : windowHeight;
      UIImageView *IconView;
      if(hasLogoIcon){
          IconView = [[UIImageView alloc] initWithFrame:CGRectMake(
               0,
               splashAdHegiht,
               CGRectGetWidth(frame),
               logoIconHeight
            )
         ];
         NSData *data = [NSData dataWithContentsOfFile:splashBottomPath];
         IconView.image = [UIImage imageWithData:data];
         IconView.contentMode = UIViewContentModeScaleAspectFill;
         IconView.hidden = YES;
      }
      self.splashAdView = [[BUSplashAdView alloc] initWithSlotID:codeId frame:CGRectMake(
            0,
            0,
            CGRectGetWidth(frame),
            splashAdHegiht
         )
      ];
      // tolerateTimeout = CGFLOAT_MAX , The conversion time to milliseconds will be equal to 0
      self.splashAdView.tolerateTimeout = 10;
      // 不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
      self.splashAdView.delegate = self;

      UIWindow *keyWindow = [UIApplication sharedApplication].windows.firstObject;
      self.startTime = CACurrentMediaTime();
      [self.splashAdView loadAdData];

      [keyWindow.rootViewController.view addSubview:self.splashAdView];
      if (IconView) {
         [keyWindow.rootViewController.view addSubview:IconView];
      }
      self.splashAdView.rootViewController = keyWindow.rootViewController;
      self.IconView = IconView;
    });
}

-(void)splashAdDidLoad:(BUSplashAdView *) splashView {
    // SDK渲染开屏广告加载成功回调
    if (self.IconView.hidden) {
      self.IconView.hidden = NO;
    }
    if (hasListeners) {
        [self sendEventWithName:@"splashEventReminder" body:@{@"eventType": @"splashAdDidLoad"}];
    }
}
- (void)splashAd:(BUSplashAdView *)splashView didFailWithError:(NSError * _Nullable)error {
    // 返回的错误码(error)表示广告加载失败的原因，所有错误码详情请见链接Link
    if (hasListeners) {
        [self sendEventWithName:@"splashEventReminder" body:@{
           @"eventType": @"didFailWithError",
           @"message": error,
         }];
    }
}
-(void)splashAdDidClick:(BUSplashAdView *) splashView {
   // SDK渲染开屏广告点击回调
   if (hasListeners){
        [self sendEventWithName:@"splashEventReminder" body:@{@"eventType": @"splashAdDidClick"}];
   }
}
- (void)splashAdDidClose:(BUSplashAdView *) splashView {
   // SDK渲染开屏广告关闭回调，当用户点击广告时会直接触发此回调，建议在此回调方法中直接进行广告对象的移除操作
    [self.splashAdView removeFromSuperview];
    if (self.IconView) {
      [self.IconView removeFromSuperview];
    }
    if (hasListeners){
        [self sendEventWithName:@"splashEventReminder" body:@{@"eventType": @"splashAdDidClose"}];
    }
}
-(void)splashAdWillClose:(BUSplashAdView *) splashView {
   // SDK渲染开屏广告即将关闭回调
   if (hasListeners){
        [self sendEventWithName:@"splashEventReminder" body:@{@"eventType": @"splashAdWillClose"}];
    }
}
- (void)splashAdDidCloseOtherController:(BUSplashAdView *)splashView interactionType:(BUInteractionType)interactionType{
    // 此回调在广告跳转到其他控制器时，该控制器被关闭时调用。interactionType：此参数可区分是打开的appstore/网页/视频广告详情页面。
if (hasListeners){
        [self sendEventWithName:@"splashEventReminder" body:@{@"eventType": @"splashAdDidCloseOtherController"}];
    }
}
-(void)splashAdDidClickSkip:(BUSplashAdView *) splashView {
   // 用户点击跳过按钮时会触发此回调，可在此回调方法中处理用户点击跳转后的相关逻辑
if (hasListeners){
        [self sendEventWithName:@"splashEventReminder" body:@{@"eventType": @"splashAdDidClickSkip"}];
    }
}
-(void)splashAdCountdownToZero:(BUSplashAdView *) splashView {
   // 倒计时为0时会触发此回调，如果客户端使用了此回调方法，建议在此回调方法中进行广告的移除操作
   if (hasListeners){
        [self sendEventWithName:@"splashEventReminder" body:@{@"eventType": @"splashAdCountdownToZero"}];
    }

}

+ (void)requestIDFA {
   if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
        }];
    }
}

+ (void)init:(NSNumber *)appId {
   ///optional
   ///CN china, NO_CN is not china
   ///you must set Territory first,  if you need to set them
   [BUAdSDKManager setTerritory: BUAdSDKTerritory_CN];
   //optional
   //GDPR 0 close privacy protection, 1 open privacy protection
   [BUAdSDKManager setGDPR:0];
   //optional
   //Coppa 0 adult, 1 child
   [BUAdSDKManager setCoppa:0];
   // you can set idfa by yourself, it is optional and maybe will never be used.
   // [BUAdSDKManager setCustomIDFA:@"12345678-1234-1234-1234-123456789012"];
#if DEBUG
   // Whether to open log. default is none.
   [BUAdSDKManager setLoglevel:BUAdSDKLogLevelDebug];
#endif
   //BUAdSDK requires iOS 9 and up
   [BUAdSDKManager setAppID: appId];

   [BUAdSDKManager setIsPaidApp:NO];
   [PangolinAd requestIDFA];
}

@end
