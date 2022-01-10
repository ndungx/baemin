import 'package:baemin/screen/loved_shop/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LovedShopScreen extends StatelessWidget {
  const LovedShopScreen({Key? key}) : super(key: key);

  static String routeName = '/loved_shop';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, size: 18),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 35,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text(
          'Nhà hàng yêu thích',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const Body(),
    );
  }
}
