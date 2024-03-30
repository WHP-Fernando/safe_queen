import 'package:flutter/material.dart';
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
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/images/img_user_icon.png'), // Add your profile picture asset here
            ),
            SizedBox(height: 40),
            TextButton.icon(
              onPressed: () {
                // Navigate to EditProfilePage
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
              },
              icon: Icon(Icons.edit), // Icon for edit profile
              label: Text(
                'Edit profile',
                style: TextStyle(fontSize: 18), // Adjust font size here
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100), // Adjust height and width here
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.black), // Add border color here
                ),
                backgroundColor: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            TextButton.icon(
              onPressed: () {
                // Navigate to AboutUsPage
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
              },
              icon: Icon(Icons.info), // Icon for about us
              label: Text(
                'About us',
                style: TextStyle(fontSize: 18), // Adjust font size here
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, padding: EdgeInsets.symmetric(vertical: 20, horizontal: 107), // Adjust height and width here
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.black), // Add border color here
                ),
                backgroundColor: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            TextButton.icon(
              onPressed: () async{
                // Call the signOut() method from AuthService
                await _auth.signOut();
                // Perform sign-out action
                // For demonstration purpose, just pop back to the previous screen
                Navigator.pop(context);
              },
              icon: Icon(Icons.logout), // Icon for sign out
              label: Text(
                'Sign out',
                style: TextStyle(fontSize: 18), // Adjust font size here
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, padding: EdgeInsets.symmetric(vertical: 20, horizontal: 107), // Adjust height and width here
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.black), // Add border color here
                ),
                backgroundColor: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


