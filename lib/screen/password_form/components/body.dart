import 'package:baemin/constants.dart';
import 'package:baemin/screen/password_form/components/password_form.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.phoneNumber, required this.name})
      : super(key: key);

  final String phoneNumber;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Đặt mật khẩu',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Độ dài mật khẩu ít nhất là 6 ký tự',
            style: TextStyle(
              color: kSecondaryColor,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          PasswordForm(
            phoneNumber: phoneNumber,
            name: name,
          ),
        ],
      ),
    );
  }
}
