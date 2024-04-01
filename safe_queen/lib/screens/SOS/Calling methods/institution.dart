import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

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
          ),// Add more InstitutionTiles for other institutions
          InstitutionTile(
          name: 'Suriya Women Development Organisation', 
          location: '+94 (0)65 222 3297', 
          phoneNumber: '+94 (0)65 222 3297',
          ),
          InstitutionTile(
          name: 'General Hospital', 
          location: '011-2691111', 
          phoneNumber: '011-2691111',
          ),// Add m// Example:
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
}
