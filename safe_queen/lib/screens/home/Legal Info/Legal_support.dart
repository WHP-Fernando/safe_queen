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
      title: 'Legal Support List', // Updated title
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LegalSupportPage(), // Updated home property
    );
  }
}

class LegalSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Legal Support List',
        style: TextStyle(
            fontWeight: FontWeight.bold, // Make the title bold
          ),
        ), 
         backgroundColor: Colors.yellow,
         centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 253, 238, 252), // background color
      body: ListView(
        children: [
          SizedBox(height: 20), // Add spacing
          LegalSupportTile(
            name: 'Legal Aid Commission of Sri Lanka (LAC)',
            location: '+94 112 134 597',
            phoneNumber: '+94 112 134 597',
          ),
          LegalSupportTile(
            name: 'Human Rights Commission of Sri Lanka (HRCSL)',
            location: '+94 112 505 309',
            phoneNumber: '+94 112 505 309',
          ),
          LegalSupportTile(
            name: 'Sri Lanka Bar Association (BASL)',
            location: '+94 112 433 751',
            phoneNumber: '+94 112 433 751',
          ),
          LegalSupportTile(
            name: 'Ministry of Women’s Empowerment and Social Welfare',
            location: '2368072',
            phoneNumber: '2368072',
          ),
          LegalSupportTile(
            name: 'Labor Rights Organizations',
            location: '+41 22 799 6264  ',
            phoneNumber: '+41 22 799 6264  ',
          ),
          LegalSupportTile(
            name: 'Legal Aid NGOs',
            location: '+94 81 2225807',
            phoneNumber: '+94 81 2225807',
          ),
          // Add more LegalSupportTiles for other legal support institutions
          // Example:
          // LegalSupportTile(
          //   name: 'Institution Name',
          //   location: 'Location',
          //   phoneNumber: 'Phone Number',
          // ),
        ],
      ),
    );
  }
}

class LegalSupportTile extends StatelessWidget {
  final String name;
  final String location;
  final String phoneNumber;

  const LegalSupportTile({
    required this.name,
    required this.location,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
      ),
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: ListTile(
        leading: Icon(Icons.business),
        title: Text(name),
        subtitle: Text(location),
        trailing: ElevatedButton(
          onPressed: () {
            directCall(phoneNumber);
            updateOrAddInstitution(name, location, phoneNumber);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent,
          ),
          child: Text('Call'),
        ),
      ),
    );
  }

  void directCall(String phoneNumber) async {
    await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }

  void updateOrAddInstitution(String name, String location, String phoneNumber) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('institutions')
        .where('name', isEqualTo: name)
        .get();

    if (snapshot.docs.isNotEmpty) {
      snapshot.docs.forEach((doc) {
        doc.reference.update({
          'location': location,
          'phoneNumber': phoneNumber,
          'lastCalled': DateTime.now(),
        });
      });
    } else {
      await FirebaseFirestore.instance.collection('institutions').add({
        'name': name,
        'location': location,
        'phoneNumber': phoneNumber,
        'lastCalled': DateTime.now(),
      });
    }
  }
}
