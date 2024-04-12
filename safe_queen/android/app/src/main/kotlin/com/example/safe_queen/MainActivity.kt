package com.example.safe_queen

import android.content.Context
import android.telephony.SmsManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "platform_service"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "sendSMSAlert") {
                val args = call.arguments as Map<String, Any>
                val phoneNumber = args["phoneNumber"] as String
                val message = args["message"] as String
                sendSMSAlert(phoneNumber, message)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun sendSMSAlert(phoneNumber: String, message: String) {
        try {
            val smsManager = SmsManager.getDefault()
            smsManager.sendTextMessage(phoneNumber, null, message, null, null)
        } catch (e: Exception) {
            println("Failed to send SMS alert: ${e.message}")
        }
    }
}
