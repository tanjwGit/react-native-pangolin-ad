# react-native-pangolin-ad

reactnative 穿山甲广告

## Installation

```sh
npm install react-native-pangolin-ad
```

## Usage

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

```js
import PangolinAd from "react-native-pangolin-ad";

// ...

const result = await PangolinAd.multiply(3, 7);
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
