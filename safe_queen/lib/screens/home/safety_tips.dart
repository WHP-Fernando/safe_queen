import 'package:flutter/material.dart';
import 'package:safe_queen/screens/home/Safety%20Tips/Web_tricks.dart';
import 'package:safe_queen/screens/home/Safety%20Tips/self_defence.dart';
import 'package:safe_queen/screens/home/Safety%20Tips/workplace_guide.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SafetyTips(),
  ));
}

class SafetyTips extends StatelessWidget {
  const SafetyTips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent, // Change app bar color
        title: Text(
          'Safety Tips & Techniques',
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SafetyTechniqueButton(
                buttonText: 'Self-defense techniques',
                image: 'assets/images/images.jpeg',
                onPressed: () {
                   Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelfDefenseScreen(),
                  ),
                   );
                },
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SafetyTechniqueButton(
                buttonText: 'Workplace safety guidelines',
                image: 'assets/images/image.jpeg',
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkplaceSafetyScreen(),
                  ),
                  );
                },
              ),
            ),
             Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SafetyTechniqueButton(
                buttonText: 'Web Extract Tips',
                image: 'assets/images/images copy.jpeg',
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => webextracttips(),
                  ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SafetyTechniqueButton extends StatelessWidget {
  final String buttonText;
  final String image;
  final VoidCallback onPressed;

  const SafetyTechniqueButton({
    required this.buttonText,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 5,
                  color: Colors.black,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
 


 
 