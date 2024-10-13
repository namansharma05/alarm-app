package com.example.alarm_app

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log

class AlarmReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        // This code will execute when the alarm goes off
        Log.d("AlarmReceiver", "Hello World")
        // Optionally, you could also use a Toast to display the message
        // Toast.makeText(context, "Hello World", Toast.LENGTH_SHORT).show()
    }
}
