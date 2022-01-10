import 'package:baemin/screen/profile/components/body.dart';
import 'package:baemin/screen/profile/custom_appbar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: CustomAppBar(),
      ),
      body: Body(),
    );
  }
}
