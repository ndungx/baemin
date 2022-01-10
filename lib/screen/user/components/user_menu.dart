import 'package:baemin/constants.dart';
import 'package:flutter/material.dart';

class UserMenu extends StatelessWidget {
  const UserMenu({Key? key, required this.text, this.press}) : super(key: key);

  final String text;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: press,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: kSecondaryColor.withOpacity(.1)),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 12),
            ],
          ),
        ),
      ),
    );
  }
}
