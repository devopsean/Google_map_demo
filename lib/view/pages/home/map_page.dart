import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_map_flutter/data/constants/enums.dart';
import 'package:google_map_flutter/data/utils/color_palette.dart';
import 'package:google_map_flutter/logic/map/cubit/map_cubit.dart';
import 'package:google_map_flutter/view/base/menu_drawer.dart';
import 'package:google_map_flutter/view/base/toast_snackbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:google_map_flutter/data/helpers/request_helper.dart';

import 'package:google_map_flutter/data/models/direction_details.dart';
import 'package:google_map_flutter/data/models/marker_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);
  static const id = 'map_page';

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with SingleTickerProviderStateMixin {
  Completer<GoogleMapController> _controller = Completer();

  LatLng? userLocation;
  BitmapDescriptor? nearbyIcon;
  var pickupController = TextEditingController();
  var destinationController = TextEditingController();

  String? _nightMap;

  List<String> mapStyleList = [];
  final GlobalKey<ScaffoldState>? _scaffoldKey = GlobalKey<ScaffoldState>();
  var focusDestination = FocusNode();
  bool focused = false;
  List<LatLng> polylineCoordinates = [];
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};
  Set<Circle> _circles = {};
  // GoogleMapController? mapController;

  PolylinePoints? polylinePoints = PolylinePoints();

  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 12.4746,
  );
  Position? currentPosition;
  GoogleMapController? mapController;

  List<LatLng> markerLatLngs = [
    LatLng(39.55947088086999, -3.284376905181718),
    LatLng(52.371269336266316, 4.892396687400338),
    LatLng(48.83504853651144, 2.29800977331019),
    LatLng(48.82894255378066, 2.26501869829721),

    LatLng(48.827090718528105, 2.2546135650445303),
  ];

  Future<Uint8List> getIconBytes(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> addMarkers() async {
    Uint8List markerIcon =
        await getIconBytes('assets/images/golang_logo.png', 130);
    nearbyIcon = BitmapDescriptor.fromBytes(markerIcon);

    try {
      for (int i = 0; i < markerLatLngs.length; i++) {
        LatLng markerLocation = markerLatLngs[i];
        _markers.add(
          Marker(
            onTap: () async {
              await getDirectionDetails(userLocation!, markerLocation, i);
            },
            markerId: MarkerId(i.toString()),
            position: markerLocation,
            icon: nearbyIcon!,
            infoWindow: InfoWindow(
              anchor: Offset(2, 2),
              title:
                  '${markersDirectionDetails.isNotEmpty ? markersDirectionDetails[i].distanceText.toString() : ""}',
              snippet:
                  '${markersDirectionDetails.isNotEmpty ? markersDirectionDetails[i].durationText : ""}',
            ),
          ),
        );
        setState(() {});
      }

      ///check implement list for all markers
    } catch (e) {
      print('check: error is $e');
      showToast('check: error is $e');
    }
  }

  void repositionCamera(GoogleMapController controlla) async {
    CameraPosition cp = new CameraPosition(target: userLocation!, zoom: 11.5);
    controlla.animateCamera(CameraUpdate.newCameraPosition(cp));
  }

  void setFocus() {
    if (!focused) {
      FocusScope.of(context).requestFocus(focusDestination);
      focused = true;
    }
  }

  MarkerDirection? directionDetails;
  List<MarkerDirection> markersDirectionDetails = [];

  Future<void> getDirectionDetails(
      LatLng pickupLatLng, LatLng destinationLatLng, int index) async {
    PolylinePoints polylinePoints = PolylinePoints();

    List<PointLatLng> results = polylinePoints
        .decodePolyline(markersDirectionDetails[index].encodedPoints!);
    polylineCoordinates.clear();
    if (results.isNotEmpty) {
      //loop thru all PointLatLng points and convert them
      // to a  list of LatLng, required by the polyline
      results.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    _polylines.clear();
    setState(() {
      Polyline polyline = Polyline(
          polylineId: PolylineId('polyid'),
          color: ColorPalette.green,
          points: polylineCoordinates,
          jointType: JointType.round,
          width: 5,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          geodesic: true);
      _polylines.add(polyline);
    });

    //make poly line fit into map
    LatLngBounds bounds;
    if (pickupLatLng.latitude > destinationLatLng.latitude &&
        pickupLatLng.longitude > destinationLatLng.longitude) {
      bounds =
          LatLngBounds(southwest: destinationLatLng, northeast: pickupLatLng);
    } else if (pickupLatLng.longitude > destinationLatLng.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(pickupLatLng.latitude, destinationLatLng.longitude),
          northeast:
              LatLng(destinationLatLng.latitude, pickupLatLng.longitude));
    } else if (pickupLatLng.latitude > destinationLatLng.latitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destinationLatLng.latitude, pickupLatLng.longitude),
          northeast:
              LatLng(pickupLatLng.latitude, destinationLatLng.longitude));
    } else {
      bounds =
          LatLngBounds(southwest: pickupLatLng, northeast: destinationLatLng);
    }
    //to make use of the bounds
    mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 70));
    Marker pickupMarker = Marker(
      position: pickupLatLng,
      markerId: MarkerId('p'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );
    Marker destinationMarker = Marker(visible: false,
      position: destinationLatLng,
      markerId: MarkerId('d'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );
    setState(() {
      _markers.add(pickupMarker);
      _markers.add(destinationMarker);
    });
    Circle pickupCircle = Circle(
      circleId: CircleId('p'),
      strokeColor: Colors.green,
      strokeWidth: 3,
      radius: 8,
      center: pickupLatLng,
      fillColor: ColorPalette.white,
    );
    Circle destinationCircle = Circle(
      circleId: CircleId('d'),
      strokeColor: ColorPalette.purple_1,
      strokeWidth: 3,
      radius: 8,
      center: destinationLatLng,
      fillColor: ColorPalette.white,
    );
    setState(() {
      _circles.add(pickupCircle);
      _circles.add(destinationCircle);
    });
  }

  @override
  void initState() {
    //WidgetsBinding.instance!.addPostFrameCallback((_) => _loadMap());

    getUserLocation().then((value) => _loadMap()); // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    mapController!.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  Future getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        showToast('Location services are disabled.');
        return;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          showToast('Location permissions are denied');
        }
        if (permission == LocationPermission.deniedForever) {
          // Permissions are denied forever, handle appropriately.
          showToast(
              'Location permissions are permanently denied, we cannot request permissions.');
        }
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      currentPosition = position;

      userLocation = LatLng(position.latitude, position.longitude);
      setState(() {});
      repositionCamera(mapController!);
    } catch (e) {
      print('check: error on location is: $e');
    }
  }

  Future _loadMap() async {
    for (int i = 1; i <= MapStyle.values.length; i++) {
      String style =
          await rootBundle.loadString('assets/map_styles/${i.toString()}.json');

      mapStyleList.add(style);
    }

    setState(() {});

    try {
      for (int i = 0; i < markerLatLngs.length; i++) {
        MarkerDirection details = await RequestHelper.getDirectionDetails(
            userLocation!, markerLatLngs[i]);

        markersDirectionDetails.add(details);
        showToast('${i + 1} marker${i == 0 ? "" : "s"} found');
      }

      setState(() {});
    } catch (e) {
      showToast('check: error is $e');
    }

    await addMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  resizeToAvoidBottomInset: false,
      backgroundColor: ColorPalette.scaffoldBackgroundGrey,
      appBar: AppBar(
        title: Text('Google Map Example'),
        backgroundColor: ColorPalette.darkBlue_1,
      ),
      key: _scaffoldKey!,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Stack(
                children: <Widget>[
                  BlocConsumer<MapCubit, MapStyle>(
                    listener: (context, state) {
                      // TODO: implement listener

                      mapController!.setMapStyle(mapStyleList[state.index]);
                    },
                    builder: (context, state) {
                      return GoogleMap(
                        buildingsEnabled: false,
                        myLocationEnabled: true,
                        gestureRecognizers:
                            <Factory<OneSequenceGestureRecognizer>>[
                          new Factory<OneSequenceGestureRecognizer>(
                            () => new EagerGestureRecognizer(),
                          ),
                        ].toSet(),
                        initialCameraPosition: _initialCameraPosition,
                        mapType: MapType.normal,
                        onMapCreated: (GoogleMapController controller) {
                          mapController = controller;
                        //  controller.setMapStyle(mapStyleList[state.index]);
                          _controller.complete(controller);
                        },
                        myLocationButtonEnabled: true,
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: false,
                        compassEnabled: true,
                        rotateGesturesEnabled: true,
                        markers: _markers,
                        circles: _circles,
                        polylines: _polylines,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: MenuDrawer(),
    );
  }
}
