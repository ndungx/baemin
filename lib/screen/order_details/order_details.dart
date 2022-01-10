import 'package:baemin/constants.dart';
import 'package:baemin/screen/order_details/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  static String routeName = '/order_details';

  @override
  Widget build(BuildContext context) {
    OrderDetailsArguments args =
        ModalRoute.of(context)!.settings.arguments as OrderDetailsArguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 30,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          icon: const Icon(Icons.close, size: 20, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Hỗ trợ',
              style: TextStyle(color: baeminColor, fontSize: 10),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFebf0f5),
      body: Body(orderID: args.orderId),
    );
  }
}

class OrderDetailsArguments {
  final String orderId;

  OrderDetailsArguments(this.orderId);
}
