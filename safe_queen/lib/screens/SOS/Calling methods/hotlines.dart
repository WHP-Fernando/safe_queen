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
      title: 'Hotline App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HotlineList(),
    );
  }
}

class HotlineList extends StatelessWidget {
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
              'Women Safety Hotlines \n         In Sri Lanka',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20), // Add spacing
          HotlineTile(
            title: 'The Bureau of Children and Women',
            number: '109',
          ),
          HotlineTile(
            title: 'Ministry of Women and Child Affairs',
            number: '1938',
          ),
          HotlineTile(
            title: 'Police Emergency',
            number: '119 ',
          ),
          // Add more HotlineTiles for other hotlines
          // Example:
          // HotlineTile(
          //   title: 'Hotline Name',
          //   number: 'Phone Number',
          // ),
        ],
      ),
    );
  }
}

class HotlineTile extends StatelessWidget {
  final String title;
  final String number;

  const HotlineTile({
    required this.title,
    required this.number,
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
        leading: Icon(Icons.phone), // Add hotline icon
        title: Text(title),
        subtitle: Text(number),
        trailing: ElevatedButton(
          onPressed: () {
            directCall(number); // Call directCall function with the number
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent, // Change button color to green
          ),
          child: Text('Call'),
        ),
      ),
    );
  }

  // Function to make direct call
  void directCall(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);

    // Query Firestore to find existing document with the given number
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('hotlines')
        .where('number', isEqualTo: number)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // If document exists, update its data
      snapshot.docs.forEach((doc) {
        doc.reference.update({
          'title': title,
          'number': number,
          'lastCalled': DateTime.now(),
        });
      });
    } else {
      // If document doesn't exist, create a new one
      await FirebaseFirestore.instance.collection('hotlines').add({
        'title': title,
        'number': number,
        'lastCalled': DateTime.now(),
      });
    }
  }
}
