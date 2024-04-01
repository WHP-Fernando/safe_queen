import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

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
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),
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
  }
}
