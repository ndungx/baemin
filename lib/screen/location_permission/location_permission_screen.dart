import 'package:baemin/screen/location_permission/components/body.dart';
import 'package:baemin/screen/sign_up_success/sign_up_success_screen.dart';
import 'package:baemin/services/share_preferences/preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationPermissionScreen extends StatefulWidget {
  const LocationPermissionScreen({Key? key}) : super(key: key);

  static String routeName = '/location_permission';

  @override
  State<LocationPermissionScreen> createState() {
    return _LocationPermissionScreenState();
  }
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {
  final Location location = Location();
  final _prefs = PreferencesService();

  PermissionStatus _permissionGranted = PermissionStatus.denied;

  Future<void> _requestPermission() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final PermissionStatus permissionRequestedResult =
          await location.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestedResult;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Body(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 32),
        child: Container(
          width: double.infinity,
          height: 35,
          margin: const EdgeInsets.only(bottom: 16),
          child: FloatingActionButton.extended(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onPressed: () {
              _requestPermission()
                  .then((value) => _prefs.setSkipLocationPermission(true))
                  .then((value) => Navigator.pushReplacementNamed(
                        context,
                        SignUpSuccessScreen.routeName,
                      ));
            },
            label: const Text(
              'Tiếp tục',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                letterSpacing: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
