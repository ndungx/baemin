import 'package:baemin/screen/shop_details/components/chip_button.dart';
import 'package:flutter/material.dart';

class ShopRaingDetails extends StatelessWidget {
  const ShopRaingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: const [
          ChipButton(
            avatar: 'assets/images/yummy.png',
            label: 'Ngon xỉu!',
            ratingCount: 17,
          ),
        ],
      ),
    );
  }
}
