import 'package:baemin/screen/mail_details/mail_details_screen.dart';
import 'package:flutter/material.dart';

class MailBox extends StatelessWidget {
  const MailBox({
    Key? key,
    required this.id,
    required this.title,
    required this.content,
    required this.isRead,
    required this.onPress,
  }) : super(key: key);

  final String id;
  final String title;
  final String content;
  final bool isRead;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.withOpacity(.3)),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.4),
                offset: const Offset(0, 1),
                blurRadius: 0,
              ),
            ],
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 10,
                  right: 10,
                  bottom: 60,
                ),
                child: Text(
                  title,
                  style: TextStyle(fontWeight: isRead ? null : FontWeight.bold),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, bottom: 5),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 6, top: 6),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.circle,
                              size: 40,
                              color: Colors.grey.withOpacity(.1),
                            ),
                            Image.asset(
                              'assets/images/gift.png',
                              scale: 1.4,
                            ),
                          ],
                        ),
                      ),
                      isRead
                          ? const SizedBox.shrink()
                          : const Positioned(
                              right: 8,
                              top: 8,
                              child: Icon(
                                Icons.circle,
                                color: Colors.orange,
                                size: 7,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: Colors.grey.withOpacity(.1),
              splashColor: Colors.grey.withOpacity(.2),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MailDetailsScreen.routeName,
                  arguments: MailDetailsArguments(
                    title: title,
                    content: content,
                  ),
                );
                onPress();
              },
            ),
          ),
        )
      ],
    );
  }
}
