import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future setSkipLogin(bool value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isSkipLogin', value);
  }

  Future<bool> getSkipLogin() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool('isSkipLogin') ?? false;
  }

  Future setSkipLocationPermission(bool value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isSkipLocationPermisson', value);
  }

  Future<bool> getSkipLocationPermission() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool('isSkipLocationPermisson') ?? false;
  }
}
