package com.example.secure_device

import android.content.Context
import android.os.Build
import android.provider.Settings
import androidx.annotation.RequiresApi


object DevelopmentModeCheck {

    @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR1)
    fun developmentModeCheck(context: Context): Boolean {
        return if (Integer.valueOf(Build.VERSION.SDK_INT) == Build.VERSION_CODES.JELLY_BEAN) {
            Settings.Secure.getInt(
                context.contentResolver,
                Settings.Secure.DEVELOPMENT_SETTINGS_ENABLED, 0
            ) != 0
        } else if (Integer.valueOf(Build.VERSION.SDK_INT) >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
            Settings.Secure.getInt(
                context.contentResolver,
                Settings.Global.DEVELOPMENT_SETTINGS_ENABLED, 0
            ) != 0
        } else false
    }
}
