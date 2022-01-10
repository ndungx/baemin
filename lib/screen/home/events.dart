import 'package:baemin/models/event_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Events extends StatelessWidget {
  const Events({Key? key, required this.events}) : super(key: key);

  final List<EventDetailsModel> events;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...events
                .map((event) => Container(
                      width: MediaQuery.of(context).size.width * 0.51,
                      margin: const EdgeInsets.only(right: 10),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: CachedNetworkImage(
                              imageUrl: event.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            left: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event.eventTitle,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  event.eventDescription,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.white.withOpacity(0.3),
                                highlightColor: Colors.white.withOpacity(0.2),
                                onTap: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}
