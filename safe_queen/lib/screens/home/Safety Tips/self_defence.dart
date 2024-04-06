import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SelfDefenseScreen(),
  ));
}

// ignore: must_be_immutable
class SelfDefenseScreen extends StatelessWidget {
  SelfDefenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Self-defense Techniques',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the title bold
          ),
        ),
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 253, 238, 252), //change background color
      body: ListView.builder(
        itemCount: techniques.length, // number count
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    '${(index + 1).toString().padLeft(2, '0')}. ${techniques[index]['title'] ?? ''}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildTechniqueTile(
                  title: techniques[index]['title'] ?? '',
                  description: techniques[index]['description'] ?? '',
                ),
                SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    techniques[index]['image'] ?? '',
                    fit: BoxFit.fitHeight,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTechniqueTile({required String title, required String description}) {
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

  List<Map<String, String>> techniques = [
    {
      'title': 'Palm Strike',
      'description': 'Aim for the attacker\'s nose or throat with the base of your palm.',
      'image': 'assets/images/self defence techniques/qxvn9uqewhu1gnesmlei.webp',
    },
    {
      'title': 'Groin Kick',
      'description': 'Kick the attacker\'s groin area with force using the front of your foot.',
      'image': 'assets/images/self defence techniques/f2262fc3fb55e672728d9a77408eba97.jpg',
    },
    {
      'title': 'Elbow Strike',
      'description': 'Use your elbow to strike the attacker\'s face or ribs in close combat.',
      'image': 'assets/images/self defence techniques/50dbd84e-ba01-4b14-a0f2-f65d1f4a53f0.jpg',
    },
    {
      'title': 'Knee Strike',
      'description': 'Lift your knee and drive it forcefully into the attacker\'s stomach or groin.',
      'image': 'assets/images/self defence techniques/download.jpeg',
    },
    {
      'title': 'Hammerfist Strike',
      'description': 'Bring your fist to your head and raise your elbow\' slightly upward.Explosively drive your fist forward and downward, allowing\' your elbow to rotate downward.',
      'image': 'assets/images/self defence techniques/x85fo2pzy9lww28nq71o.webp',
    },
    {
      'title': 'Bear Hug Attack',
      'description': 'If you are grabbed from behind, you should try to lower\' yourself from the waist which will shift your weight forward,\' making it more difficult for them to control you. Then using\' your elbow, turn to the attacker and strike them in the face.',
      'image': 'assets/images/self defence techniques/vg29o.jpg',
    },
    {
      'title': 'How to free your hands',
      'description': 'You can easily escape a stronghold if you remember the “rule of thumb,” which\' is to rotate your arm to the side of the attacker’s thumb.',
      'image': 'assets/images/self defence techniques/c9777352a8951625ebaf6bf919.jpg.webp',
    },
    {
      'title': 'If grabbed from front',
      'description': 'Move your hands forward and make a fist in front of your pelvis.',
      'image': 'assets/images/self defence techniques/3dc41b549496f9ed2651dc1a1f.jpg.webp',
    },
    {
      'title': 'If you grabbed from behind',
      'description': 'To set yourself free, quickly bend back and try to hit the attacker with the back of your head.\' It’s okay if you can’t do it — the point is to make\' the attacker put one of the legs forward.',
      'image': 'assets/images/self defence techniques/f37c3058c389fdd723577d3894.jpg.webp',
    },
    {
      'title': 'If you pushed against the wall',
      'description': 'n this situation, it’s necessary to remember\' the most vulnerable places and hit one of them depending\' on your position.',
      'image': 'assets/images/self defence techniques/ae5f5257f59ad3c8c9128c090e.jpg.webp',
    },
  ];
}
 
 