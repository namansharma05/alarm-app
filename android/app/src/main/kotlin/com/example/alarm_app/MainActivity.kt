package com.example.alarm_app

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example/alarm-app";

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
        // This method is invoked on the main thread.
        call, result ->
            if (call.method == "printHelloWorld") {
                printHelloWorld()
            } else {
                result.notImplemented()
            }
        }
        
    }
    private fun printHelloWorld() {
            println("Hello World!")
        }
}
