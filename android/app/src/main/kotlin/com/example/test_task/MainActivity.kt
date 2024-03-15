package com.example.test_task

import io.flutter.embedding.android.FlutterActivity
import android.os.Handler
import android.os.Looper
import android.widget.Toast
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.myapp/channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            when (call.method) {
                "startBackgroundNotifications" -> {
                    val message = call.argument<String>("message")
                    startBackgroundNotifications(message)
                    result.success(true)
                }

                else -> result.notImplemented()
            }
        }
    }

    private fun startBackgroundNotifications(message: String?) {
        Toast.makeText(
            applicationContext,
            message ?: "Background Notification",
            Toast.LENGTH_SHORT
        ).show()
    }
}


