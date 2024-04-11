import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 253, 238, 252),
        title: Text(
          'About Safe Queen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color.fromARGB(255, 253, 238, 252),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Safe Queen',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Safe Queen is dedicated to promoting safety and security for women in all aspects of life. Our mission is to provide resources, tips, and support to empower women to protect themselves and stay safe in various situations.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.justify, // Align text to justify
            ),
            SizedBox(height: 40), // Increased spacing
            Text(
              'Meet Our Team',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/IMG_6211.JPG'),
              ),
              title: Text(
                'W.H.P.Fernando',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                'Founder & CEO',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.black),
              title: Text(
                '0768867578',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                'himansa2226@gmail.com',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              onTap: () {
                directCall('0768867578');
              },
            ),
          ],
        ),
      ),
    );
  }

  void directCall(String phoneNumber) async {
    await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AboutUsPage(),
  ));
}
