import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopMap extends StatelessWidget {
  const ShopMap({
    Key? key,
    required this.longitude,
    required this.latitude,
    required this.shopName,
  }) : super(key: key);

  final String shopName;
  final double longitude, latitude;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: GoogleMap(
        onMapCreated: (GoogleMapController controller) {},
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 15,
        ),
        rotateGesturesEnabled: false,
        scrollGesturesEnabled: false,
        tiltGesturesEnabled: false,
        zoomControlsEnabled: false,
        liteModeEnabled: true,
        markers: {
          Marker(
            markerId: MarkerId(shopName),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(title: shopName),
          ),
        },
      ),
    );
  }
}
