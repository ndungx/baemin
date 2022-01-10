import 'package:baemin/screen/login/components/body.dart';
import 'package:baemin/services/local_notification/local_notification_service.dart';
import 'package:baemin/services/share_preferences/preferences_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _prefs = PreferencesService();
  bool _isSkipLogin = false;

  void _checkSkipLogin() async {
    final _getSkipLogin = await _prefs.getSkipLocationPermission();
    setState(() => _isSkipLogin = _getSkipLogin);
  }

  @override
  void initState() {
    super.initState();

    _checkSkipLogin();

    getFCMToken();

    LocalNotificationService.initialize(context);

    // give message on which user taps and it opened the app from terminated state (app close)
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];
        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    // just in foreground (app must open)
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
      }

      LocalNotificationService.display(message);
    });

    // this just work when app in background (app not open) and user taps on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];
      Navigator.of(context).pushNamed(routeFromMessage);
    });
  }

  void getFCMToken() async {
    var token = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _isSkipLogin
          ? AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            )
          : null,
      body: const Body(),
    );
  }
}
