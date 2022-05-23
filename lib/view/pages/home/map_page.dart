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

  List<String>? mapStyleList;
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
    LatLng(39.460235637586, -0.37692144555359275),
    LatLng(39.51538718133392, -0.3743419593607402),
    LatLng(39.402612852737384, -0.41839353233732984),
    LatLng(39.43843402101849, -0.3642951093836233),
    LatLng(39.4438056083871, -0.3619766055427502),
    LatLng(39.464887817649796, -0.36831312057832066),
    LatLng(39.4987777512897, -0.3467864884212849),
    LatLng(39.46799820032132, -0.43245260773886934),
    LatLng(39.46799820032132, -0.43245260773886934),
    LatLng(4.823164130724128, 7.053037342681753),
  ];
  List<MarkerModel> markerList = [
    MarkerModel(
      address: 'Carrer de la Séquia de la Cadena, 5, 46011 València',
      rating: '3.1',
      markerName: "Iberdrola Charging Marker",
      latitude: 4.840896914861768,
      longitude: 7.050211007372598,
    ),
    MarkerModel(
      address: 'Carrer del Dr. Marcos Sopena, 21, 46011 València',
      rating: '3.3',
      markerName: "Etecnic",
      latitude: 4.820354056371533,
      longitude: 7.056225785858122,
    ),
    MarkerModel(
      address: 'Calle Fogainers, 1 - Pol. Ind, 46014 Valencia',
      rating: '3.3',
      markerName: "Allego",
      latitude: 4.819865744457899,
      longitude: 7.0628326147900236,
    ),
    MarkerModel(
      address: 'Carrer del Cobertís dels Brodadors, 6, 46001 València',
      rating: '3.3',
      markerName: "EV pass",
      latitude: 4.823009980822565,
      longitude: 7.054768810051113,
    ),
    MarkerModel(
      address: 'Carrer de la Séquia de la Cadena, 5, 46011 València',
      rating: '3.1',
      markerName: "Iberdrola Charging Marker",
      latitude: 4.840896914861768,
      longitude: 7.050211007372598,
    ),
    MarkerModel(
      address: 'Carrer del Dr. Marcos Sopena, 21, 46011 València',
      rating: '3.3',
      markerName: "Etecnic",
      latitude: 4.820354056371533,
      longitude: 7.056225785858122,
    ),
    MarkerModel(
      address: 'Calle Fogainers, 1 - Pol. Ind, 46014 Valencia',
      rating: '3.3',
      markerName: "Allego",
      latitude: 4.819865744457899,
      longitude: 7.0628326147900236,
    ),
    MarkerModel(
      address: 'Carrer del Cobertís dels Brodadors, 6, 46001 València',
      rating: '3.3',
      markerName: "EV pass",
      latitude: 4.823009980822565,
      longitude: 7.054768810051113,
    ),
    MarkerModel(
      address: 'Carrer de la Séquia de la Cadena, 5, 46011 València',
      rating: '3.1',
      markerName: "Iberdrola Charging Marker",
      latitude: 4.840896914861768,
      longitude: 7.050211007372598,
    ),
    MarkerModel(
      address: 'Carrer del Dr. Marcos Sopena, 21, 46011 València',
      rating: '3.3',
      markerName: "Etecnic",
      latitude: 4.820354056371533,
      longitude: 7.056225785858122,
    ),
  ];

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> createMarkers() async {
    // ImageConfiguration imageConfiguration =
    //     createLocalImageConfiguration(context, size: const Size(30, 30));
    // nearbyIcon = await BitmapDescriptor.fromAssetImage(
    //     imageConfiguration, 'assets/images/marker_icon.png');
    Uint8List markerIcon =
        await getBytesFromAsset('assets/images/golang_logo.png', 130);
    nearbyIcon = BitmapDescriptor.fromBytes(markerIcon);

    try {
      for (int i = 0; i < markerList.length; i++) {
        MarkerModel marker = markerList[i];

        LatLng markerLocation = markerLatLngs[i];
        _markers.add(
          Marker(
            onTap: () async {
              await getDirection(userLocation!, markerLocation, i);
            },
            markerId: MarkerId(i.toString()),
            position: markerLocation,
            icon: nearbyIcon!,
            infoWindow: InfoWindow(
              anchor: Offset(2, 2),
              title:
                  '${marker.markerName!} ${markersDirectionDetails.isNotEmpty ? markersDirectionDetails[i].distanceText!.toString() : ""}',
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
    CameraPosition cp = new CameraPosition(target: userLocation!, zoom: 15);
    mapController!.animateCamera(CameraUpdate.newCameraPosition(cp));
  }

  void setFocus() {
    if (!focused) {
      FocusScope.of(context).requestFocus(focusDestination);
      focused = true;
    }
  }

  DirectionDetails? directionDetails;
  List<DirectionDetails> markersDirectionDetails = [];

  Future<void> getDirection(
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
          color: Colors.greenAccent,
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
      markerId: MarkerId('pickup'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );
    Marker destinationMarker = Marker(
      position: destinationLatLng,
      markerId: MarkerId('destination'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    setState(() {
      _markers.add(pickupMarker);
      _markers.add(destinationMarker);
    });
    Circle pickupCircle = Circle(
      circleId: CircleId('pickup'),
      strokeColor: Colors.green,
      strokeWidth: 3,
      radius: 10,
      center: pickupLatLng,
      fillColor: ColorPalette.green,
    );
    Circle destinationCircle = Circle(
      circleId: CircleId('destination'),
      strokeColor: ColorPalette.purple_1,
      strokeWidth: 3,
      radius: 12,
      center: destinationLatLng,
      fillColor: ColorPalette.purple_1,
    );
    setState(() {
      _circles.add(pickupCircle);
      _circles.add(destinationCircle);
    });
  }

  @override
  void initState() {
    _loadMap();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    mapController!.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  Future<void> getUserLocation() async {
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
    _nightMap = await rootBundle.loadString('assets/map_styles/night_map.json');
    //_standardMap = await rootBundle.load('assets/map_styles/standard_map.json');
    showToast('${MapStyle.values.length}');
    for (int i = 1; i <= MapStyle.values.length; i++) {
String style
     =
          await rootBundle.loadString('assets/map_styles/${i.toString()}.json');
mapStyleList!.add(style);
      showToast('${mapStyleList![i]}hgj');

    }      showToast('ya');
    setState(() {});

    await getUserLocation();

    try {
      for (int i = 0; i < markerLatLngs.length; i++) {
        DirectionDetails details = await RequestHelper.getDirectionDetails(
            userLocation!, markerLatLngs[i]);
        markersDirectionDetails.add(details);
        showToast('${i + 1} marker${i == 0 ? "" : "s"} found');
      }

      setState(() {});
    } catch (e) {
      showToast('check: error is $e');
    }

    await createMarkers();
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
// switch(state) {
//
//   case MapStyle.standard: {
//     mapController!.setMapStyle(mapStyleList![state.index]);
//   }
//   break;
//
//   default: {
// //statements;
//   }
//   break;
// }

                      if (state == MapStyle.standard) {

                        mapController!.setMapStyle(mapStyleList![state.index]);
                        //  mapController!.setMapStyle(_nightMap!);
                        showToast('${mapStyleList![state.index]}');
                      }
                      if (state == MapStyle.night) {
                        showToast('${mapStyleList![state.index]}');
                        mapController!.setMapStyle(mapStyleList![state.index]);
                      }
                      if (state == MapStyle.silver) {

                        showToast('$_nightMap!');
                      }
                      if (state == MapStyle.aubergine) {
                        mapController!.setMapStyle(mapStyleList![state.index]);
                        showToast('${state.index.toString()}');
                      }
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
                          repositionCamera(controller);
                          mapController = controller;
//mapController!.setMapStyle(_nightMap);
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
