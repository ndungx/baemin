import 'package:baemin/services/firebase/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  String userName = '';

  late FireStoreDB db;

  initialize() {
    db = FireStoreDB();
    db.initialize();
    db.userName.then((value) => {
          setState(() {
            userName = value;
          }),
        });
  }

  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser?.uid != null) initialize();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Expanded(
          child: InkWell(
            onTap: () => FirebaseAuth.instance.currentUser?.uid == null
                ? Navigator.pushNamed(context, '/login')
                : Navigator.pushNamed(context, '/profile'),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    FirebaseAuth.instance.currentUser?.uid == null
                        ? 'Đăng nhập'
                        : userName,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 14,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
