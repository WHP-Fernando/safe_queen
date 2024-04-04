import 'package:flutter/material.dart';
import 'package:safe_queen/screens/home/location.dart';
import 'package:safe_queen/screens/profiles/about_us.dart';
import 'package:safe_queen/screens/profiles/edit_profile.dart';
import 'package:safe_queen/services/auth.dart';

class Profile extends StatelessWidget {
  // Create an object from AuthService
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileButton(
              icon: Icons.edit,
              text: 'Edit Your Details',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfile()),
                );
              },
            ),
            SizedBox(height: 20),
            ProfileButton(
              icon: Icons.location_city,
              text: 'My Location',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocationDemo()),
                );
              },
            ),
            SizedBox(height: 20),
            ProfileButton(
              icon: Icons.info,
              text: 'About Us',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUs()),
                );
              },
            ),
            SizedBox(height: 20),
            ProfileButton(
              icon: Icons.logout,
              text: 'Sign out',
              onPressed: () async {
                await _auth.signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const ProfileButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(
        text,
        style: TextStyle(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.pinkAccent,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
