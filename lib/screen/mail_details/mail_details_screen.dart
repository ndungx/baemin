import 'package:baemin/screen/mail_details/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MailDetailsScreen extends StatelessWidget {
  const MailDetailsScreen({Key? key}) : super(key: key);

  static String routeName = '/mail_details';

  @override
  Widget build(BuildContext context) {
    final MailDetailsArguments args =
        ModalRoute.of(context)!.settings.arguments as MailDetailsArguments;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0,
      ),
      body: Body(title: args.title, content: args.content),
    );
  }
}

class MailDetailsArguments {
  final String title;
  final String content;

  const MailDetailsArguments({
    required this.title,
    required this.content,
  });
}
