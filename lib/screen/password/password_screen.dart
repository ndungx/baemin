import 'package:baemin/screen/password/components/body.dart';
import 'package:flutter/material.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  static String routeName = '/password';

  @override
  Widget build(BuildContext context) {
    final PasswordArguments args =
        ModalRoute.of(context)!.settings.arguments as PasswordArguments;
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, size: 20),
          ),
        ),
        preferredSize: const Size.fromHeight(40),
      ),
      body: Body(phoneNumber: args.phoneNumber),
    );
  }
}

class PasswordArguments {
  final String phoneNumber;

  const PasswordArguments({required this.phoneNumber});
}
