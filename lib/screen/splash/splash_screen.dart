import 'package:baemin/screen/home/home.dart';
import 'package:baemin/screen/location_permission/location_permission_screen.dart';
import 'package:baemin/screen/login/login_screen.dart';
import 'package:baemin/services/share_preferences/preferences_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  _checkLogin() async {
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(
      context,
      PageTransition(
        child: const InitializerWidget(),
        type: PageTransitionType.fade,
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 200),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/splash_screen.png',
          fit: BoxFit.cover,
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}

class InitializerWidget extends StatefulWidget {
  const InitializerWidget({Key? key}) : super(key: key);

  @override
  _InitializerWidetState createState() => _InitializerWidetState();
}

class _InitializerWidetState extends State<InitializerWidget> {
  final _prefs = PreferencesService();
  late FirebaseAuth _auth;
  late User? _user;

  bool _isLoading = true;
  bool _isSkipLogin = false;
  bool _isSetLocationPermission = false;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    _isLoading = false;
    _checkSkipLogin();
    _checkSkipLocationPermission();
  }

  void _checkSkipLogin() async {
    final _getSkipLogin = await _prefs.getSkipLogin();
    setState(() => _isSkipLogin = _getSkipLogin);
  }

  void _checkSkipLocationPermission() async {
    final _getSkipLocationPermission = await _prefs.getSkipLocationPermission();
    setState(() => _isSetLocationPermission = _getSkipLocationPermission);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : _user == null
            ? _isSkipLogin
                ? _isSetLocationPermission
                    ? const Home()
                    : const LocationPermissionScreen()
                : const LoginScreen()
            : _isSetLocationPermission
                ? const Home()
                : const LocationPermissionScreen();
  }
}
