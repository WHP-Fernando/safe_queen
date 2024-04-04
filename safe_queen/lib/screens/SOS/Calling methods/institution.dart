import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Institution List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InstitutionList(),
    );
  }
}

class InstitutionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20), // Add spacing
          Center(
            child: Text(
              'Main Institutions Responsible\n     For Women In Sri Lanka',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 40), // Add spacing
          InstitutionTile(
            name: 'The Bureau of Children and Women',
            location: '0112 444 444',
            phoneNumber: '0112 444 444', // Add phone number for direct call
          ),
          InstitutionTile(
            name: 'Ministry of Women and Child Affairs',
            location: '011 2186055',
            phoneNumber: '011 2186055', // Add phone number for direct call
          ),
          InstitutionTile(
            name: 'Sri Lanka Police - Women Support',
            location: '0112 444 444',
            phoneNumber: '0112 444 444',
          ),
          InstitutionTile(
            name: 'Ministry of Women’s Empowerment and Social Welfare',
            location: '2368072',
            phoneNumber: '2368072',
          ),
          InstitutionTile(
            name: 'Women Development Centre',
            location: '94 081 2234511',
            phoneNumber: '94 081 2228158',
          ),
          InstitutionTile(
            name: 'Suriya Women Development Organisation',
            location: '+94 (0)65 222 3297',
            phoneNumber: '+94 (0)65 222 3297',
          ),
          InstitutionTile(
            name: 'General Hospital',
            location: '011-2691111',
            phoneNumber: '011-2691111',
          ),
          // Add more InstitutionTiles for other institutions
          // Example:
          // InstitutionTile(
          //   name: 'Institution Name',
          //   location: 'Location',
          //   phoneNumber: 'Phone Number',
          // ),
        ],
      ),
    );
  }
}

class InstitutionTile extends StatelessWidget {
  final String name;
  final String location;
  final String phoneNumber; // Add phoneNumber field

  const InstitutionTile({
    required this.name,
    required this.location,
    required this.phoneNumber, // Initialize phoneNumber field
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), // Circular border radius
        border: Border.all(color: Colors.grey), // Add grey border
      ),
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: ListTile(
        leading: Icon(Icons.business), // Add building icon
        title: Text(name),
        subtitle: Text(location),
        trailing: ElevatedButton(
          onPressed: () {
            directCall(phoneNumber); // Call directCall function with phoneNumber
            updateOrAddInstitution(name, location, phoneNumber); // Update or add institution data in Firestore
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent,
          ),
          child: Text('Call'),
        ),
      ),
    );
  }

  // Function to make direct call
  void directCall(String phoneNumber) async {
    await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }

  // Function to update or add institution data in Firestore
  void updateOrAddInstitution(String name, String location, String phoneNumber) async {
    // Query Firestore to find existing document with the given name
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('institutions')
        .where('name', isEqualTo: name)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // If document exists, update its data
      snapshot.docs.forEach((doc) {
        doc.reference.update({
          'location': location,
          'phoneNumber': phoneNumber,
          'lastCalled': DateTime.now(),
        });
      });
    } else {
      // If document doesn't exist, create a new one
      await FirebaseFirestore.instance.collection('institutions').add({
        'name': name,
        'location': location,
        'phoneNumber': phoneNumber,
        'lastCalled': DateTime.now(),
      });
    }
  }
}
