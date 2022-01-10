import 'package:baemin/constants.dart';
import 'package:baemin/services/firebase/auth_service.dart';
import 'package:baemin/services/share_preferences/preferences_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    late AuthService _authService = AuthService(_auth);
    final _prefs = PreferencesService();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text(
                  'Thoát ra',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                titlePadding: const EdgeInsets.only(
                  top: 16,
                  left: 24,
                  right: 24,
                ),
                contentPadding: const EdgeInsets.only(
                  top: 16,
                  left: 24,
                  right: 24,
                ),
                content: const Text(
                  'Bạn có chắc chắn muốn thoát ra không? (hichic)',
                  style: TextStyle(fontSize: 12),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'VẪN Ở LẠI',
                      style: TextStyle(color: baeminColor[900], fontSize: 12),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _prefs.setSkipLogin(true);
                      _authService.signOut();
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: Text(
                      'THOÁT RA',
                      style: TextStyle(color: baeminColor[900], fontSize: 12),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: const Text(
          'Thoát ra',
          style: TextStyle(color: baeminColor, fontSize: 10),
        ),
      ),
    );
  }
}
