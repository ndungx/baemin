import 'package:baemin/constants.dart';
import 'package:baemin/services/firebase/firestore_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AdvertisementCarousel extends StatefulWidget {
  const AdvertisementCarousel({Key? key}) : super(key: key);

  @override
  _AdvertisementCarouselState createState() => _AdvertisementCarouselState();
}

class _AdvertisementCarouselState extends State<AdvertisementCarousel> {
  List imgList = [];

  late FireStoreDB db;
  initialize() {
    db = FireStoreDB();
    db.initialize();
    db.getAdvertisementCarouselDoc().then((value) => {
          setState(() {
            imgList = value;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 190,
        autoPlay: true,
        viewportFraction: 0.9,
        enableInfiniteScroll: true,
        scrollDirection: Axis.horizontal,
      ),
      items: imgList
          .map(
            (item) => Padding(
              padding: const EdgeInsets.all(4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: kSecondaryColor.withOpacity(0.1),
                      child: Center(
                        child: Text(
                          'BAEMIN',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Baemin',
                            color: kSecondaryColor.withOpacity(.7),
                          ),
                        ),
                      ),
                    ),
                    CachedNetworkImage(
                      imageUrl: item['image'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
