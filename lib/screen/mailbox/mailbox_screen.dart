import 'package:baemin/constants.dart';
import 'package:baemin/screen/mailbox/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MailboxScreen extends StatelessWidget {
  const MailboxScreen({Key? key}) : super(key: key);

  static String routeName = '/mailbox';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          backgroundColor: baeminColor.withOpacity(0.03),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
          ),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 20),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Hộp thư',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
      ),
      body: const Body(),
    );
  }
}
