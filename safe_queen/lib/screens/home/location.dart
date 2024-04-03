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
          "Location Demo",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true, // Align title to center
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/pngtree-tech-blue-clock-h5-background-material-picture-image_992604.jpg', // Replace this with your image path
              fit: BoxFit.cover,
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
                  foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
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
