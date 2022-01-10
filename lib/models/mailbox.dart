import 'package:cloud_firestore/cloud_firestore.dart';

class MailboxModel {
  final String id;
  final String title;
  final String content;
  final Timestamp timestamp;
  final bool isRead;

  MailboxModel({
    required this.id,
    required this.title,
    required this.content,
    required this.timestamp,
    required this.isRead,
  });
}
