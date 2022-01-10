import 'package:baemin/constants.dart';
import 'package:baemin/screen/home/home.dart';
import 'package:baemin/screen/location_permission/location_permission_screen.dart';
import 'package:baemin/screen/login/components/phone_form_button.dart';
import 'package:baemin/services/firebase/auth_service.dart';
import 'package:baemin/services/share_preferences/preferences_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final AuthService _authService = AuthService(_auth);
  final _prefs = PreferencesService();

  bool _isLoading = false;
  bool _isSetLocationPermission = false;
  bool _isSkipLogin = false;

  @override
  void initState() {
    super.initState();
    _checkSkipLocationPermission();
    _checkSkipLogin();
  }

  void _checkSkipLocationPermission() async {
    final _getSkipLocationPermission = await _prefs.getSkipLocationPermission();
    setState(() => _isSetLocationPermission = _getSkipLocationPermission);
  }

  void _checkSkipLogin() async {
    final _getSkipLogin = await _prefs.getSkipLocationPermission();
    setState(() => _isSkipLogin = _getSkipLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!_isLoading) ...{
          Image.asset(
            'assets/images/login_screen_background.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/login_baemin_mascot.png',
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'BAEMIN CHÀO BẠN',
                      style: TextStyle(
                        fontFamily: 'Baemin',
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Hãy nhập sô điện thoại để tiếp tục nhé!',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                    const PhoneFormButton(),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1.0,
                            color: kSecondaryColor.withOpacity(.1),
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Hoặc đăng nhập bằng',
                          style: TextStyle(
                            color: kSecondaryColor.withOpacity(.5),
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 1.0,
                            color: kSecondaryColor.withOpacity(.1),
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        _authService.signInWithFacebook(
                          context: context,
                          beginState: () {
                            setState(() => _isLoading = true);
                          },
                          endState: () {
                            setState(() => _isLoading = false);
                          },
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/icons/facebook_logo.svg',
                        height: 50,
                      ),
                    ),
                    const SizedBox(height: 10),
                    !_isSkipLogin
                        ? GestureDetector(
                            onTap: () {
                              _prefs.setSkipLogin(true);
                              _isSetLocationPermission
                                  ? Navigator.pushReplacementNamed(
                                      context,
                                      Home.routeName,
                                    )
                                  : Navigator.pushReplacementNamed(
                                      context,
                                      LocationPermissionScreen.routeName,
                                    );
                            },
                            child: const Text(
                              'Để sau nha, mình muốn xem thêm chút nữa',
                              style: TextStyle(
                                color: kSecondaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            ),
          )
        } else ...{
          const Center(child: CircularProgressIndicator()),
        }
      ],
    );
  }
}
