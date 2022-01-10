import 'package:flutter/material.dart';

class EmailForm extends StatelessWidget {
  const EmailForm({Key? key, required this.emailController}) : super(key: key);

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailController,
      onChanged: (value) => emailController.value.copyWith(text: value),
      decoration: InputDecoration(
        label: const Text('Email', style: TextStyle(fontSize: 14)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: InputBorder.none,
        suffixIcon: false //isAuthEmail
            ? null
            : Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Transform.rotate(
                  angle: 3.14,
                  child: const Icon(
                    Icons.info,
                    color: Colors.orange,
                    size: 14,
                  ),
                ),
              ),
      ),
      style: const TextStyle(
        fontSize: 12,
        height: 1.7,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
