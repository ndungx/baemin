import 'package:baemin/constants.dart';
import 'package:baemin/screen/phone_form/phone_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PhoneFormButton extends StatefulWidget {
  const PhoneFormButton({Key? key}) : super(key: key);

  @override
  _PhoneFormButtonState createState() => _PhoneFormButtonState();
}

class _PhoneFormButtonState extends State<PhoneFormButton> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: kSecondaryColor.withOpacity(.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          height: 35,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/vietnam_flag.svg',
                height: 10,
              ),
              const SizedBox(width: 5),
              const Text(
                '+84',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                '|',
                style: TextStyle(
                  color: kSecondaryColor.withOpacity(.3),
                  fontSize: 20,
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.725,
                child: TextFormField(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: -15),
                    hintText: 'Số điện thoại',
                    hintStyle: TextStyle(
                      height: 0,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: InputBorder.none,
                  ),
                  controller: controller,
                  enabled: false,
                  maxLength: 10,
                  style: const TextStyle(color: kSecondaryColor, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  PhoneFormScreen.routeName,
                  arguments: PhoneFormArguments(controller: controller),
                );
              },
              splashColor: Colors.transparent,
            ),
          ),
        )
      ],
    );
  }
}
