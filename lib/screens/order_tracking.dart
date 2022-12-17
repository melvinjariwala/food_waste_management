import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class order_tracking extends StatefulWidget {
  const order_tracking({Key? key}) : super(key: key);

  @override
  State<order_tracking> createState() => _order_trackingState();
}

class _order_trackingState extends State<order_tracking> {
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;
  static const LatLng loc = LatLng(21.132491, 72.718694);

  var currentLocation;

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((location) {
      currentLocation = location;
    });
    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
              CameraPosition(
                zoom: 18,
                  target: LatLng(
                      currentLocation?.latitude ?? 21.132549782626786,
                      currentLocation.longitude ?? 72.71880943360438
                  )
              )
          )
      );
      setState(() {

      });
    });
  }

  void _onMapCreated(GoogleMapController controller){
    mapController = controller;
  }

  @override
  void initState(){
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 255, 236),
      appBar: AppBar(
        title: const Text("Order Tracking"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 100, 162, 93),
      ),
      body: //currentLocation == null
          //? const Center(child: CircularProgressIndicator(
        //color: Color.fromARGB(255, 100, 162, 93),
      //))
      GoogleMap(
        onMapCreated: (mapController){
          _controller.complete(mapController);
        },
        initialCameraPosition: CameraPosition(
            target: LatLng(currentLocation?.latitude ?? 21.132549782626786, currentLocation?.longitude ?? 72.71880943360438),
          zoom: 18.0,
        ),
        markers: {
            Marker(
                markerId: const MarkerId("My Location"),
              position: LatLng(currentLocation?.latitude ?? 21.132549782626786, currentLocation?.longitude ?? 72.71880943360438)
            ),
          },
          ),
    );
  }
}
