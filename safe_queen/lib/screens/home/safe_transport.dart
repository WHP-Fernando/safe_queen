import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SafeTransport(),
  ));
}

class SafeTransport extends StatelessWidget {
  const SafeTransport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize Firebase  
    if (Firebase.apps.isEmpty) {
      Firebase.initializeApp();
    }

    // Push safety details to Firebase
    pushSafetyDetails();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo, // Change app bar color
        title: Text(
          'Safe Transport',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 253, 238, 252), //change background color
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionCard(
              title: 'Safety Tips for Taking Public Transport',
              description: 'Stay safe while using public transportation.',
              points: [
                'Plan Route: Research and choose safe, well-lit routes.',
                'Stay Aware: Remain alert and avoid distractions.',
                'Travel in Groups: Safety in numbers, especially at night.',
                'Inform Someone: Share your travel plans with a trusted person.',
                'Use Trusted Transport: Stick to reputable modes of transportation.',
                'Stay Visible: Stand in visible, populated areas while waiting.',
                'Keep Valuables Secure: Conceal valuables and keep belongings close.',
                'Sit Near Staff: Choose seats near drivers or conductors for safety.',
                'Trust Instincts: If something feels wrong, act on your instincts.',
                'Emergency Contacts: Keep emergency contacts easily accessible.',
                'Learn Self-Defense: Consider self-defense classes for empowerment.',
                'Report Suspicious Activity: Notify authorities of any concerns promptly.',
              ],
              imagePath: 'assets/images/future-public-transport-2030-electric-future-london-evening-standard.jpg', // Add image path
            ),
            SizedBox(height: 20),
            SectionCard(
              title: 'Safety Tips for Walking Alone  ',
              description: 'Stay safe while working alone .',
              points: [
                'Stay Aware: Be alert and attentive to your surroundings. Avoid distractions like using your phone excessively or wearing headphones.',
                'Stay in Well-Lit Areas: Stick to well-lit streets and avoid dimly lit or secluded areas.',
                'Avoid Alcohol and Drugs: Stay sober and avoid consuming alcohol or drugs, as they can impair your judgment and reaction time.',
                'Stay Connected: Let someone know your whereabouts and expected arrival time, especially if youre traveling alone at night.',
                'Walk Confidently: Walk with confidence and purpose, and avoid appearing vulnerable or lost.',
                'Carry Safety Essentials: Consider carrying safety essentials like a personal alarm, pepper spray, or a flashlight for added security.',
                'Avoid Engaging with Strangers: Be cautious when interacting with strangers, and avoid giving out personal information or engaging in conversations that make you uncomfortable.',
                'Stay Updated: Stay informed about local safety alerts or incidents in your area and adjust your plans accordingly.',
                'Learn Self-Defense: Consider taking self-defense classes to learn techniques for protecting yourself in case of an emergency.',
              ],
              imagePath: 'assets/images/alone-at-night.jpg', // Add image path
            ),
            SizedBox(height: 20),
            SectionCard(
              title: 'Safety Tips for Driving',
              description: 'Stay safe while driving.',
              points: [
                'Keep Your Doors Locked: Always keep your doors locked, especially when driving alone or in unfamiliar areas.',
                'Stay Alert: Pay attention to your surroundings and stay focused on the road at all times. Avoid distractions like texting, eating, or adjusting the radio while driving.',
                'Plan Your Route: Before starting your journey, plan your route and familiarize yourself with the directions. Avoid unfamiliar or poorly lit areas, especially at night.',
                'Keep Valuables Out of Sight: Avoid leaving valuables such as handbags, laptops, or shopping bags visible in the car. Store them in the trunk or out of sight to deter theft.',
                'Maintain Your Vehicle: Regularly maintain your vehicle by checking the tires, brakes, lights, and fluid levels. A well-maintained vehicle is less likely to break down unexpectedly.',
                'Keep Your Phone Handy: Always have your phone charged and easily accessible in case of emergencies. Consider keeping a portable charger in your car for longer journeys.',
                'Trust Your Intuition: If you feel unsafe or uncomfortable while driving, trust your instincts. Consider changing your route or finding a safe place to pull over if necessary.',
                'Stay in Well-Lit Areas: When parking or stopping, choose well-lit areas with high visibility. Avoid secluded areas or dark alleys, especially at night.',
                'Lock Your Car: When parked, always lock your car and roll up the windows, even if youre only stepping away for a short time. This reduces the risk of theft or break-ins.',
                'Carry Emergency Supplies: Keep emergency supplies in your car, including a first aid kit, flashlight, water, non-perishable snacks, and a blanket. These items can be useful in case of breakdowns or accidents.',
                'Follow Traffic Laws: Obey traffic laws, speed limits, and road signs at all times. Avoid aggressive driving behaviors and maintain a safe distance from other vehicles.',
              ],
              imagePath: 'assets/images/Depositphotos_8874368_XL-min-scaled.jpg', // Add image path
            ),
          ],
        ),
      ),
    );
  }

  // Function to push safety details to Firebase Realtime Database
  void pushSafetyDetails() {
    try {
      DatabaseReference reference = FirebaseDatabase.instance.reference().child('safety_details');

      reference.push().set({
        'title': 'Safety Tips for Taking Public Transport',
        'description': 'Stay safe while using public transportation.',
        'points': [
          'Wait for public transport in well-lit areas.',
          'Stand away from the curb while waiting for a bus or train.',
          'Sit near the driver or conductor if possible.',
          'Avoid using headphones at night.',
          'Be aware of your surroundings.',
        ],
      });

      reference.push().set({
        'title': 'Safety Tips for Riding a Bike',
        'description': 'Stay safe while riding a bike.',
        'points': [
          'Always wear a helmet.',
          'Use hand signals to indicate turns.',
          'Ride in the same direction as traffic.',
          'Obey traffic signs and signals.',
          'Wear bright or reflective clothing, especially at night.',
        ],
      });

      reference.push().set({
        'title': 'Safety Tips for Driving',
        'description': 'Stay safe while driving.',
        'points': [
          'Wear your seatbelt at all times.',
          'Follow speed limits and traffic laws.',
          'Avoid distractions such as texting or talking on the phone.',
          'Keep a safe distance from other vehicles.',
          'Be mindful of pedestrians and cyclists.',
        ],
      });

      print("Safety details added successfully!");
    } catch (error) {
      print("Error adding safety details: $error");
    }
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> points;
  final String imagePath;

  const SectionCard({
    required this.title,
    required this.description,
    required this.points,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Add elevation for a modern look
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Add rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          Image.asset(
            imagePath,
            width: double.infinity, // Set width to occupy full screen width
            height: 150, // Adjust height as needed
            fit: BoxFit.cover, // Ensure the image covers the entire space
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: points
                      .map((point) => Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    point,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
