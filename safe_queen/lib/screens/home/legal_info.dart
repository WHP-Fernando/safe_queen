import 'package:flutter/material.dart';

class LegalInfo extends StatelessWidget {
  const LegalInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Legal Information'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: 'Terms and Conditions'),
            SizedBox(height: 10),
            SectionText(text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...'),
            SizedBox(height: 20),
            SectionTitle(title: 'Privacy Policy'),
            SizedBox(height: 10),
            SectionText(text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...'),
            SizedBox(height: 20),
            SectionTitle(title: 'Disclaimer'),
            SizedBox(height: 10),
            SectionText(text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...'),
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

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LegalInfo(),
  ));
}
