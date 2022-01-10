import 'package:baemin/constants.dart';
import 'package:flutter/material.dart';

class PhoneForm extends StatelessWidget {
  const PhoneForm({Key? key, required this.phoneController}) : super(key: key);

  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: phoneController,
            enabled: false,
            decoration: const InputDecoration(
              label: Text('Số điện thoại', style: TextStyle(fontSize: 14)),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
            ),
            style: const TextStyle(
              fontSize: 12,
              height: 1.7,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Chỉnh sửa',
            style: TextStyle(color: baeminColor, fontSize: 10),
          ),
        ),
      ],
    );
  }
}
