import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LegalRightsScreen(),
  ));
}

class LegalRightsScreen extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Legal Rights',
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
            SizedBox(height: 10),
            _buildLegalRightTile(
              title: 'Right to Equality',
              description: 'Women in Sri Lanka have the right to equality before the law and equal protection of the law without discrimination based on gender. This right is enshrined in the Constitution of Sri Lanka.',
            ),
            _buildLegalRightTile(
              title: 'Right to Education',
              description: 'Women have the right to access education on an equal basis with men. Sri Lanka has made significant progress in achieving gender parity in education, with high levels of female enrollment in schools and universities.',
            ),
            _buildLegalRightTile(
              title: 'Right to Work',
              description: 'Women have the right to work and to be treated equally in employment opportunities and practices. The law prohibits discrimination in recruitment, promotion, and conditions of employment based on gender.',
            ),
            _buildLegalRightTile(
              title: 'Right to Health',
              description: 'Women have the right to access healthcare services, including reproductive healthcare and family planning services. Sri Lanka has made strides in improving maternal health and reducing maternal mortality rates.',
            ),
             _buildLegalRightTile(
              title: 'Protection from Violence',
              description: 'Women have the right to live free from violence and abuse. Various laws in Sri Lanka, such as the Prevention of Domestic Violence Act, provide legal protections and remedies for victims of domestic violence and other forms of gender-based violence.',
            ),
             _buildLegalRightTile(
              title: 'Property Rights',
              description: 'Women have the right to own, inherit, and manage property on an equal basis with men. However, customary laws and social norms may sometimes limit womens access to property rights, particularly in rural areas.',
            ),
             _buildLegalRightTile(
              title: 'Political Participation',
              description: 'Women have the right to participate in political processes and decision-making. Sri Lanka has taken steps to increase womens representation in politics, including through legislative measures such as quotas for women in local government.',
            ),
             _buildLegalRightTile(
              title: 'Family Rights',
              description: 'Women have rights within the family, including the right to choose their spouse, enter into marriage based on free and full consent, and access divorce and custody rights.',
            ),
             _buildLegalRightTile(
              title: 'Responsibilities as Citizens',
              description: 'Along with rights, women in Sri Lanka also have responsibilities as citizens, including obeying the law, paying taxes, and participating in civic duties such as voting and community service.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalRightTile({required String title, required String description}) {
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
