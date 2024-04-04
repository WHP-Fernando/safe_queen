import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Police List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PoliceList(),
    );
  }
}

class PoliceList extends StatefulWidget {
  @override
  _PoliceListState createState() => _PoliceListState();
}

class _PoliceListState extends State<PoliceList> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          SizedBox(height: 20), // Add spacing
          Center(
            child: Text(
              ' District Police Stations \nResponsible for women',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),
            ),
          ),
          SizedBox(height: 10), // Add spacing
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Police Station',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: _buildFilteredPoliceStationTiles(),
            ),
          ),
        ],
      ),
    );
  }

  List<PoliceStationTile> _buildFilteredPoliceStationTiles() {
    return policeStations
        .where((station) =>
            station.name.toLowerCase().contains(_searchQuery))
        .map((station) => PoliceStationTile(
      name: station.name,
      number: station.number,
    ))
        .toList();
  }
}

class PoliceStationTile extends StatelessWidget {
  final String name;
  final String number;

  const PoliceStationTile({
    required this.name,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, // Change border color as needed
          width: 2.0, // Adjust border width as needed
        ),
        borderRadius: BorderRadius.circular(10.0), // Adjust border radius as needed
      ),
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Row(
        children: [
          Icon(Icons.security), // Add security icon
          SizedBox(width: 10), // Add spacing between icon and text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  number,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              directCall(number);
              updateOrAddPoliceStation(name, number);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),
            ),
            child: Text('Call'),
          ),
        ],
      ),
    );
  }

  void directCall(String phoneNumber) async {
    await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }

  void updateOrAddPoliceStation(String name, String number) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('policeStations')
        .where('name', isEqualTo: name)
        .get();

    if (snapshot.docs.isNotEmpty) {
      snapshot.docs.forEach((doc) {
        doc.reference.update({
          'number': number,
          'lastCalled': DateTime.now(),
        });
      });
    } else {
      await FirebaseFirestore.instance.collection('policeStations').add({
        'name': name,
        'number': number,
        'lastCalled': DateTime.now(),
      });
    }
  }
}

// Define a class to represent police stations
class PoliceStation {
  final String name;
  final String number;

  PoliceStation({
    required this.name,
    required this.number,
  });
}

// Define a list of police stations
List<PoliceStation> policeStations = [
  PoliceStation(name: 'Colombo Police Station', number: '0112524411'),
  PoliceStation(name: 'Gampaha Police Station', number: '0332222223'), 
  PoliceStation(name: 'Kalutara Police Station', number: '0342238884'),
  PoliceStation(name: 'Kandy Police Station', number: '0812204775'),
  PoliceStation(name: 'Matale Police Station', number: '0662233558'),
  PoliceStation(name: 'Nuwara Eliya Police Station', number: '0522224870'),
  PoliceStation(name: 'Galle Police Station', number: '0912247457'),
  PoliceStation(name: 'Matara Police Station', number: '0412222259'),
  PoliceStation(name: 'Tangalle Police Station', number: '0472241604'),
  PoliceStation(name: 'Jaffna Police Station', number: '0212214063'),
  PoliceStation(name: 'Kilinochchi Police Station', number: '0212236467'),
  PoliceStation(name: 'Mannar Police Station', number: '0232251923'),
  PoliceStation(name: 'Vavuniya Police Station', number: '0242224452'),
  PoliceStation(name: 'Mullaitivu Police Station', number: '0212290022'),
  PoliceStation(name: 'Batticaloa Police Station', number: '0652225282'),
  PoliceStation(name: 'Ampara Police Station', number: '0632224963'),
  PoliceStation(name: 'Trincomalee Police Station', number: '0262222222'),
  PoliceStation(name: 'Kurunegala Police Station', number: '0372226204'),
  PoliceStation(name: 'Puttalam Police Station', number: '0322266493'),
  PoliceStation(name: 'Anuradhapura Police Station', number: '0252225919'),
  PoliceStation(name: 'Polonnaruwa Police Station', number: '0272222222'),
  PoliceStation(name: 'Badulla Police Station', number: '0552232679'),
  PoliceStation(name: 'Moneragala Police Station', number: '0552277675'),
  PoliceStation(name: 'Ratnapura Police Station', number: '0452225232'),
  PoliceStation(name: 'Kegalle Police Station', number: '0352222674'),// Add more police stations here as needed
];
