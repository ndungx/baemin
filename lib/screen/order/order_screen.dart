import 'package:baemin/screen/order/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  static String routeName = '/order';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, size: 20),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 40,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text(
          'Đơn hàng của tôi',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        centerTitle: true,
      ),
      body: const Body(),
    );
  }
}
