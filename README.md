# react-native-pangolin-ad

reactnative 穿山甲广告

## Installation

```sh
npm install react-native-pangolin-ad
```

## 集成
#### 安卓
注意gradle版本
com.android.tools.build:gradle

```
example/android/build.gradle
allprojects {
  repositories {
    ...其他引用
     maven {
            url 'https://artifact.bytedance.com/repository/pangle'
        }
  }
}
```

### ios
#### Xcode设置
info.plist
```
  // 添加http权限
  <key>NSAppTransportSecurity</key>
    <dict>
         <key>NSAllowsArbitraryLoads</key>
         <true/>
    </dict>

  // iOS 14 AppTrackingTransparency
	<key>NSUserTrackingUsageDescription</key>
	<string>该标识符将用于向您投放个性化广告</string>

  // 设置穿山甲SKAdNetwork id
	<key>SKAdNetworkItems</key>
	<array>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>238da6jt44.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>x2jnk7ly8j.skadnetwork</string>
		</dict>
		<dict>
			<key>SKAdNetworkIdentifier</key>
			<string>22mmun2rn5.skadnetwork</string>
		</dict>
	</array>
```
<!-- https://www.pangle.cn/union/media/union/download/detail?id=16&docId=5de8d570b1afac00129330c5&osType=ios -->

## Usage

开屏广告如需显示logo图，
ios: 通过xcode将splash_bottom.png文件拖入ios文件夹下
android: splash_bottom.png放入 android/app/src/main/res/drawable/splash_bottom.png文件夹

### 初始化
ios: ios/PangolinAdExample/AppDelegate.m文件中
```
#import <PangolinAd.h>
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   [PangolinAd init:@"xxxxx"];
}
```
android: MainApplication.java文件中
```
import com.reactnativepangolinad.PangolinAdModule;
public void onCreate() {
  PangolinAdModule.init(this, "xxxxxx");
}
```
js端使用example/src/App.tsx


## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
