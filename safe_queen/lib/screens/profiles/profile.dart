import 'dart:async';
import 'package:flutter/material.dart';
import 'package:safe_queen/screens/profiles/about_us.dart';
import 'package:safe_queen/screens/profiles/Photovalut.dart';
import 'package:safe_queen/screens/profiles/edit_profile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:safe_queen/services/auth.dart';

class Profile extends StatelessWidget {
  // Create object AuthService for sign out
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 253, 238, 252),
        title: Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color.fromARGB(255, 253, 238, 252),  
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileCard(
              title: 'Edit Your Details',
              icon: Icons.edit,
              textColor: Colors.black, 
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfile()),
                );
              },
            ),
            SizedBox(height: 20),
            LocationProfileCard(),
            SizedBox(height: 20),
            ProfileCard(
              title: 'Photo valut',
              icon: Icons.security,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PhotoVaultHomePage()),
                );
              },
            ),
            SizedBox(height: 20),
            ProfileCard(
              title: 'About Us',
              icon: Icons.info,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()),
                );
              },
            ),
            SizedBox(height: 20),
            ProfileCard(
              title: 'Sign out',
              icon: Icons.logout,
              onPressed: () async {
                await _auth.signOut();
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 120),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'assets/images/istockphoto-1384434228-612x612-removebg-preview.png', // Adjust the path as needed
                  width: 500,  
                  height: 500,  
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const ProfileCard({
    Key? key,
    required this.icon,
    required this.title,
    this.textColor = Colors.black,  //default text color
    this.backgroundColor =  const Color.fromARGB(255, 255, 95, 146),  // default card color
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.black, width: 2), //add border color
      ),
      color: backgroundColor,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.black, // icon color
              ),
              SizedBox(width: 15),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  color: textColor,
                  fontWeight: FontWeight.bold,  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationProfileCard extends StatefulWidget {
  @override
  _LocationProfileCardState createState() => _LocationProfileCardState();
}

class _LocationProfileCardState extends State<LocationProfileCard> {
  // Method to get the current location and launch map application
  Future<void> _showLocationOnMap() async {
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
    return ProfileCard(
      title: 'My Location',
      icon: Icons.location_city,
      onPressed: _showLocationOnMap,
    );
  }
}
