import 'package:flutter/material.dart';
import 'package:safe_queen/screens/home/Legal%20Info/Legal_rights.dart';
import 'package:safe_queen/screens/home/Legal%20Info/Legal_support.dart';
import 'package:safe_queen/screens/home/Legal%20Info/extract_UNWomens.dart';
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
        backgroundColor: Colors.yellow,  
      ),
      backgroundColor: Color.fromARGB(255, 253, 238, 252),  
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
              title: 'Laws and Regulations',
              onPressed: () { 
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
              title: 'Fighting Domestic Violence',
              onPressed: () { 
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyWebExtractorApp(),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            SectionTitle(
              title: 'Legal Assistance and Support',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LegalSupportPage(),
                  ),
                );
              },
              buttonColor: Colors.green,  
              borderColor: Colors.black,  
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
  final Color? buttonColor;
  final Color? borderColor;

  const SectionTitle({required this.title, this.onPressed, this.buttonColor, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          backgroundColor: buttonColor ?? Colors.blue,  
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: borderColor ?? Colors.blue),  
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,  
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
