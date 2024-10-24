package com.example.alarm_app

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Handler
import android.os.Vibrator
import android.media.MediaPlayer
import android.util.Log
import io.flutter.embedding.android.FlutterActivity

class AlarmReceiver : BroadcastReceiver() {

    private var mediaPlayer: MediaPlayer? = null
    private var playTime = 0
    private val oneMinuteMillis = 60000

    override fun onReceive(context: Context, intent: Intent) {
        Log.d("AlarmReceiver", "Alarm triggered, sound playing")
        // Vibrate phone when the alarm triggers (optional)
        val vibrator = context.getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
        vibrator?.vibrate(2000) // Vibrate for 2 seconds

        // Play custom sound from raw resources
        mediaPlayer = MediaPlayer.create(context, R.raw.iphone_alarm) // Replace with your sound file

        mediaPlayer?.setOnPreparedListener {
            it.start()

            // Set up the OnCompletionListener to restart the sound immediately when it finishes
            it.setOnCompletionListener { mp ->
                if (playTime < oneMinuteMillis) {
                    mp.start() // Restart the sound immediately
                }
            }

            // Track total play time using a Handler and stop after 1 minute
            val handler = Handler()
            handler.postDelayed({
                mediaPlayer?.let { mp ->
                    if (mp.isPlaying) {
                        mp.stop()
                        mp.release()
                    }
                }
            }, oneMinuteMillis.toLong())

            // Start tracking the playtime
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

        // Launch Flutter activity when alarm triggers
        val flutterIntent = FlutterActivity
            .withNewEngine()
            .initialRoute("/alarm_screen") // This sets the initial Flutter screen
            .build(context)
        context.startActivity(flutterIntent)

        
    }
}
