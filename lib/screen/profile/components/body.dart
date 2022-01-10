import 'package:baemin/components/default_button.dart';
import 'package:baemin/constants.dart';
import 'package:baemin/screen/profile/components/email_form.dart';
import 'package:baemin/screen/profile/components/logout_button.dart';
import 'package:baemin/screen/profile/components/name_form.dart';
import 'package:baemin/screen/profile/components/password_form.dart';
import 'package:baemin/screen/profile/components/phone_form.dart';
import 'package:baemin/services/firebase/firestore_service.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late FireStoreDB db;

  initialize() {
    db = FireStoreDB();
    db.initialize();
    db.phoneNumber.then((value) => phoneController.text = value);
    db.userName.then((value) => nameController.text = value);
    db.email.then((value) => emailController.text = value);
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height - 100,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  PhoneForm(phoneController: phoneController),
                  const SizedBox(height: 22),
                  NameForm(nameController: nameController),
                  const SizedBox(height: 20),
                  EmailForm(emailController: emailController),
                ],
              ),
            ),
            Container(
              color: baeminColor.withOpacity(0.03),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Text(
                      'Bạn sẽ nhận được nhiều thông báo quan trọng và dùng email cho việc đặt lại mật khẩu.',
                      style: TextStyle(color: kSecondaryColor, fontSize: 11),
                    ),
                    const SizedBox(height: 10),
                    DefaultButton(
                      text: 'XÁC THỰC EMAIL',
                      height: 30,
                      textStyle: const TextStyle(
                        fontSize: 12,
                        color: baeminColor,
                      ),
                      backgroundColor: Colors.white,
                      press: () {},
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PasswordForm(passwordController: passwordController),
                  const LogoutButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
