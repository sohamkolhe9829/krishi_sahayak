import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as maps_toolkit;

class FeildMeasurmentProvider with ChangeNotifier {
  Position? currentPosition;

// Define the coordinates of the polygon
  List<maps_toolkit.LatLng> points = [];
  num areaInSquareMeters = 0;
  double squareFoot = 0;
  double acre = 0;
  double hectare = 0;
  double bigha = 0;
  bool isLoading = false;

  measureFeild() {
    points.add(
      maps_toolkit.LatLng(
        points[0].latitude,
        points[0].longitude,
      ),
    );
    areaInSquareMeters = maps_toolkit.SphericalUtil.computeArea(points);
    convertArea(areaInSquareMeters.toDouble());
    notifyListeners();
  }

  void convertArea(double squareMeters) {
    acre = squareMeters / 4046.86;
    hectare = squareMeters / 10000;
    bigha =
        squareMeters / 1442.5; // Note: This is an approximate conversion factor
    squareFoot = squareMeters / 0.092903;
    notifyListeners();
  }

  addPoint() async {
    isLoading = true;
    notifyListeners();
    await getCurrentLocation();
    points.add(
      maps_toolkit.LatLng(
        currentPosition!.latitude,
        currentPosition!.longitude,
      ),
    );
    isLoading = false;
    notifyListeners();
  }

  removePoint(int index) {
    points.removeAt(index);
    notifyListeners();
  }

  getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    // Request permission
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return;
    }

    // Get current position
    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    notifyListeners();
  }

  clearPoints() {
    points = [];
    notifyListeners();
  }
}
