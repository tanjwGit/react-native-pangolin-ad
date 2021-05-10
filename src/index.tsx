import { NativeModules } from 'react-native';

type PangolinAdType = {
  multiply(a: number, b: number): Promise<number>;
};

const { PangolinAd } = NativeModules;

export default PangolinAd as PangolinAdType;
