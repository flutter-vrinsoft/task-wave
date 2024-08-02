package com.app.taskwave

import com.microsoft.appcenter.AppCenter
import com.microsoft.appcenter.analytics.Analytics
import com.microsoft.appcenter.crashes.Crashes
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity(){
    private val appCenter = "c54ebafe-45dd-482d-99d8-edbcd88dbc78"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        AppCenter.start(
            application, appCenter,
            Analytics::class.java, Crashes::class.java
        )
    }
}
