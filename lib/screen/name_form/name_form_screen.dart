import 'package:baemin/screen/name_form/components/body.dart';
import 'package:flutter/material.dart';

class NameFormScreen extends StatelessWidget {
  const NameFormScreen({Key? key}) : super(key: key);

  static String routeName = '/name_form';

  @override
  Widget build(BuildContext context) {
    final NameFormScreenArguments args =
        ModalRoute.of(context)!.settings.arguments as NameFormScreenArguments;

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
                '3/5',
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

class NameFormScreenArguments {
  final String phoneNumber;

  NameFormScreenArguments({required this.phoneNumber});
}
