package biz.efendim.driver

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.plugins.pathprovider.PathProviderPlugin
import io.flutter.view.FlutterMain
//import rekab.app.background_locator.LocatorService
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin
//import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService


class Application : FlutterApplication(), PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()
        //LocatorService.setPluginRegistrant(this)
        FlutterMain.startInitialization(this)
      //  FlutterFirebaseMessagingService.setPluginRegistrant(this)
    }

    override fun registerWith(registry: PluginRegistry?) {
        //FirebaseCloudMessagingPluginRegistrant.registerWith(registry)
        if (!registry!!.hasPlugin("io.flutter.plugins.sharedpreferences")) {
            SharedPreferencesPlugin.registerWith(registry!!.registrarFor("io.flutter.plugins.sharedpreferences"))
        }

    }
}