import 'package:flutter/material.dart';

class SafetyTips extends StatelessWidget {
  const SafetyTips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Safety Tips'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: 'General Safety Tips'),
            SizedBox(height: 10),
            SectionText(text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...'),
            SizedBox(height: 20),
            SectionTitle(title: 'Safety Tips for Traveling Alone'),
            SizedBox(height: 10),
            SectionText(text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...'),
            SizedBox(height: 20),
            SectionTitle(title: 'Safety Tips for Public Transport'),
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
    home: SafetyTips(),
  ));
}
