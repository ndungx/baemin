import 'package:flutter/material.dart';

class NameForm extends StatelessWidget {
  const NameForm({Key? key, required this.nameController}) : super(key: key);

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: nameController,
      onChanged: (value) => nameController.value.copyWith(text: value),
      decoration: const InputDecoration(
        label: Text('Tên', style: TextStyle(fontSize: 14)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.only(bottom: 6, top: 10),
      ),
      style: const TextStyle(
        fontSize: 12,
        height: 1.7,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
