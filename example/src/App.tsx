import * as React from 'react';

import { StyleSheet, View, Text, TouchableOpacity } from 'react-native';
import { showSplashAd } from 'react-native-pangolin-ad';

export default function App() {
  const [result, setResult] = React.useState<number | undefined>();


const showSplash = () => {
  showSplashAd({
    ios: 'xxxxxxxxxxxxx',
    android: 'xxxxxxxxxxxxx',
  }, {
    splashAdDidLoad: () => {
      console.log('splashAdDidLoad')
    }
  })
}

  return (
    <View style={styles.container}>
      <Text>Result: {result}</Text>
      <TouchableOpacity onPress={showSplash}><Text>启动屏</Text></TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
