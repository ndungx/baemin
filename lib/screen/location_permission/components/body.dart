import 'package:baemin/constants.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/location_permission_baemin_mascot.png',
            width: MediaQuery.of(context).size.width * 0.6,
          ),
          const SizedBox(height: 35),
          Text(
            'BAEMIN CẦN TRUY CẬP\nVỊ TRÍ CỦA BẠN',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              color: Colors.black.withOpacity(0.8),
              fontWeight: FontWeight.bold,
              fontFamily: 'Baemin',
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Giúp tài xế của chúng tôi giao đến địa chỉ của bạn và xem các khuyến mãi gần đây',
            textAlign: TextAlign.center,
            style: TextStyle(color: kSecondaryColor, fontSize: 12, height: 1.5),
          )
        ],
      ),
    );
  }
}
