package com.example.alarm_app

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Handler
import android.os.Vibrator
import android.media.MediaPlayer
import android.util.Log

class AlarmReceiver : BroadcastReceiver() {

    private var mediaPlayer: MediaPlayer? = null
    private var playTime = 0
    private val oneMinuteMillis = 60000

    override fun onReceive(context: Context, intent: Intent) {
        Log.d("AlarmReceiver", "Alarm triggered, sound playing")
        
        // Vibrate phone when the alarm triggers
        val vibrator = context.getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
        vibrator?.vibrate(2000)

        // Play custom sound from raw resources
        mediaPlayer = MediaPlayer.create(context, R.raw.iphone_alarm)

        mediaPlayer?.setOnPreparedListener {
            it.start()

            it.setOnCompletionListener { mp ->
                if (playTime < oneMinuteMillis) {
                    mp.start()
                }
            }

            val handler = Handler()
            handler.postDelayed({
                mediaPlayer?.let { mp ->
                    if (mp.isPlaying) {
                        mp.stop()
                        mp.release()
                    }
                }
            }, oneMinuteMillis.toLong())

            val soundDuration = it.duration
            val updatePlayTimeHandler = Handler()
            updatePlayTimeHandler.post(object : Runnable {
                override fun run() {
                    if (playTime < oneMinuteMillis) {
                        playTime += soundDuration
                        updatePlayTimeHandler.postDelayed(this, soundDuration.toLong())
                    }
                }
            })
        }

        // Launch MainActivity when alarm triggers
        val mainIntent = Intent(context, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP
            putExtra("ALARM_TRIGGERED", true)  // Add a flag to indicate alarm trigger
            putExtra("route", "/alarm_screen")
            action = "com.example.alarm_app.ALARM_TRIGGERED"
        }
        context.startActivity(mainIntent)
    }
}