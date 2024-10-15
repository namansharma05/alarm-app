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

    data class Alarm(
        val hour: Int,
        val minute: Int,
        val meridiem: String,
        val status: Boolean
    )


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "setAlarm" -> {
                    val alarmMap = call.arguments as? Map<String, Any?>
                    if (alarmMap != null) {
                        val alarm = mapToAlarm(alarmMap)
                        // Now you can use the User object
                        val time = setAlarm(alarm)
                        result.success("Alarm set successfully for time: $time")
                    } else {
                        result.error("INVALID_ARGUMENT", "Expected map argument", null)
                    }
                    
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun mapToAlarm(map: Map<String, Any?>): Alarm {
        return Alarm(
            hour = map["hour"] as Int,
            minute = map["minute"] as Int,
            meridiem = map["meridiem"] as String,
            status = map["status"] as Boolean
        )
    }

    private fun setAlarm(alarm: Alarm): String {
        val calendar: Calendar = Calendar.getInstance()
        calendar.timeZone = TimeZone.getTimeZone("Asia/Kolkata")
        calendar[Calendar.HOUR_OF_DAY] = if(alarm.meridiem == "AM") alarm.hour else alarm.hour + 12
        calendar[Calendar.MINUTE] = alarm.minute
        calendar[Calendar.SECOND] = 0
        calendar[Calendar.MILLISECOND] = 0
        
        alarmMgr = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val intent = Intent(this, AlarmReceiver::class.java)
        alarmIntent = PendingIntent.getBroadcast(this, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)

        // println("current system time: "+System.currentTimeMillis())

        alarmMgr?.setExact (
            AlarmManager.RTC_WAKEUP,
            calendar.timeInMillis,
            alarmIntent
        )
        // println("alarm time: "+calendar.timeInMillis)
        return calendar[Calendar.HOUR_OF_DAY].toString()+":"+calendar[Calendar.MINUTE].toString()
    }
}
