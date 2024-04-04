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
            SectionTitle(title: 'General Safety Tips', onPressed: () {
              // Action when the button is pressed
              print('General Safety Tips button pressed');
            }),
            SizedBox(height: 20),
            SectionTitle(title: 'Safety Tips for Traveling Alone', onPressed: () {
             // Action when the button is pressed
              print('Safety Tips for Traveling Alone button pressed');
            }),
            SizedBox(height: 20),
            SectionTitle(title: 'Safety Tips for Public Transport', onPressed: () {
              // Action when the button is pressed
              print('Safety Tips for Public Transport button pressed');
            }),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const SectionTitle({required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SafetyTips(),
  ));
}
