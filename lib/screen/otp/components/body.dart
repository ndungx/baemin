import 'package:baemin/constants.dart';
import 'package:baemin/screen/name_form/name_form_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.phoneNumber}) : super(key: key);

  final String phoneNumber;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _pinEditingController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();
  String? verificationCode;
  final DateTime _codeExpiry = DateTime.now().add(const Duration(seconds: 60));
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final BoxDecoration pinOTPCodeDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(5.0),
    border: Border.all(color: Colors.grey),
  );

  bool _isLoading = true;

  String phoneDecoration(String phoneNumber) {
    return phoneNumber.replaceAllMapped(
      RegExp(r'(\d{3})(\d{3,4})(\d{4})'),
      (Match match) {
        return '${match.group(1)} ${match.group(2)} ${match.group(3)}';
      },
    );
  }

  @override
  void initState() {
    super.initState();
    verifyPhoneNumber();
  }

  void verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+84' + widget.phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          await _auth.signInWithCredential(credential).then((value) => {
                if (value.user != null)
                  {
                    Navigator.of(context).pushNamed(
                      NameFormScreen.routeName,
                      arguments: NameFormScreenArguments(
                        phoneNumber: widget.phoneNumber,
                      ),
                    ),
                  }
              });
        } on FirebaseAuthException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message!)),
          );
        }
      },
      verificationFailed: (FirebaseAuthException ex) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(ex.message.toString()),
            duration: const Duration(seconds: 3),
          ),
        );
      },
      codeSent: (String verificationID, int? resendToken) {
        setState(() {
          verificationCode = verificationID;
          _isLoading = false;
        });
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        setState(() => verificationCode = verificationID);
      },
      timeout: const Duration(seconds: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mã OTP xác nhận',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Hãy điền OTP gồm 6 số vừa được gửi đến số',
                  style: TextStyle(color: kSecondaryColor, fontSize: 12),
                ),
                const SizedBox(height: 5),
                Text(
                  phoneDecoration(widget.phoneNumber),
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 25),
                PinPut(
                  fieldsCount: 6,
                  textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                  eachFieldWidth: 50,
                  eachFieldHeight: 50,
                  focusNode: _pinFocusNode,
                  autofocus: true,
                  autofillHints: const [AutofillHints.oneTimeCode],
                  pinAnimationType: PinAnimationType.fade,
                  controller: _pinEditingController,
                  submittedFieldDecoration: pinOTPCodeDecoration,
                  selectedFieldDecoration: pinOTPCodeDecoration.copyWith(
                    color: Colors.white,
                    border: Border.all(width: 2, color: baeminColor),
                  ),
                  followingFieldDecoration: pinOTPCodeDecoration,
                  onSubmit: (pin) async {
                    try {
                      await _auth
                          .signInWithCredential(
                            PhoneAuthProvider.credential(
                              verificationId: verificationCode!,
                              smsCode: pin,
                            ),
                          )
                          .then((value) => {
                                if (value.user != null)
                                  {
                                    Navigator.of(context).pushNamed(
                                      NameFormScreen.routeName,
                                      arguments: NameFormScreenArguments(
                                        phoneNumber: widget.phoneNumber,
                                      ),
                                    )
                                  }
                              });
                    } catch (e) {
                      if (DateTime.now().compareTo(_codeExpiry) > 0) {
                        FocusScope.of(context).unfocus();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Mã OTP đã hết hạn'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      } else {
                        FocusScope.of(context).unfocus();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Sai mã OTP'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    }
                  },
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    const Text('Không nhận được mã?'),
                    const SizedBox(width: 5),
                    Stack(
                      children: [
                        const Text(
                          'Gửi lại',
                          style: TextStyle(
                            color: baeminColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(onTap: () => verifyPhoneNumber()),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          );
  }
}
