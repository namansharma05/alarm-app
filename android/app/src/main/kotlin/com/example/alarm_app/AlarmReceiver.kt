package com.example.alarm_app

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Handler
import android.os.Vibrator
import android.media.MediaPlayer
import android.util.Log

class AlarmReceiver : BroadcastReceiver() {

    companion object {
        private var mediaPlayer: MediaPlayer? = null
    }

    override fun onReceive(context: Context, intent: Intent) {
        when (intent.action) {
            "STOP_ALARM" -> {
                Log.d("AlarmReceiver", "Stop alarm received")
                // Stop the MediaPlayer
                mediaPlayer?.let { mp ->
                    if (mp.isPlaying) {
                        Log.d("AlarmReceiver", "Stopping media player")
                        mp.stop()
                    }
                    mp.release()
                    mediaPlayer = null
                }?: Log.d("AlarmReceiver", "MediaPlayer is null, nothing to stop.")

                // Stop vibration if necessary
                val vibrator = context.getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
                vibrator.cancel()
            }
            else -> {
                Log.d("AlarmReceiver", "Alarm triggered, sound playing")
                
                // Vibrate phone when the alarm triggers
                val vibrator = context.getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
                vibrator?.vibrate(2000)

                // Play custom sound from raw resources
                if (mediaPlayer == null) { // Only create a new instance if it's null
                    mediaPlayer = MediaPlayer.create(context, R.raw.iphone_alarm)

                    mediaPlayer?.setOnPreparedListener {
                        it.start()
                        it.setOnCompletionListener { mp -> mp.start() } // Looping sound
                    }
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
    }
}