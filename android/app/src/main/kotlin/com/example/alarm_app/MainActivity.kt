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
                    val time = setAlarm(alarmTime!!)
                    result.success("Alarm set successfully for time: $time")
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

    private fun setAlarm(alarmTime: Int): String {
        val calendar: Calendar = Calendar.getInstance()
        calendar.timeZone = TimeZone.getTimeZone("Asia/Kolkata")
        calendar[Calendar.HOUR_OF_DAY] = alarmTime
        calendar[Calendar.MINUTE] = 10
        calendar[Calendar.SECOND] = 0
        calendar[Calendar.MILLISECOND] = 0
        
        alarmMgr = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val intent = Intent(this, AlarmReceiver::class.java)
        alarmIntent = PendingIntent.getBroadcast(this, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)

        println("current system time: "+System.currentTimeMillis())

        alarmMgr?.setExact (
            AlarmManager.RTC_WAKEUP,
            calendar.timeInMillis,
            alarmIntent
        )
        println("alarm time: "+calendar.timeInMillis)
        return calendar[Calendar.HOUR_OF_DAY].toString()+":"+calendar[Calendar.MINUTE].toString()
    }
}
