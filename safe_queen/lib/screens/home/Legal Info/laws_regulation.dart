import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LawsAndRegulationsScreen(),
  ));
}

class LawsAndRegulationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Laws & Regulations',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the title bold
          ),
        ),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 253, 238, 252), //background color
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                'Sexual harassment is considered a criminal offense when it takes place in public places, on public transport, and in the workplace. In 2005, the Sri Lankan parliament took another step towards protecting women from gender-based violence when it unanimously passed the Prevention of Domestic Violence Act.',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 10),
            _buildLawTile(
              title: 'Prevention of Domestic Violence Act No. 34 of 2005',
              description: 'This act aims to provide protection for victims of domestic violence, including women and children, by establishing procedures for the prevention and punishment of domestic violence.',
            ),
            _buildLawTile(
              title: 'Women’s Charter (National Plan of Action for Women)',
              description: 'This charter outlines various measures to promote and protect the rights of women in Sri Lanka, including measures to prevent violence against women, promote women health, and ensure equal opportunities for women in education and employment',
            ),
            _buildLawTile(
              title: 'Penal Code',
              description: 'Several sections of the Penal Code of Sri Lanka address crimes against women, including sections on rape, sexual harassment, and domestic violence.',
            ),
            _buildLawTile(
              title: 'Protection of Victims of Crime and Witnesses Act No. 4 of 2015',
              description: 'This act provides for the protection and support of victims of crime, including victims of gender-based violence, and ensures their rights and interests are safeguarded throughout legal proceedings.',
            ),
            _buildLawTile(
              title: 'Muslim Marriage and Divorce Act',
              description: 'This act governs marriage and divorce among the Muslim community in Sri Lanka and includes provisions related to the protection of womens rights within marriage.',
            ),
            _buildLawTile(
              title: 'Employment of Women, Young Persons, and Children Act No. 47 of 1956',
              description: 'This act regulates the employment conditions of women, young persons, and children, including provisions for their safety and welfare in the workplace.',
            ),
           _buildLawTile(
              title: 'National Human Rights Action Plan for Sri Lanka (2017-2021)',
              description: 'This plan includes measures to address gender-based violence and discrimination against women and girls, promote womens rights, and improve access to justice for women.',
            ), 
          ],
        ),
      ),
    );
  }

  Widget _buildLawTile({required String title, required String description}) {
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
          Icons.gavel,
          color: Colors.orange,
          size: 32,
        ),
      ),
    );
  }
}
