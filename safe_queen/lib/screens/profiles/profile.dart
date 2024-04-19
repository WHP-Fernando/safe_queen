import 'dart:async';
import 'package:flutter/material.dart';
import 'package:safe_queen/screens/guardian%20circle/guardian.dart';
import 'package:safe_queen/screens/home/Community_chat.dart';
import 'package:safe_queen/screens/home/home.dart';
import 'package:safe_queen/screens/profiles/Photovalut.dart';
import 'package:safe_queen/screens/profiles/about_us.dart';
import 'package:safe_queen/screens/profiles/edit_profile.dart';
import 'package:safe_queen/screens/profiles/games_menu.dart';
import 'package:safe_queen/screens/splash_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // ignore: unused_field
  String _password = '';
  // ignore: unused_field
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 253, 238, 252),
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color.fromARGB(255, 253, 238, 252),
        padding: EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            ProfileCard(
              title: 'Edit Profile',
              icon: Icons.edit,
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfile()),
                );
              },
            ),
            ProfileCard(
              title: 'Photo Vault',
              icon: Icons.security,
              onPressed: () {
                _showPasswordPrompt(context);
              },
            ),
            ProfileCard(
              title: 'Games',
              icon: Icons.games,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameMenu()),
                );
              },
            ),
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
            ProfileCard(
              title: 'My Location',
              icon: Icons.location_on,
              onPressed: _showLocationOnMap,
            ),
            ProfileCard(
              title: 'Sign out',
              icon: Icons.logout,
              onPressed: () {
                _showSignOutConfirmationDialog(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle_outlined, size: 30),
            label: 'Guardian Circle',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_3_rounded, size: 33),
            label: 'Community Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded, size: 30),
            label: 'Profile',
          ),
        ],
        currentIndex: 3, // Index of profile screen
        selectedItemColor: Colors.pink,
        selectedLabelStyle: TextStyle(fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        backgroundColor: Color.fromARGB(255, 253, 243, 252),
        onTap: (int index) {
          // Handle navigation here...
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home()));
              break;
            case 1:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => GuardianScreen()));
              break;
            case 2:
              // Current screen, do nothing
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => CommunityChat()));
              break;
            case 3:
              // Current screen, do nothing
              break;
          }
        },
      ),
    );
  }

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

  // Method to show sign-out confirmation dialog
  void _showSignOutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sign Out"),
          content: Text("Are you sure you want to sign out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pop(); // Close the dialog
                // Navigate to the sign-in page after signing out
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreen()), // Replace SignInPage with your actual sign-in page
                );
              },
              child: Text("Sign Out"),
            ),
          ],
        );
      },
    );
  }


 // Method to show password prompt
void _showPasswordPrompt(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    // User not logged in, do nothing
    return;
  }
  
  // Retrieve the user's photo vault password independently
  _firestore.collection('passwords').doc(user.uid).get().then((snapshot) {
    if (snapshot.exists) {
      final userData = snapshot.data();
      if (userData != null && userData['photoVaultPassword'] != null) {
        // User has set their photo vault password, proceed with verification
        _verifyPassword(context, userData['photoVaultPassword']);
      } else {
        // User hasn't set their photo vault password, prompt to set it
        _showSetPasswordPrompt(context, user.uid);
      }
    } else {
      // User doesn't exist in database, prompt to set photo vault password
      _showSetPasswordPrompt(context, user.uid);
    }
  }).catchError((error) {
    // Error retrieving user data from database
    print("Error retrieving user data: $error");
    // Prompt to set photo vault password as fallback
    _showSetPasswordPrompt(context, user.uid);
  });
}

// Method to show set password prompt
void _showSetPasswordPrompt(BuildContext context, String userId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String newPassword = '';
      return AlertDialog(
        title: Text("Set Photo Vault Password"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              onChanged: (value) {
                newPassword = value;
              },
              decoration: InputDecoration(hintText: 'Enter new password'),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    // Save new password to database
                    _firestore.collection('passwords').doc(userId).set({
                      'photoVaultPassword': newPassword,
                    }).then((value) {
                      Navigator.of(context).pop(); // Close the dialog
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Password set successfully.'),
                        duration: Duration(seconds: 2),
                      ));
                    }).catchError((error) {
                      print("Error setting password: $error");
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Failed to set password. Please try again.'),
                        duration: Duration(seconds: 2),
                      ));
                    });
                  },
                  child: Text("Set Password"),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}


// Method to verify password
void _verifyPassword(BuildContext context, String password) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String enteredPassword = '';
      return AlertDialog(
        title: Text("Enter Photo Vault Password"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              onChanged: (value) {
                enteredPassword = value;
              },
              decoration: InputDecoration(hintText: 'Enter password'),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    if (enteredPassword == password) {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PhotoVaultHomePage()),
                      );
                    } else {
                      // Close the dialog first, then show reset password prompt
                      Navigator.of(context).pop(); // Close the dialog
                      _showForgotPasswordPrompt(context);
                    }
                  },
                  child: Text("Submit"),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
 
  // Method to show forgot password prompt
  void _showForgotPasswordPrompt(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String email = '';
        return AlertDialog(
          title: Text("Forgot Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(hintText: 'Enter your email'),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () async {
                      try {
                        await _firebaseAuth.sendPasswordResetEmail(email: email);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Password reset email sent. Check your inbox.'),
                          duration: Duration(seconds: 2),
                        ));
                        Navigator.of(context).pop(); // Close the dialog
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Failed to send password reset email. Please try again.'),
                          duration: Duration(seconds: 2),
                        ));
                      }
                    },
                    child: Text("Reset Password"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProfileCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color textColor;
  final VoidCallback onPressed;

  const ProfileCard({
    Key? key,
    required this.icon,
    required this.title,
    this.textColor = Colors.black,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 48,
              ),
              SizedBox(height: 10),
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
