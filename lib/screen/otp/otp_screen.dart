import 'package:baemin/screen/otp/components/body.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  static String routeName = '/otp';

  @override
  Widget build(BuildContext context) {
    final OTPScreenArguments args =
        ModalRoute.of(context)!.settings.arguments as OTPScreenArguments;

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
                '2/5',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Body(phoneNumber: args.phoneNumber),
    );
  }
}

class OTPScreenArguments {
  final String phoneNumber;

  OTPScreenArguments({required this.phoneNumber});
}
