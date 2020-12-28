package com.example.android_bridger

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import me.leolin.shortcutbadger.ShortcutBadger


class MainActivity: FlutterActivity() {

    companion object {
        const val CHANNEL = "com.example.android_bridger.channel"
        const val SET_BADGE_KEY_NATIVE = "IncreaseBadge"
        const val REMOVE_BADGE_KEY_NATIVE = "RemoveBadge"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        var counter = 0
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            print(call.method)

            if (call.method == SET_BADGE_KEY_NATIVE) {
                counter += 1
                ShortcutBadger.applyCount(this@MainActivity, counter)
                result.success("$counter")
            } else {
                ShortcutBadger.removeCount(this@MainActivity)
                counter = 0
                result.success("$counter")
            }
        }
    }


}
