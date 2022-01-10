import 'package:baemin/constants.dart';
import 'package:baemin/models/mailbox.dart';
import 'package:baemin/screen/mailbox/components/gift_box.dart';
import 'package:baemin/services/firebase/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<String> listMailID = [];
  List<MailboxModel> listMail = [];
  User? user = FirebaseAuth.instance.currentUser;
  List<Widget> listMailBoxWidget = [];

  late FireStoreDB db;

  initialize() {
    db = FireStoreDB();
    db.initialize();
    db.getmailIDList().then(
      (value) {
        setState(() => listMailID = value);
        db.getMailbox(listMailID).then((value) {
          setState(() => listMail = value);
        });
      },
    );
  }

  updateReadStatus(String mailID) {
    db.updateMailboxReadStatus(mailID);
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        listMailID.clear();
        listMail.clear();
        listMailBoxWidget.clear();
        return db.getmailIDList().then(
          (value) {
            setState(() => listMailID = value);
            db.getMailbox(listMailID).then((value) {
              setState(() => listMail = value);
            });
          },
        );
      },
      child: listMailID.isEmpty
          ? Container(
              width: double.infinity,
              color: baeminColor.withOpacity(0.03),
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/mailbox_empty.png', scale: 1.3),
                  const SizedBox(height: 10),
                  const Text(
                    'Đang hóng tin nhắn đầu tiên...',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'BAEMIN sẽ sớm trở lại, lợi hại hơn xưa!',
                    style: TextStyle(color: kSecondaryColor, fontSize: 12),
                  )
                ],
              ),
            )
          : StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('mailbox').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    width: double.infinity,
                    color: baeminColor.withOpacity(0.03),
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/mailbox_empty.png',
                            scale: 1.3),
                        const SizedBox(height: 10),
                        const Text(
                          'Đang hóng tin nhắn đầu tiên...',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'BAEMIN sẽ sớm trở lại, lợi hại hơn xưa!',
                          style:
                              TextStyle(color: kSecondaryColor, fontSize: 12),
                        )
                      ],
                    ),
                  );
                }
                return Container(
                  color: baeminColor.withOpacity(0.03),
                  padding: const EdgeInsets.all(12.0),
                  child: ListView(
                    children: snapshot.data!.docs.map(
                      (DocumentSnapshot document) {
                        MailBox? mailbox;
                        listMailID.contains(document.id)
                            ? mailbox = MailBox(
                                id: document.id,
                                title: document['title'],
                                content: document['content'],
                                isRead: document['isRead'],
                                onPress: () => updateReadStatus(document.id),
                              )
                            : null;
                        return Column(
                          children: [
                            mailbox ?? const SizedBox.shrink(),
                          ],
                        );
                      },
                    ).toList(),
                  ),
                );
              },
            ),
    );
  }
}
