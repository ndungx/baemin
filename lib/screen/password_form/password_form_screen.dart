import 'package:baemin/screen/password_form/components/body.dart';
import 'package:flutter/material.dart';

class PasswordFormScreen extends StatelessWidget {
  const PasswordFormScreen({Key? key}) : super(key: key);

  static String routeName = '/password_form';

  @override
  Widget build(BuildContext context) {
    final PasswordFormArguments args =
        ModalRoute.of(context)!.settings.arguments as PasswordFormArguments;
    return Scaffold(
      appBar: AppBar(
        leading: Material(
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
          ),
        ),
        toolbarHeight: 35,
        actions: const [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: Text(
                '4/5',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Body(phoneNumber: args.phoneNumber, name: args.name),
    );
  }
}

class PasswordFormArguments {
  final String phoneNumber;
  final String name;

  PasswordFormArguments({required this.phoneNumber, required this.name});
}
