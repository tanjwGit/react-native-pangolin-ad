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
import android.content.pm.ApplicationInfo;

@ReactModule(name = PangolinAdModule.NAME)
public class PangolinAdModule extends ReactContextBaseJavaModule {
    public static final String NAME = "PangolinAd";
    private final ReactApplicationContext reactContext;

    public PangolinAdModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
        SplashActivity.mReactContext = reactContext;
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
    }

    @ReactMethod
    public void showSplashAd(String codeid) {
        final Activity context = getCurrentActivity();
        if(context != null) {
            ApplicationInfo appInfo = context.getApplicationInfo();
            int resID = context.getResources().getIdentifier("splash_bottom", "drawable", appInfo.packageName);
            boolean isHalfSize = false;
            if (resID > 0) {
                isHalfSize = true;
            }
            Intent intent = new Intent(reactContext, SplashActivity.class);
            intent.putExtra("splash_rit", codeid);
            intent.putExtra("is_express", false);
            intent.putExtra("is_half_size", isHalfSize);
            intent.putExtra("logo_res_id", resID);
            context.startActivity(intent);
        }
    }

    public static native int nativeMultiply(int a, int b);
}
