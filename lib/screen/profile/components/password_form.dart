import 'package:flutter/material.dart';

class PasswordForm extends StatelessWidget {
  const PasswordForm({Key? key, required this.passwordController})
      : super(key: key);

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: passwordController,
        onChanged: (value) => passwordController.value.copyWith(text: value),
        obscureText: true,
        decoration: InputDecoration(
          label: const Text('Mật khẩu', style: TextStyle(fontSize: 14)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.only(bottom: 6, top: 10),
          hintText: '••••••••••••••••',
          hintStyle: TextStyle(
            fontSize: 12,
            color: Colors.grey.withOpacity(.5),
          ),
        ),
        style: const TextStyle(
          fontSize: 12,
          height: 1.7,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
