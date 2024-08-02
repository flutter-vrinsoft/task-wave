package com.app.taskwave

import android.content.ContentValues
import android.net.Uri
import android.provider.CalendarContract
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity(){
    private val CHANNEL = "com.app.taskwave/calendar"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "addCalendarEvent") {
                val title = call.argument<String>("title")
                val description = call.argument<String>("description")
                val location = call.argument<String>("location")
                val beginTime = call.argument<Number>("beginTime")?.toLong()
                val endTime = call.argument<Number>("endTime")?.toLong()
                val allDay = call.argument<Boolean>("allDay") ?: false
                val timezone = call.argument<String>("timezone")
                val hasAlarm = call.argument<Boolean>("hasAlarm") ?: false

                val taskId = addCalendarTask(title, description, location, beginTime, endTime, allDay, timezone, hasAlarm)
                if (taskId != null) {
                    result.success(taskId)
                } else {
                    result.error("UNAVAILABLE", "Calendar event could not be created", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    fun addToCalendar(){

    }
    private fun addCalendarTask(title: String?, description: String?, location: String?, beginTime: Long?, endTime: Long?, allDay: Boolean, timezone: String?, hasAlarm: Boolean): Long? {

        val eventValues = ContentValues().apply {
            put(CalendarContract.Events.CALENDAR_ID, 1)
            put(CalendarContract.Events.TITLE, title)
            put(CalendarContract.Events.DESCRIPTION, description)
            put(CalendarContract.Events.EVENT_LOCATION, location)
            put(CalendarContract.Events.DTSTART, beginTime)
            put(CalendarContract.Events.DTEND, endTime)
            put(CalendarContract.Events.ALL_DAY, if (allDay) 1 else 0)
            put(CalendarContract.Events.EVENT_TIMEZONE, timezone)
            put(CalendarContract.Events.HAS_ALARM, if (hasAlarm) 1 else 0)
            put(CalendarContract.Events.STATUS, CalendarContract.Events.STATUS_TENTATIVE) // Status to mark it as a task
            put(CalendarContract.Events.ACCESS_LEVEL, CalendarContract.Events.ACCESS_PRIVATE) // Make it private
        }

        val eventUri: Uri? = contentResolver.insert(CalendarContract.Events.CONTENT_URI, eventValues)
        val taskID = eventUri?.lastPathSegment?.toLong()

        Log.e("TAG", "addCalendarTask: ${taskID}", )

        val cur = this.contentResolver.query(
            CalendarContract.Calendars.CONTENT_URI,
            null,
            null,
            null,
            null
        )

        if (hasAlarm && taskID != null) {
            val reminderValues = ContentValues().apply {
                put(CalendarContract.Reminders.EVENT_ID, taskID)
                put(CalendarContract.Reminders.MINUTES, 10)
                put(CalendarContract.Reminders.METHOD, CalendarContract.Reminders.METHOD_ALERT)
            }
            Log.e("TAG", "addCalendarTask: ${reminderValues}", )
            contentResolver.insert(CalendarContract.Reminders.CONTENT_URI, reminderValues)

        }

        return taskID

    }
}
