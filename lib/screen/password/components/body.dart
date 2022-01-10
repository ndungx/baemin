import 'package:baemin/components/default_button.dart';
import 'package:baemin/constants.dart';
import 'package:baemin/screen/home/home.dart';
import 'package:baemin/services/firebase/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.phoneNumber}) : super(key: key);

  final String phoneNumber;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _textFieldFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late AuthService _authService = AuthService(_auth);

  bool _valid = false;
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (_textFieldFocusNode.hasPrimaryFocus) {
        return;
      }
      _textFieldFocusNode.canRequestFocus = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nhập mật khẩu',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Số điện thoại dùng đăng ký là ${widget.phoneNumber}',
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 10),
          Form(
            key: _formKey,
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 35,
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.length >= 6 &&
                            value.length <= 24 &&
                            RegExp('^[a-z A-Z 1-9]{6,24}\$').hasMatch(value)) {
                          setState(() {
                            _valid = true;
                          });
                        } else {
                          setState(() {
                            _valid = false;
                          });
                        }
                      },
                      validator: (value) {
                        if (value!.length < 6 &&
                            RegExp('^[a-z A-Z 1-9]{6,24}\$').hasMatch(value)) {
                          setState(() {
                            _valid = false;
                          });
                          return;
                        } else {
                          setState(() {
                            _valid = true;
                          });
                        }
                      },
                      controller: _controller,
                      cursorWidth: 1,
                      style: const TextStyle(fontSize: 14),
                      focusNode: _textFieldFocusNode,
                      obscureText: _obscured,
                      autocorrect: false,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(' '),
                      ],
                      decoration: InputDecoration(
                        hintText: 'Mật khẩu',
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              const BorderSide(color: baeminColor, width: 1),
                        ),
                        suffix: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _valid
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          _controller.clear();
                                          setState(() {
                                            _valid = false;
                                          });
                                        },
                                        splashColor: Colors.transparent,
                                        child: Icon(
                                          Icons.cancel,
                                          size: 14,
                                          color:
                                              kSecondaryColor.withOpacity(.4),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: 25,
                              child: GestureDetector(
                                onTap: _toggleObscured,
                                child: Text(
                                  _obscured ? 'HIỆN' : 'ẨN',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: kSecondaryColor,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _valid
                      ? DefaultButton(
                          text: 'Tiếp theo',
                          textColor: Colors.white,
                          backgroundColor: baeminColor,
                          press: () {
                            if (_formKey.currentState!.validate()) {
                              // _authService.signIn(
                              //   phoneNumber: widget.phoneNumber,
                              //   password: _controller.text,
                              // );
                            }
                            Navigator.pushReplacementNamed(
                              context,
                              Home.routeName,
                            );
                          },
                        )
                      : DefaultButton(
                          text: 'Tiếp theo',
                          textColor: Colors.white,
                          backgroundColor: kSecondaryColor.withOpacity(.4),
                        )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
