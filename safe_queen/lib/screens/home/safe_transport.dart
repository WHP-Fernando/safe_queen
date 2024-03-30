import 'package:flutter/material.dart';

class SafeTransport extends StatelessWidget {
  const SafeTransport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Safe Transport Information'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: 'Safety Guidelines'),
            SizedBox(height: 10),
            SectionText(text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...'),
            SizedBox(height: 20),
            SectionTitle(title: 'Emergency Contacts'),
            SizedBox(height: 10),
            EmergencyContact(
              title: 'Police',
              phoneNumber: '911',
            ),
            EmergencyContact(
              title: 'Fire Department',
              phoneNumber: '911',
            ),
            EmergencyContact(
              title: 'Hospital',
              phoneNumber: '911',
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class SectionText extends StatelessWidget {
  final String text;

  const SectionText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 16),
    );
  }
}

class EmergencyContact extends StatelessWidget {
  final String title;
  final String phoneNumber;

  const EmergencyContact({required this.title, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(phoneNumber),
      leading: Icon(Icons.contact_phone),
      onTap: () {
        // Implement call functionality here
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SafeTransport(),
  ));
}
