import 'package:baemin/screen/phone_form/components/body.dart';
import 'package:flutter/material.dart';

class PhoneFormScreen extends StatelessWidget {
  const PhoneFormScreen({Key? key}) : super(key: key);

  static String routeName = '/phone_form';

  @override
  Widget build(BuildContext context) {
    final PhoneFormArguments args =
        ModalRoute.of(context)!.settings.arguments as PhoneFormArguments;
    return Scaffold(
      appBar: AppBar(
        leading: Material(
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        toolbarHeight: 35,
        actions: const [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: Text(
                '1/5',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Body(controller: args.controller),
    );
  }
}

class PhoneFormArguments {
  final TextEditingController controller;

  PhoneFormArguments({required this.controller});
}
