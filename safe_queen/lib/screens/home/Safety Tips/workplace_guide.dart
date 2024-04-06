import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WorkplaceSafetyScreen(),
  ));
}

class WorkplaceSafetyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Workplace Safety Guidelines',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the title bold
          ),
        ),
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 253, 238, 252), //change background color
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250, // Adjusted height of the image
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/self defence techniques/images-removebg-preview.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),
            _buildGuidelineTile(
              title: ' 01.Keep Work Area Clean',
              description: 'Clean up spills and clutter to prevent accidents and injuries.',
            ),
            _buildGuidelineTile(
              title: '02.Use Safety Equipment',
              description: 'Always wear appropriate safety gear for your job tasks.',
            ),
            _buildGuidelineTile(
              title: '03.Report Hazards',
              description: 'Report any safety hazards or concerns to your supervisor immediately.',
            ),
            _buildGuidelineTile(
              title: '04.Practice Ergonomics',
              description: 'Maintain proper posture and use ergonomic tools to prevent strain injuries.',
            ),
            
            _buildGuidelineTile(
              title: '05.Know Your Rights',
              description: 'Understand workplace safety laws and policies, including anti-discrimination and harassment regulations.',
            ),
            _buildGuidelineTile(
              title: '06.Stay Informed',
              description: 'Attend safety training sessions and stay updated on workplace hazards and emergency procedures.',
            ),
            _buildGuidelineTile(
              title: '07.Report Hazards',
              description: 'Report any unsafe conditions or equipment to your supervisor immediately.',
            ),
            _buildGuidelineTile(
              title: '08.Use PPE',
              description: 'Wear personal protective equipment like gloves, safety glasses, and proper footwear.',
            ),
            _buildGuidelineTile(
              title: '09.Practice Safe Lifting',
              description: 'Lift with your legs, not your back, and ask for help with heavy objects if needed.',
            ),
            _buildGuidelineTile( 
              title: '10.Maintain Balance',
              description: 'Prioritize work-life balance to prevent burnout and stress-related issues.',
            ),
            _buildGuidelineTile(
              title: '11.Be Prepared',
              description: 'Know emergency evacuation routes and procedures, and keep emergency contacts handy.',
            ),
            _buildGuidelineTile(
              title: '12.Travel Safely',
              description: 'Take precautions when traveling for work, and trust your instincts in unfamiliar situations.',
            ),
            _buildGuidelineTile( 
              title: '13.Seek Support',
              description: 'If you feel unsafe, speak up and seek support from your supervisor or HR department.',
            ),
            _buildGuidelineTile(
              title: '14.Stay Vigilant',
              description: 'Stay aware of your surroundings and trust your instincts to ensure your safety at work.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidelineTile({required String title, required String description}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(description),
        leading: Icon(
          Icons.security,
          color: Colors.green,
          size: 32,
        ),
      ),
    );
  }

  Widget _buildNumberedGuidelineTile({required String number, required String title, required String description}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              number,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4), // Adjust spacing between number and title
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        subtitle: Text(description),
        leading: Icon(
          Icons.security,
          color: Colors.greenAccent,
          size: 32,
        ),
      ),
    );
  }
}
