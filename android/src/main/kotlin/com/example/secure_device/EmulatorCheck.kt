import android.os.Build

open class EmulatorCheck {
    companion object {
        fun isEmulator(): Boolean {
            print("Inside emulator check")
            return Build.FINGERPRINT.startsWith("generic")
                    || Build.FINGERPRINT.startsWith("unknown")
                    || Build.MODEL.contains("google_sdk")
                    || Build.MODEL.contains("Emulator")
                    || Build.MODEL.contains("Android SDK built for x86")
                    || Build.MANUFACTURER.contains("Genymotion")
                    || Build.MODEL.startsWith("sdk_")
                    || Build.DEVICE.startsWith("emulator")
                    || (Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic"))
                    || "google_sdk" == Build.PRODUCT;
        }
    }
}