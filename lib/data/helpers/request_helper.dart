import 'dart:convert';
import 'package:google_map_flutter/view/base/toast_snackbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:google_map_flutter/data/models/direction_details.dart';

///http request helpers
class RequestHelper {
  ///GET request
  static Future<dynamic> getRequest(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    try {
      var decodedData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return decodedData;
      } else {
        return 'CHECK Get Request failed';
      }
    } catch (e) {
      print(e);
    }
  }

  ///Verify OTP request
  static Future<Map<String, dynamic>> verifyOTPRequest(
      String url, Map body) async {
    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body));
    try {
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        return decodedData;
      } else {
        print('CHECK verifyOTP error');

        /// check confirm logic here
        return jsonDecode(response.body);
      }
    } catch (e) {
      throw e;
      print(e);
    }
  }

  ///Signup REquest
  static Future<Map<String, dynamic>> signUpRequest(
      String url, Map body) async {
    var response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body));

    try {
      if (response.statusCode == 200) {
        var data = response.body;
        var decodedData = jsonDecode(data);
        return decodedData;
      } else {
        var data = response.body;
        var decodedData = jsonDecode(data);
        print(decodedData["message"]);
        var result = decodedData;
        return result;
      }
    } catch (e) {
      //  return 'failed';
      print(e);
      print('CHECK REQUEST HELPER');
    }

    return jsonDecode(response.body);
  }

  ///SignIn request
  static Future<Map<String, dynamic>> signInRequest(
      String url, Map body) async {
    var response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body));
    try {
      if (response.statusCode == 200) {
        print("200 Ok usual");
        var data = response.body;
        var decodedData = jsonDecode(data);
        print(decodedData["message"]);

        var result = decodedData;
        return result;
      } else {
        var data = response.body;
        var decodedData = jsonDecode(data);

        var result = decodedData;
        return result;
      }
    } catch (e) {
      //  return 'failed';
      print(e);
      print('CHECK REQUEST HELPER');
    }

    return jsonDecode(response.body);
  }

//static String mapKey = 'AIzaSyBAaamLNznjZApzbu038_LxbysOumdDHVM';
  static String mapKey = 'AIzaSyBAaamLNznjZApzbu038_LxbysOumdDHVM';

  static Future<DirectionDetails> getDirectionDetails(
      LatLng startPosition, LatLng endPosition) async {
    try {
      String url =
          // 'https://maps.googleapis.com/maps/api/directions/json?origin=41.43206,-81.38992&destination=41.43206,-81.38992&mode=driving&key=AIzaSyBAaamLNznjZApzbu038_LxbysOumdDHVM';

          'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=$mapKey';
      print('check: url is: $url');
      var response = await getRequest(url);
      print('check: response is ${response.toString()}');
      if (response == 'failed') {

        //  return null;
      }
      DirectionDetails directionDetails = DirectionDetails();
      directionDetails.durationText =
          response['routes'][0]['legs'][0]['duration']['text'];
      directionDetails.durationValue =
          response['routes'][0]['legs'][0]['duration']['value'];

      directionDetails.distanceText =
          response['routes'][0]['legs'][0]['distance']['text'];
      directionDetails.distanceValue =
          response['routes'][0]['legs'][0]['distance']['value'];
//  routes[0].overview_polyline.points
      directionDetails.encodedPoints =
          response['routes'][0]['overview_polyline']['points'];
      return directionDetails;
    } catch (e) {
      print("check: error sis e");
      showToast(e.toString());
      throw e;
    }
  }
}
