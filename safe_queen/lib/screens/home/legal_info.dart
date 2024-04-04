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
            SectionTitle(
              title: 'Laws and Regulations',
              onPressed: () {
                // Action when the button is pressed
                print('Laws and Regulations button pressed');
              },
            ),
            SizedBox(height: 20),
            SectionTitle(
              title: 'Legal Rights and Responsibilities',
              onPressed: () {
                // Action when the button is pressed
                print('Legal Rights and Responsibilities button pressed');
              },
            ),
            SizedBox(height: 20),
            SectionTitle(
              title: 'Legal Assistance and Support',
              onPressed: () {
                // Action when the button is pressed
                print('Legal Assistance and Support button pressed');
              },
            ),
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
    home: LegalInfo(),
  ));
}
