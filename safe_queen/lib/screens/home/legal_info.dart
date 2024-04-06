import 'package:flutter/material.dart';
import 'package:safe_queen/screens/home/Legal%20Info/Legal_rights.dart';
import 'package:safe_queen/screens/home/Legal%20Info/Legal_support.dart';
import 'package:safe_queen/screens/home/Legal%20Info/laws_regulation.dart';

class LegalInfo extends StatelessWidget {
  const LegalInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Legal Information',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow, // Change app bar color to yellow
      ),
      backgroundColor: Color.fromARGB(255, 253, 238, 252), //change background color
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
              title: 'Laws and Regulations',
              onPressed: () {
                // Navigate to LawsAndRegulationsScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LawsAndRegulationsScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            SectionTitle(
              title: 'Legal Rights and Responsibilities',
              onPressed: () {
                // Navigate to LegalRightsAndResponsibilitiesScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LegalRightsScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            SectionTitle(
              title: 'Legal Assistance and Support',
              onPressed: () {
                // Navigate to LegalAssistanceAndSupportScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LegalSupportPage(),
                  ),
                );
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
          padding: EdgeInsets.symmetric(vertical: 20.0), backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ), // Change button color to blue
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Change text color to white
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
