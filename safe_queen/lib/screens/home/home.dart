import 'package:flutter/material.dart';
import 'package:safe_queen/screens/home/community.dart';
import 'package:safe_queen/screens/home/guardian_circle.dart';
import 'package:safe_queen/screens/home/legal_info.dart';
import 'package:safe_queen/screens/home/safe_transport.dart';
import 'package:safe_queen/screens/home/safety_tips.dart';
import 'package:safe_queen/screens/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Define colors
  final Color bgWhite = Color(0xFFFFFFFF);
  final Color homeTextColor = Colors.black;

  // Define text styles
  final TextStyle homeTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w800,
  );

  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    switch (index) {
      case 1: // Guardian Circle
        Navigator.push(context, MaterialPageRoute(builder: (context) => GuardianCircle()));
        break;
      case 2: // Community
        Navigator.push(context, MaterialPageRoute(builder: (context) => Community()));
        break;
      case 3: // Profile
        Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
        break;
      default:
        setState(() {
          _selectedIndex = index;
        });
    }
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
          // Remove the ElevatedButton from the actions list
          actions: [],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0), // Increased vertical padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi Welcome Queen !",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50), // Increased space between the text and the curved squares
              SizedBox(
                height: 200, // Increased height of the ListView
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCurvedSquare("Safe Transport Options", "assets/images/img_rectangle_48.png", "Ensure safe travel", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SafeTransport()));
                    }),
                    _buildCurvedSquare("Safety Tips", "assets/images/img_rectangle_47.png", "Stay informed", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SafetyTips()));
                    }),
                    _buildCurvedSquare("Legal Infomation", "assets/images/img_rectangle_49.png", "Know your rights", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LegalInfo()));
                    }),
                  ],
                ),
              ),
              SizedBox(height: 20), // Add space between curved squares and the emergency text
              Center(
                child: Text(
                  "If you're in emergency",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30), // Increase icon size
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.circle_outlined, size: 30), // Increase icon size
              label: 'Guardian Circle',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat, size: 30), // Increase icon size
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30), // Increase icon size
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.pink,
          onTap: _onItemTapped,
          selectedLabelStyle: TextStyle(fontSize: 12), // Increase text size for selected item
          unselectedLabelStyle: TextStyle(fontSize: 12), // Increase text size for unselected items
        ),
      ),
    );
  }

  Widget _buildCurvedSquare(String text, String imagePath, String description, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300, // Increased width of the squares
        height: 200, // Increased height of the squares
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
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), // Increased font size
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
                  style: TextStyle(color: Colors.white, fontSize: 16), // Increased font size
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
