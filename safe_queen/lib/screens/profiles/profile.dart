import 'package:flutter/material.dart';
import 'package:safe_queen/screens/home/location.dart';
import 'package:safe_queen/screens/profiles/about_us.dart';
import 'package:safe_queen/screens/profiles/edit_profile.dart';
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
        color: Color.fromARGB(255, 253, 238, 252), // background color
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileCard(
              title: 'Edit Your Details',
              icon: Icons.edit,
              textColor: Colors.black, // text color
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfile()),
                );
              },
            ),
            SizedBox(height: 20),
            ProfileCard(
              title: 'My Location',
              icon: Icons.location_city,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocationDemo()),
                );
              },
              ),
            SizedBox(height: 20),
            ProfileCard(
              title: 'Biometric Pattern',
              icon: Icons.security,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()),
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
            // Add the image at the bottom
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'assets/images/istockphoto-1384434228-612x612-removebg-preview.png', // Adjust the path as needed
                  width: 500, // Adjust width as needed
                  height: 500, // Adjust height as needed
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
                  fontWeight: FontWeight.bold, // bold font w
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
