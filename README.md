# react-native-pangolin-ad

reactnative pangolin 穿山甲

## Installation

```sh
# npm install react-native-pangolin-ad
# 暂无 npm 包, 可通过github地址使用
```

## 集成
#### 安卓
注意穿山甲要求gradle版本 `com.android.tools.build:gradle:xxx`

`example/android/build.gradle` 文件：
``` gradle
allprojects {
  repositories {
    ...其他引用
     maven {
            url 'https://artifact.bytedance.com/repository/pangle'
        }
  }
}
```

#### ios
`info.plist` 文件:
```plist
  <!-- 添加http权限 -->
  <key>NSAppTransportSecurity</key>
    <dict>
         <key>NSAllowsArbitraryLoads</key>
         <true/>
    </dict>

  <!-- iOS 14 AppTrackingTransparency -->
	<key>NSUserTrackingUsageDescription</key>
	<string>该标识符将用于向您投放个性化广告</string>

  <!-- 设置穿山甲SKAdNetwork id -->
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

### 开屏广告如需显示logo图
- ios: 通过 `xcode` 将 `splash_bottom.png` 文件拖入`ios`文件夹下
- android: `splash_bottom.png` 放入 `android/app/src/main/res/drawable` 文件夹

### 初始化
- ios: `ios/PangolinAdExample/AppDelegate.m`文件中
```
#import <PangolinAd.h>
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   [PangolinAd init:@"xxxxx"];
}
```
- android: `MainApplication.java` 文件中
```java
import com.reactnativepangolinad.PangolinAdModule;
public void onCreate() {
  PangolinAdModule.init(this, "xxxxxx");
}
```
### js端使用：
- js端使用见 `example/src/App.tsx`


## 已知问题

1. 目前发现开屏广告在部分荣耀机型上出现广告加载出后消失的bug, 但广告出现和读秒结果的事件仍被正常触发，未知原因，等待穿山甲官方解决。

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
