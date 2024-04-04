import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Demo',
      home: LocationDemo(),
    );
  }
}

class LocationDemo extends StatefulWidget {
  @override
  _LocationDemoState createState() => _LocationDemoState();
}

class _LocationDemoState extends State<LocationDemo> {
  // Method to get the current location and launch map application
  void _showLocationOnMap() async {
    // Calling Geolocator to get the current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    // Getting latitude and longitude from the position object
    double lat = position.latitude;
    double long = position.longitude;

    // Using the URL Launcher to open the map application with the current location
    String url = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Location",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true, // Align title to center
      ),
      body: Stack(
        children: [
          // Background Image with Blur Effect
          Positioned.fill(
            child: Image.asset(
              'assets/images/gps-mobile-track-navigate.jpg', // Replace this with image path
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Adjust sigmaX and sigmaY as needed
              child: Container(
                color: Colors.black.withOpacity(0.5), // Adjust the opacity as needed
              ),
            ),
          ),
          // Content
          Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black), // Black border
                borderRadius: BorderRadius.circular(33), // Rounded corners
              ),
              child: ElevatedButton(
                onPressed: () {
                  _showLocationOnMap();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.pinkAccent, // Text color
                  elevation: 10, // Elevation
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Show Location on Map",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
