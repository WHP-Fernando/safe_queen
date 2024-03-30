import 'package:flutter/material.dart';

class GuardianCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guardian Circle'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Guardian Circle',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
