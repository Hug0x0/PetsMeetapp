import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  static final CameraPosition _initialPoition = CameraPosition(
      target: LatLng(48.82930066474196, 2.2875759067459267), zoom: 15);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialPoition,
      ),
    );
  }
}
// class Maps extends StatefulWidget {
//   @override
//   _MapsState createState() => _MapsState();
// }

// class _MapsState extends State<Maps> {
//   GoogleMapController _controller;

//   final CameraPosition _initialPosition =
//       CameraPosition(target: LatLng(24.903623, 67.198367));

//   final List<Marker> markers = [];

//   addMarker(cordinate) {
//     int id = Random().nextInt(100);

//     setState(() {
//       markers
//           .add(Marker(position: cordinate, markerId: MarkerId(id.toString())));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         initialCameraPosition: _initialPosition,
//         mapType: MapType.normal,
//         onMapCreated: (controller) {
//           setState(() {
//             _controller = controller;
//           });
//         },
//         markers: markers.toSet(),
//         onTap: (cordinate) {
//           _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
//           addMarker(cordinate);
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _controller.animateCamera(CameraUpdate.zoomOut());
//         },
//         child: Icon(Icons.zoom_out),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

// class Maps extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text("maps"),
//     );
//   }
// }
