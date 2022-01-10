import 'package:baemin/screen/shop_details/components/body.dart';
import 'package:flutter/material.dart';

class ShopDetailsScreen extends StatelessWidget {
  const ShopDetailsScreen({Key? key}) : super(key: key);

  static String routeName = '/shop_details';

  @override
  Widget build(BuildContext context) {
    final ShopDetailsArguments args =
        ModalRoute.of(context)!.settings.arguments as ShopDetailsArguments;
    return Scaffold(
      body: Body(shopID: args.shopID),
    );
  }
}

class ShopDetailsArguments {
  final String shopID;

  ShopDetailsArguments({required this.shopID});
}
