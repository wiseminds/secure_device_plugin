package com.example.secure_device

import android.content.Context
import android.os.Build
import com.scottyab.rootbeer.RootBeer
import java.io.BufferedReader
import java.io.File
import java.io.InputStreamReader
import java.util.Locale


class JailBreakDetection{

    companion object{

        private val ONEPLUS = "oneplus"
        private val MOTO = "moto"
        private val XIAOMI = "xiaomi"
        private val LENOVO = "lenovo"


        fun isJailBroken(context: Context): Boolean {
            val check: CheckApiVersion = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                HigherVersion()
            } else {
                LowerVersion()
            }
            return check.checkRooted() || rootBeerCheck(context)
        }

        private fun rootBeerCheck(context: Context): Boolean {
            val rootBeer = RootBeer(context)
            val brand = Build.BRAND.lowercase(Locale.getDefault())
            return if (brand.contains(ONEPLUS) || brand.contains(MOTO) || brand.contains(XIAOMI) || brand.contains(
                    LENOVO
                )
            ) {
                rootBeer.isRooted
            } else {
                rootBeer.isRootedWithBusyBoxCheck
            }
        }
    }

}


interface CheckApiVersion {
    fun checkRooted(): Boolean
}

class HigherVersion : CheckApiVersion{
    override fun checkRooted(): Boolean {
        return isRootDeviceDetected() || isDeviceRooted()
    }

    private fun isRootDeviceDetected(): Boolean {
        val paths = arrayOf(
            "/system/app/Superuser.apk",
            "/sbin/su",
            "/system/bin/su",
            "/system/xbin/su",
            "/data/local/xbin/su",
            "/data/local/bin/su",
            "/system/sd/xbin/su",
            "/system/bin/failsafe/su",
            "/data/local/su"
        )
        for (path in paths) {
            if (File(path).exists()) return true
        }
        return false
    }

    private fun isDeviceRooted(): Boolean {
        var process: Process? = null
        return try {
            process = Runtime.getRuntime().exec(arrayOf("/system/xbin/which", "su"))
            val `in` = BufferedReader(InputStreamReader(process.inputStream))
            `in`.readLine() != null
        } catch (t: Throwable) {
            false
        } finally {
            process?.destroy()
        }
    }

}

class LowerVersion : CheckApiVersion {
    override fun checkRooted(): Boolean {
       return  canExecuteCommand() || isSuperuserPresent()
    }

    private fun canExecuteCommand(command: String = "/system/xbin/which su"): Boolean {
        val executeResult: Boolean = try {
            val process = Runtime.getRuntime().exec(command)
            process.waitFor() == 0
        } catch (e: Exception) {
            false
        }
        return executeResult
    }

    private fun isSuperuserPresent(): Boolean {
        // Check if /system/app/Superuser.apk is present
        val paths = arrayOf(
            "/system/app/Superuser.apk",
            "/sbin/su",
            "/system/bin/su",
            "/system/xbin/su",
            "/data/local/xbin/su",
            "/data/local/bin/su",
            "/system/sd/xbin/su",
            "/system/bin/failsafe/su",
            "/data/local/su"
        )
        for (path in paths) {
            if (File(path).exists()) {
                return true
            }
        }
        return false
    }


}

