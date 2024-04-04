import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class SafeTransport extends StatelessWidget {
  const SafeTransport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize Firebase (if not already initialized)
    if (Firebase.apps.isEmpty) {
      Firebase.initializeApp();
    }

    // Push safety details to Firebase
    pushSafetyDetails();

    return Scaffold(
      appBar: AppBar(
        title: Text('Safe Transport'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafetyDetails(
              title: 'Safety Tips for Taking Public Transport',
              details: '''
- Wait for public transport in well-lit areas.
- Stand away from the curb while waiting for a bus or train.
- Sit near the driver or conductor if possible.
- Avoid using headphones at night.
- Be aware of your surroundings.
''',
            ),
            SizedBox(height: 20),
            SafetyDetails(
              title: 'Safety Tips for Riding a Bike',
              details: '''
- Always wear a helmet.
- Use hand signals to indicate turns.
- Ride in the same direction as traffic.
- Obey traffic signs and signals.
- Wear bright or reflective clothing, especially at night.
''',
            ),
            SizedBox(height: 20),
            SafetyDetails(
              title: 'Safety Tips for Driving',
              details: '''
- Wear your seatbelt at all times.
- Follow speed limits and traffic laws.
- Avoid distractions such as texting or talking on the phone.
- Keep a safe distance from other vehicles.
- Be mindful of pedestrians and cyclists.
'''
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
        'details': '''
- Wait for public transport in well-lit areas.
- Stand away from the curb while waiting for a bus or train.
- Sit near the driver or conductor if possible.
- Avoid using headphones at night.
- Be aware of your surroundings.
'''
      });

      reference.push().set({
        'title': 'Safety Tips for Riding a Bike',
        'details': '''
- Always wear a helmet.
- Use hand signals to indicate turns.
- Ride in the same direction as traffic.
- Obey traffic signs and signals.
- Wear bright or reflective clothing, especially at night.
'''
      });

      reference.push().set({
        'title': 'Safety Tips for Driving',
        'details': '''
- Wear your seatbelt at all times.
- Follow speed limits and traffic laws.
- Avoid distractions such as texting or talking on the phone.
- Keep a safe distance from other vehicles.
- Be mindful of pedestrians and cyclists.
'''
      });

      print("Safety details added successfully!");
    } catch (error) {
      print("Error adding safety details: $error");
    }
  }
}

class SafetyDetails extends StatelessWidget {
  final String title;
  final String details;

  const SafetyDetails({required this.title, required this.details});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          details,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SafeTransport(),
  ));
}
