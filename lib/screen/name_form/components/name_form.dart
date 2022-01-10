import 'package:baemin/components/default_button.dart';
import 'package:baemin/constants.dart';
import 'package:baemin/screen/password_form/password_form_screen.dart';
import 'package:flutter/material.dart';

class NameForm extends StatefulWidget {
  const NameForm({Key? key, required this.phoneNumber}) : super(key: key);

  final String phoneNumber;

  @override
  _NameFormState createState() => _NameFormState();
}

class _NameFormState extends State<NameForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final _textFieldFocusNode = FocusNode();

  bool _notEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 35,
              child: TextFormField(
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      _notEmpty = true;
                    });
                  } else {
                    setState(() {
                      _notEmpty = false;
                    });
                  }
                },
                validator: (value) {
                  if (value!.length < 2) {
                    setState(() {
                      _notEmpty = false;
                    });
                    return;
                  }
                },
                controller: _controller,
                cursorWidth: 1,
                focusNode: _textFieldFocusNode,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Họ tên của bạn',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: baeminColor, width: 1),
                  ),
                  suffix: _notEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Material(
                            child: InkWell(
                              onTap: () {
                                _controller.clear();
                                setState(() {
                                  _notEmpty = false;
                                  if (_textFieldFocusNode.hasPrimaryFocus) {
                                    return;
                                  }
                                  _textFieldFocusNode.canRequestFocus = false;
                                });
                              },
                              splashColor: Colors.transparent,
                              child: Icon(
                                Icons.cancel,
                                size: 14,
                                color: kSecondaryColor.withOpacity(.4),
                              ),
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            ),
            _notEmpty
                ? DefaultButton(
                    text: 'Tiếp theo',
                    textColor: Colors.white,
                    backgroundColor: baeminColor,
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushNamed(
                          context,
                          PasswordFormScreen.routeName,
                          arguments: PasswordFormArguments(
                            phoneNumber: widget.phoneNumber,
                            name: _controller.text,
                          ),
                        );
                      }
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
    );
  }
}
