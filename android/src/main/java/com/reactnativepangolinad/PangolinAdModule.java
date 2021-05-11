package com.reactnativepangolinad;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.module.annotations.ReactModule;
import com.reactnativepangolinad.config.TTAdManagerHolder;
import android.content.Context;
import android.content.Intent;
import android.app.Activity;
import com.reactnativepangolinad.activity.SplashActivity;

@ReactModule(name = PangolinAdModule.NAME)
public class PangolinAdModule extends ReactContextBaseJavaModule {
    public static final String NAME = "PangolinAd";
    private final ReactApplicationContext reactContext;

    public PangolinAdModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    @NonNull
    public String getName() {
        return NAME;
    }


    // Example method
    // See https://reactnative.dev/docs/native-modules-android
    @ReactMethod
    public void multiply(int a, int b, Promise promise) {
        promise.resolve(a * b);
    }

    @ReactMethod
    public static void init(Context context, String appid) {
        TTAdManagerHolder.init(context, appid, true);
        // promise.resolve(TTAdManagerHolder.sInit);
    }

    @ReactMethod
    public void showSplashAd(String codeid) {
        Intent intent = new Intent(reactContext, SplashActivity.class);
        intent.putExtra("splash_rit", codeid);
        intent.putExtra("is_express", false);
        intent.putExtra("is_half_size", false);
        final Activity context = getCurrentActivity();
        if (context != null) {
            context.startActivity(intent);
        }
    }

    public static native int nativeMultiply(int a, int b);
}
