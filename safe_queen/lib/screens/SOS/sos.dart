import 'package:flutter/material.dart';
import 'package:safe_queen/screens/SOS/Calling%20methods/hotlines.dart';
import 'package:safe_queen/screens/SOS/Calling%20methods/institution.dart';
import 'package:safe_queen/screens/SOS/Calling%20methods/police_list.dart';

class SOS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'What help do you require?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30), // Add spacing between text and image
            Image.asset(
              'assets/images/hands-people-holding-help-placards-persons-with-signs-asking-help-donations-flat-vector-illustration-support-assistance-charity-concept-banner-website-design-landing-web-page_74855-26040.png', // Replace with your image path
              height: 190, // Set the height of the image
            ),
            SizedBox(height: 40), // Add spacing between image and buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PoliceList()),
                );
              },
              child: Text(
                'District Police',
                style: TextStyle(fontSize: 18, color: Colors.white), // Set the text size here
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent, // Set the button color here
                minimumSize: Size(200, 50), // Set the size of the button
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InstitutionList()),
                );
              },
              child: Text(
                'Institutions',
                style: TextStyle(fontSize: 18, color: Colors.white ), // Set the text size here
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent, // Set the button color here
                minimumSize: Size(200, 50), // Set the size of the button
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HotlineList()),
                );
              },
              child: Text(
                'Hotlines',
                style: TextStyle(fontSize: 18,color: Colors.white), // Set the text size here
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent, // Set the button color here
                minimumSize: Size(200, 50), // Set the size of the button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
