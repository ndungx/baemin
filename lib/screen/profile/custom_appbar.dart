import 'package:baemin/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, size: 20),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Center(
        child: Text(
          'Thông tin tài khoản',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text(
            'Cập nhật',
            style: TextStyle(color: baeminColor, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
