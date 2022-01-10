import 'package:baemin/screen/shop_info/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShopInfoScreen extends StatelessWidget {
  const ShopInfoScreen({Key? key}) : super(key: key);

  static String routeName = '/shop_info';

  @override
  Widget build(BuildContext context) {
    ShopInfoArguments args =
        ModalRoute.of(context)!.settings.arguments! as ShopInfoArguments;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close, size: 18),
        ),
        title: const Text(
          'Thông tin thêm',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 35,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Body(
        businessHours: args.businessHours,
        latitude: args.latitude.toDouble(),
        longitude: args.longitude.toDouble(),
        shopAddress: args.shopAddress,
        shopName: args.shopName,
      ),
    );
  }
}

class ShopInfoArguments {
  final String shopName;
  final String shopAddress;
  final num latitude, longitude;
  final Map businessHours;

  ShopInfoArguments({
    required this.shopName,
    required this.shopAddress,
    required this.latitude,
    required this.longitude,
    required this.businessHours,
  });
}
