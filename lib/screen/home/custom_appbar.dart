import 'package:baemin/constants.dart';
import 'package:baemin/screen/mailbox/mailbox_screen.dart';
import 'package:baemin/screen/user/user_screen.dart';
import 'package:baemin/services/firebase/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  List<String> listMailID = [];
  bool isHaveMailUnread = false;
  late FireStoreDB db;
  FirebaseAuth auth = FirebaseAuth.instance;

  initialize() {
    db = FireStoreDB();
    db.initialize();
    checkMail();
  }

  void checkMail() {
    db.getmailIDList().then(
      (value) {
        setState(() => listMailID = value);
        db.checkReadStatus(listMailID).then((value) {
          setState(() => isHaveMailUnread = value);
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController addressController = TextEditingController();

    return SizedBox(
      width: double.infinity,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.location_on,
                        color: baeminColor,
                        size: 15,
                      ),
                    ),
                    SizedBox(
                      width: FirebaseAuth.instance.currentUser != null
                          ? MediaQuery.of(context).size.width * 0.75
                          : MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        enabled: false,
                        controller: addressController,
                        decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          label: Text(
                            '220 Đường Nguyễn Hữu Cảnh, Vinhomes Tân Cảng, Bình Thạnh, Thành Phố Hồ Chí Minh',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        style: const TextStyle(
                          color: Colors.black45,
                          fontSize: 12,
                          decorationThickness: 0.0,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                      size: 12,
                    ),
                  ],
                ),
              ),
            ),
            auth.currentUser != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, MailboxScreen.routeName);
                      },
                      child: Stack(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(Icons.mail_outline_rounded, size: 16),
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('mailbox')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              checkMail();
                              return isHaveMailUnread
                                  ? const SizedBox.shrink()
                                  : const Positioned(
                                      right: 0,
                                      child: Icon(
                                        Icons.circle,
                                        color: Colors.orange,
                                        size: 4,
                                      ),
                                    );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.only(left: 2, right: 12),
              child: Material(
                child: InkWell(
                  child: const Icon(Icons.menu, size: 15, color: Colors.black),
                  onTap: () {
                    Navigator.pushNamed(context, UserScreen.routeName);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
