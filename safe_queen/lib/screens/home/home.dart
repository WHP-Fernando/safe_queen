import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart'; // Import PermissionHandler
import 'package:geolocator/geolocator.dart'; // Import Geolocator
import 'package:safe_queen/screens/SOS/sos.dart';
import 'package:safe_queen/screens/chatbot/chat_bot.dart';
import 'package:safe_queen/screens/home/Community_chat.dart';
import 'package:safe_queen/screens/guardian%20circle/guardian.dart';
import 'package:safe_queen/screens/home/legal_info.dart';
import 'package:safe_queen/screens/home/Safe%20Transport%20Options/safe_transport.dart';
import 'package:safe_queen/screens/home/safety_tips.dart';
import 'package:safe_queen/screens/home/Self%20Videos/self_empower.dart';
import 'package:safe_queen/screens/profiles/profile.dart';

void main() {
  runApp(Myone());
}

class Myone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Back Button in AppBar',
      home: Home(), // Directly use the Home widget as the main screen
    );
  }

  // Method to send emergency alerts
  void sendEmergencyAlert(BuildContext context) async {
    // Fetch the list of trusted contacts from Firestore
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('contacts')
          .where('userId', isEqualTo: userId)
          .get();

      // Iterate through the list of contacts and send emergency alerts
      snapshot.docs.forEach((doc) async {
        String phoneNumber = doc['phoneNumber'];
        await sendSMSAlert(phoneNumber, 'Emergency! Need your help!');
      });
    }
  }

  // Method to send SMS using platform channels
  Future<void> sendSMSAlert(String phoneNumber, String message) async {
    try {
      // Get current location
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      double latitude = position.latitude;
      double longitude = position.longitude;

      // Construct Google Maps link
      String mapsLink = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

      // Construct message with location link
      String messageWithLocation = '$message\nLocation: $mapsLink';

      // Check if permission is granted
      PermissionStatus status = await Permission.sms.status;
      if (status.isGranted) {
        // Permission is granted, proceed with sending SMS
        await MethodChannel('platform_service')
            .invokeMethod('sendSMSAlert', {'phoneNumber': phoneNumber, 'message': messageWithLocation});
      } else {
        // Permission is not granted, handle accordingly (show error message, etc.)
        print('Permission denied for sending SMS');
      }
    } catch (e) {
      print("Error while sending SMS alert: $e");
    }
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Color bgWhite = Color.fromARGB(255, 253, 238, 252);
  final Color homeTextColor = Colors.black;

  final TextStyle homeTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w800,
  );

  int _selectedIndex = 0;

 void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
    switch (index) {
      case 0:
        // Navigate to Home
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => GuardianScreen()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => CommunityChat()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
        break;
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: bgWhite,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: bgWhite,
          title: Text(
            "Hi Welcome Queen !",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              foreground: Paint()..shader = LinearGradient(
                colors: [Color.fromARGB(255, 233, 47, 118), Color.fromARGB(255, 204, 33, 144)],
              ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
              shadows: [
                Shadow(
                  blurRadius: 5.0,
                  color: Colors.black.withOpacity(0.5),
                  offset: Offset(2.0, 2.0),
                )
              ]
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                child: Image.asset(
                  'assets/images/8943377.png',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Swipe to discover more about Safety features and legal information.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                  textAlign: TextAlign.center,
                ),
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    SizedBox(height: 05),
                    _buildCurvedSquare("Safe Transport Options", "assets/images/img_rectangle_48.png", "Ensure safe travel", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SafeTransport()));
                    }), 
                    SizedBox(height: 10),
                    _buildCurvedSquare("Self Defense Techniques", "assets/images/img_rectangle_47.png", "Stay Alert", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SafetyTips()));
                    }),
                      SizedBox(height: 10),
                    _buildCurvedSquare("Self Empowerment Videos", "assets/images/stock-photo-strong-woman-winning-success-and-life-goals-concept-young-woman-with-arms-flexed-looking-up-to-1614362578.jpg", "Know your worth.", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SelfEmpowermentPage()));
                    }),
                    SizedBox(height: 10),
                    _buildCurvedSquare("Legal Information", "assets/images/img_rectangle_49.png", "Know your rights", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LegalInfo()));
                    }),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "If you're in emergency",
                      style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Myone().sendEmergencyAlert(context);  
                      },
                      child: const Text("SOS Guardian", style: TextStyle(fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      ),
                    ),
                    SizedBox(height: 10),  
                    ElevatedButton(  
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SOS()),
                        );
                      // Add your onPressed functionality here
                      },
                      child: const Text("SOS Contacts", style: TextStyle(fontSize: 16)), // Customize button text
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue, // Customize button color
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      ),
                    ),
                  ],
                ),
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
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.pink,
          onTap: _onItemTapped,
          selectedLabelStyle: TextStyle(fontSize: 12),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          backgroundColor: Color.fromARGB(255, 253, 243, 252), //bottom nav bar color
        ),
      ),
    );
  }

  Widget _buildCurvedSquare(String text, String imagePath, String description, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 200,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              width: double.infinity,
              color: Colors.black.withOpacity(0.7),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4),
              width: double.infinity,
              color: Colors.black.withOpacity(0.7),
              child: Center(
                child: Text(
                  description,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
