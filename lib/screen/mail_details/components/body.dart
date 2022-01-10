import 'package:baemin/constants.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.title, required this.content})
      : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Text(title),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset('assets/images/gift.png', scale: 1.4),
                  ),
                ),
              ],
            ),
          ),
          Text(
            content
                .replaceAll("\\n", "\n")
                .replaceAll("\\t", "\t")
                .replaceAll('*', '•')
                .replaceAll('<br>', '\n\n'),
            style: const TextStyle(fontSize: 11, color: kSecondaryColor),
          )
        ],
      ),
    );
  }
}
