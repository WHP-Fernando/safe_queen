import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SafeTransport(),
  ));
}

class SafeTransport extends StatelessWidget {
  const SafeTransport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize Firebase  
    if (Firebase.apps.isEmpty) {
      Firebase.initializeApp();
    }

    // Push safety details to Firebase
    pushSafetyDetails();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo, // Change app bar color
        title: Text(
          'Safe Transport',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 253, 238, 252), //change background color
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionCard(
              title: 'Safety Tips for Taking Public Transport',
              description: 'Stay safe while using public transportation.',
              points: [
                'Wait for public transport in well-lit areas.',
                'Stand away from the curb while waiting for a bus or train.',
                'Sit near the driver or conductor if possible.',
                'Avoid using headphones at night.',
                'Be aware of your surroundings.',
              ],
              imagePath: 'assets/images/future-public-transport-2030-electric-future-london-evening-standard.jpg', // Add image path
            ),
            SizedBox(height: 20),
            SectionCard(
              title: 'Safety Tips for Riding a Bike',
              description: 'Stay safe while riding a bike.',
              points: [
                'Always wear a helmet.',
                'Use hand signals to indicate turns.',
                'Ride in the same direction as traffic.',
                'Obey traffic signs and signals.',
                'Wear bright or reflective clothing, especially at night.',
              ],
              imagePath: 'assets/images/alone-at-night.jpg', // Add image path
            ),
            SizedBox(height: 20),
            SectionCard(
              title: 'Safety Tips for Driving',
              description: 'Stay safe while driving.',
              points: [
                'Wear your seatbelt at all times.',
                'Follow speed limits and traffic laws.',
                'Avoid distractions such as texting or talking on the phone.',
                'Keep a safe distance from other vehicles.',
                'Be mindful of pedestrians and cyclists.',
              ],
              imagePath: 'assets/images/Depositphotos_8874368_XL-min-scaled.jpg', // Add image path
            ),
          ],
        ),
      ),
    );
  }

  // Function to push safety details to Firebase Realtime Database
  void pushSafetyDetails() {
    try {
      DatabaseReference reference = FirebaseDatabase.instance.reference().child('safety_details');

      reference.push().set({
        'title': 'Safety Tips for Taking Public Transport',
        'description': 'Stay safe while using public transportation.',
        'points': [
          'Wait for public transport in well-lit areas.',
          'Stand away from the curb while waiting for a bus or train.',
          'Sit near the driver or conductor if possible.',
          'Avoid using headphones at night.',
          'Be aware of your surroundings.',
        ],
      });

      reference.push().set({
        'title': 'Safety Tips for Riding a Bike',
        'description': 'Stay safe while riding a bike.',
        'points': [
          'Always wear a helmet.',
          'Use hand signals to indicate turns.',
          'Ride in the same direction as traffic.',
          'Obey traffic signs and signals.',
          'Wear bright or reflective clothing, especially at night.',
        ],
      });

      reference.push().set({
        'title': 'Safety Tips for Driving',
        'description': 'Stay safe while driving.',
        'points': [
          'Wear your seatbelt at all times.',
          'Follow speed limits and traffic laws.',
          'Avoid distractions such as texting or talking on the phone.',
          'Keep a safe distance from other vehicles.',
          'Be mindful of pedestrians and cyclists.',
        ],
      });

      print("Safety details added successfully!");
    } catch (error) {
      print("Error adding safety details: $error");
    }
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> points;
  final String imagePath;

  const SectionCard({
    required this.title,
    required this.description,
    required this.points,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Add elevation for a modern look
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Add rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          Image.asset(
            imagePath,
            width: double.infinity, // Set width to occupy full screen width
            height: 150, // Adjust height as needed
            fit: BoxFit.cover, // Ensure the image covers the entire space
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: points
                      .map((point) => Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    point,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
