package com.example.alarm_app

import java.util.*

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.time.Instant
import java.time.format.DateTimeFormatter

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example/alarm-app"
    private var alarmMgr: AlarmManager? = null
    private lateinit var alarmIntent: PendingIntent

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getCurrentTime" -> {
                    val currentTime = getCurrentTime()
                    result.success(currentTime)
                }
                "setAlarm" -> {
                    val alarmTime: Int? = call.argument<Int>("alarmTime") ?: 0 // Expecting the time as Int (e.g., hour or timestamp)
                    setAlarm(alarmTime!!)
                    result.success("Alarm set successfully for time: $alarmTime")
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun getCurrentTime(): String {
        val formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME.withZone(java.time.ZoneId.systemDefault())
        return formatter.format(Instant.now())
    }

    private fun setAlarm(alarmTime: Int) {
        alarmMgr = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val intent = Intent(this, AlarmReceiver::class.java)
        alarmIntent = PendingIntent.getBroadcast(this, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        val calendar: Calendar = Calendar.getInstance().apply {
            timeInMillis = System.currentTimeMillis()
            set(Calendar.HOUR_OF_DAY, alarmTime)
            set(Calendar.MINUTE, 55) // Set to the top of the hour
            set(Calendar.SECOND, 0)
        }

        alarmMgr?.setInexactRepeating (
            AlarmManager.RTC_WAKEUP,
            calendar.timeInMillis,
            AlarmManager.INTERVAL_DAY,
            alarmIntent
        )
        println("New Alarm set for: $alarmTime")
    }
}
