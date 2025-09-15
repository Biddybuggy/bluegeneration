import 'package:flutter/foundation.dart' show
kIsWeb, kReleaseMode, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'home/home_screen.dart';
import 'login/login_screen.dart';
import 'route_generator/route_generator.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize camera list early (as you had it)
  cameras = await availableCameras();

  // Initialize Firebase (tolerate Android auto-init race)
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on FirebaseException catch (e) {
    if (e.code != 'duplicate-app') {
      rethrow;
    }
  }

  // --- Activate Firebase App Check (fixes "No AppCheckProvider installed") ---
  await _activateAppCheck();
  var pref = await SharedPreferences.getInstance();
  String userId = pref.getString("user_id") ?? "";
  bool loggedIn = userId!="";
  runApp(MyApp(loggedIn:loggedIn,));
}

Future<void> _activateAppCheck() async {
  // Choose providers per platform & build mode
  if (kIsWeb) {
    // For web you MUST provide your reCAPTCHA v3 site key
    await FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaV3Provider('YOUR_RECAPTCHA_V3_SITE_KEY'),
    );
  } else {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        await FirebaseAppCheck.instance.activate(
          androidProvider: kReleaseMode
              ? AndroidProvider.playIntegrity // release/prod
              : AndroidProvider.debug,         // debug/emulators
        );
        break;

      case TargetPlatform.iOS:
        await FirebaseAppCheck.instance.activate(
          // Use App Attest for strongest protection on supported devices.
          // If you hit device support issues, switch to .deviceCheck.
          appleProvider: kReleaseMode
              ? AppleProvider.appAttest       // release/prod
              : AppleProvider.debug,          // debug/simulators
        );
        break;

    // If you also build for macOS, Windows, Linux — use debug provider.
      default:
        await FirebaseAppCheck.instance.activate(
          androidProvider: AndroidProvider.debug,
          appleProvider: AppleProvider.debug,
        );
        break;
    }
  }

  // Ensure tokens refresh automatically
  await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);
}

class MyApp extends StatelessWidget {
  final bool loggedIn;
  const MyApp({super.key, required this.loggedIn});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: loggedIn ? HomeScreen.routeName : LoginScreen.routeName,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }

}



//  widget.loggedIn ? LoginScreen.routeName : HomeScreen.routeName
