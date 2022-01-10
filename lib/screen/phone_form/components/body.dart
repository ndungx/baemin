import 'package:baemin/components/default_button.dart';
import 'package:baemin/constants.dart';
import 'package:baemin/screen/otp/otp_screen.dart';
import 'package:baemin/screen/password/password_screen.dart';
import 'package:baemin/services/firebase/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isValid = false;

  late FireStoreDB db;

  @override
  void initState() {
    super.initState();
    db = FireStoreDB();
    db.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            children: [
              Text(
                'Nhập số điện thoại của bạn để tiếp tục nhé',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.048,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 35,
                      child: TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        controller: widget.controller,
                        cursorColor: baeminColor.shade900,
                        cursorWidth: 1,
                        maxLength: 10,
                        style: const TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          prefix: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/vietnam_flag.svg',
                                height: 10,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                '+84',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '|',
                                style: TextStyle(
                                  color: kSecondaryColor.withOpacity(.4),
                                  fontSize: 20,
                                  height: 1,
                                ),
                              ),
                              const SizedBox(width: 4),
                            ],
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.grey.withOpacity(.6),
                              size: 16,
                            ),
                            onPressed: () => widget.controller.clear(),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                          ),
                          hintText: 'Số điện thoại',
                          counterText: "",
                          hintStyle: const TextStyle(height: .2),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        onChanged: (value) {
                          if (phoneValidatorRegExp.hasMatch(value)) {
                            setState(() {
                              _isValid = true;
                            });
                          } else {
                            setState(() {
                              _isValid = false;
                            });
                          }
                        },
                      ),
                    ),
                    _isValid
                        ? DefaultButton(
                            text: 'Tiếp theo',
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textColor: Colors.white,
                            backgroundColor: baeminColor,
                            height: 35,
                            enabled: true,
                            press: () {
                              db
                                  .checkAccountExists(widget.controller.text)
                                  .then((accountExists) => accountExists
                                      ? Navigator.of(context).pushNamed(
                                          PasswordScreen.routeName,
                                          arguments: PasswordArguments(
                                            phoneNumber: widget.controller.text,
                                          ),
                                        )
                                      : Navigator.of(context).pushNamed(
                                          OTPScreen.routeName,
                                          arguments: OTPScreenArguments(
                                            phoneNumber: widget.controller.text,
                                          ),
                                        ));
                            },
                          )
                        : DefaultButton(
                            text: 'Tiếp theo',
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textColor: Colors.white,
                            backgroundColor: kSecondaryColor.withOpacity(.2),
                            height: 35,
                          )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
