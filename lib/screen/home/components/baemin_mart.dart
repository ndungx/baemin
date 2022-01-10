import 'package:baemin/models/event_details.dart';
import 'package:baemin/screen/home/events.dart';
import 'package:baemin/services/firebase/firestore_service.dart';
import 'package:flutter/material.dart';

class BaeminMart extends StatefulWidget {
  const BaeminMart({Key? key}) : super(key: key);

  @override
  _BaeminMartState createState() => _BaeminMartState();
}

class _BaeminMartState extends State<BaeminMart> {
  Map topBrand = {};
  List<EventDetailsModel> listEventDetails = [];

  late FireStoreDB db;
  initialize() {
    db = FireStoreDB();
    db.initialize();
    db.getEvent(eventName: 'baemin_mart').then((value) {
      setState(() {
        topBrand = value;
      });
      db.getEventsDetails(listDocID: topBrand['list_event']).then(
            (value) => setState(() => listEventDetails = value),
          );
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return topBrand.isNotEmpty
        ? Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topBrand['title'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Events(events: listEventDetails)
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
