import 'package:baemin/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SignUpSuccessScreen extends StatefulWidget {
  const SignUpSuccessScreen({Key? key}) : super(key: key);

  static String routeName = '/signup_success';

  @override
  State<SignUpSuccessScreen> createState() => _SignUpSuccessScreenState();
}

class _SignUpSuccessScreenState extends State<SignUpSuccessScreen> {
  @override
  initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      PageTransition(
        child: const Home(),
        type: PageTransitionType.fade,
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 200),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.popAndPushNamed(
            context,
            Home.routeName,
          ),
        ),
      ),
      body: Center(
        child: Image.asset(
          'assets/images/sign_up_success_background.png',
          fit: BoxFit.cover,
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}
