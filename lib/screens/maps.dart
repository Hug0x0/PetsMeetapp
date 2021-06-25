import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Strolls {
  String hour;
  String longitude;
  String creatorUid;
  String latitude;
  String date;
  String description;
  String creator;
  String participants;
  String place;

  Strolls(
      {this.hour,
      this.longitude,
      this.creatorUid,
      this.latitude,
      this.date,
      this.description,
      this.creator,
      this.participants,
      this.place});

  Strolls.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    longitude = json['longitude'];
    creatorUid = json['creator_uid'];
    latitude = json['latitude'];
    date = json['date'];
    description = json['description'];
    creator = json['creator'];
    participants = json['participants'];
    place = json['place'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hour'] = this.hour;
    data['longitude'] = this.longitude;
    data['creator_uid'] = this.creatorUid;
    data['latitude'] = this.latitude;
    data['date'] = this.date;
    data['description'] = this.description;
    data['creator'] = this.creator;
    data['participants'] = this.participants;
    data['place'] = this.place;
    return data;
  }
}

List<String> positionlong = [];
List<String> positionlat = [];

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  GoogleMapController myControllers;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  var latitude;
  var longitude;
  Set<Marker> _markers = {};
  List<Marker> list = [];
  @override
  void initState() {
    _generateMarker(positionlat, positionlong);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getPosLong();
    _getPosLat();

    return Scaffold(
      body: GoogleMap(
        markers: Set<Marker>.of(list),
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: LatLng(48.82930066474196, 2.2875759067459267), zoom: 14.0),
        onMapCreated: (GoogleMapController controller) {
          myControllers = controller;
        },
      ),
    );
  }

  _getPosLong() {
    positionlong.clear();
    FirebaseFirestore.instance
        .collection('strolls')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((result) {
        Strolls strolls =
            Strolls.fromJson(jsonDecode(jsonEncode(result.data())));
        longitude = strolls.longitude;

        positionlong.add(longitude);
        return;
      });
    });
  }

  _getPosLat() {
    positionlat.clear();
    FirebaseFirestore.instance
        .collection('strolls')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((result) {
        Strolls strolls =
            Strolls.fromJson(jsonDecode(jsonEncode(result.data())));
        latitude = strolls.latitude;
        positionlat.add(latitude);
        return;
      });
    });
  }

  _generateMarker(positionlat, positionlong) {
    for (var i = 0; i < positionlong.length; i++) {
      Marker $i = Marker(
        markerId: MarkerId('$i'),
        position:
            LatLng(double.parse(positionlat[i]), double.parse(positionlong[i])),
        infoWindow: InfoWindow(title: 'Business 1'),
        icon: BitmapDescriptor.defaultMarker,
      );
      list.add($i);
    }
  }
}
