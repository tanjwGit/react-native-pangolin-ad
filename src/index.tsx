import { NativeModules, NativeEventEmitter, Platform } from "react-native";

const { PangolinAd } = NativeModules;

// export type eventType = 'splashAdDidLoad' | 'didFailWithError' | 'splashAdDidClick' | 'splashAdDidClose' | 'splashAdWillClose'
//     | "splashAdDidCloseOtherController" | "splashAdDidClickSkip" | 'splashAdCountdownToZero';


const showSplashAd = (platformCodeId: {
  ios: string,
  android: string
}, listeners?: {[eventType: string]: Function}) => {
  const eventEmitter = new NativeEventEmitter(PangolinAd);
  eventEmitter.addListener('splashEventReminder')


  const _eventEmitter = eventEmitter.addListener('splashEventReminder', ({eventType}) => {
    const _event = listeners && listeners[eventType];
    if(typeof _event === 'function') {
      _event();
    }
    if(['didFailWithError', 'splashAdDidClose'].indexOf(eventType) > -1){
      _eventEmitter.remove();
    }
 })
 const codeId = Platform.select(platformCodeId)
 if (codeId) {
  PangolinAd.showSplashAd(codeId + '');
 } else {
   console.error('codeId 不存在');

 }

}

export { showSplashAd };