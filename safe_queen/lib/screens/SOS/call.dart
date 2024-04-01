import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

class callinflutter extends StatefulWidget {
  const callinflutter({super.key});

  @override
  State<callinflutter> createState() => _callinflutterState();
}

class _callinflutterState extends State<callinflutter> {


Uri dialnumber=Uri(scheme: 'tel',path: '123456789');


callnumber()async{
  await launchUrl(dialnumber);
}


directcall()async{
  await FlutterPhoneDirectCaller.callNumber('123456789');
}

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("call in flutter"),
        centerTitle: true,
      ),
      body: Center(
       child: ElevatedButton.icon(
        onPressed: directcall,
        icon: Icon(Icons.call), 
        label: Text("Call")),
        ),
    );
  }
}