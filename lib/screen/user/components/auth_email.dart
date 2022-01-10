import 'package:baemin/constants.dart';
import 'package:flutter/material.dart';

class AuthEmail extends StatelessWidget {
  const AuthEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 155,
              bottom: 10,
              left: 5,
              right: 5,
            ),
            child: Row(
              children: [
                Image.asset('assets/images/mail.gif', scale: 12),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Nhấn vào đây để xác thực email',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: const Text(
                        'Bạn sẽ nhận được nhiều thông báo quan trọng và dùng email cho việc đặt lại mật khẩu.',
                        style: TextStyle(fontSize: 10, color: kSecondaryColor),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ),
        ),
      ],
    );
  }
}
