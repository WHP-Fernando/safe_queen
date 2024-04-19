import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';  
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';  
import 'package:geolocator/geolocator.dart';  
import 'package:safe_queen/screens/guardian%20circle/contact_model.dart';
import 'package:safe_queen/screens/home/Community_chat.dart';
import 'package:safe_queen/screens/home/home.dart';
import 'package:safe_queen/screens/profiles/profile.dart';

class GuardianScreen extends StatefulWidget {
  @override
  _GuardianScreenState createState() => _GuardianScreenState();
}

class _GuardianScreenState extends State<GuardianScreen> {
  late List<Contact> contacts = [];
  late String currentLocation = '';

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    loadContacts();
  }

  Future<void> _checkPermissions() async {
    // Check if location permission is granted
    PermissionStatus locationStatus = await Permission.location.status;
    if (!locationStatus.isGranted) {
      // Request location permission
      await Permission.location.request();
    }
    // Check if SMS permission is granted
    PermissionStatus smsStatus = await Permission.sms.status;
    if (!smsStatus.isGranted) {
      // Request SMS permission
      await Permission.sms.request();
    }
  }

  Future<void> loadContacts() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('contacts')
          .where('userId', isEqualTo: userId)
          .get();
      setState(() {
        contacts = snapshot.docs.map<Contact>((doc) => Contact(
              id: doc.id,
              name: doc['name'],
              phoneNumber: doc['phoneNumber'],
            )).toList();
      });
    }
  }

  Future<void> addContact(Contact contact) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null && contacts.length < 5) {
      await FirebaseFirestore.instance.collection('contacts').add({
        'userId': userId,
        'name': contact.name,
        'phoneNumber': contact.phoneNumber,
      });
      await loadContacts();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Cannot Add Contact"),
            content:
                Text("You have reached the maximum limit of contacts (5)."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> deleteContact(String id) async {
    await FirebaseFirestore.instance.collection('contacts').doc(id).delete();
    await loadContacts();
  }

  Future<void> directCall(String phoneNumber) async {
    try {
      await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    } catch (e) {
      print("Error while calling: $e");
    }
  }

  // Method to send SMS using platform channels
  Future<void> sendSMSAlert(String phoneNumber, String message) async {
    try {
      // Get current location
      Position position =
          await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      double latitude = position.latitude;
      double longitude = position.longitude;

      // Construct Google Maps link
      String mapsLink = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

      // Construct message with location link
      String messageWithLocation = '$message\nLocation: $mapsLink';

      // Check if permission is granted
      PermissionStatus status = await Permission.sms.status;
      if (status.isGranted) {
        // Permission is granted, proceed with sending SMS
        await MethodChannel('platform_service')
            .invokeMethod('sendSMSAlert', {'phoneNumber': phoneNumber, 'message': messageWithLocation});
      } else {
        // Permission is not granted, handle accordingly (show error message, etc.)
        print('Permission denied for sending SMS');
      }
    } catch (e) {
      print("Error while sending SMS alert: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color.fromARGB(255, 253, 238, 252),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 253, 238, 252), // Background color
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Add Your Trusted Contacts",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                "You Can Add Only 5 Numbers",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            SizedBox(height: 40.0),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Card(
                      elevation: 3,
                      color: Color.fromARGB(210, 249, 243, 243),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(contact.name),
                        subtitle: Text(contact.phoneNumber),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.phone),
                              onPressed: () {
                                // Call the function to make a direct call
                                directCall(contact.phoneNumber);
                              },
                              color: Colors.green,
                            ),
                            IconButton(
                              icon: Icon(Icons.message),
                              onPressed: () {
                                // Call sendSMSAlert method with relevant phone number and message
                                sendSMSAlert(contact.phoneNumber, 'Emergency! Need your help!');
                              },
                              color: Colors.blueAccent,
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Delete Contact"),
                                      content: Text("Are you sure you want to delete this contact?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            deleteContact(contact.id);
                                          },
                                          child: Text("Delete"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              color: Colors.redAccent, //change the color of the icon button
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 249, 40, 217), //button color
        child: Icon(Icons.add, color: Colors.white), //icon color
        onPressed: () async {
          final newContact = await showDialog<Contact>(
            context: context,
            builder: (context) => AddContactDialog(),
          );
          if (newContact != null) {
            await addContact(newContact);
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle_outlined, size: 30),
            label: 'Guardian Circle',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_3_rounded, size: 33),
            label: 'Community Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded, size: 30),
            label: 'Profile',
          ),
        ],
         currentIndex: 1, // Index of Guardian Circle screen
        selectedItemColor: Colors.pink,
        selectedLabelStyle: TextStyle(fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        backgroundColor: Color.fromARGB(255, 253, 243, 252),
        onTap: (int index) {
          // Handle navigation here...
          switch (index) {
            case 0:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
              break;
            case 1:
              // Current screen, do nothing
              break;
            case 2:
              // Navigate to Community Chat screen
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CommunityChat()));
              break;
            case 3:
              // Navigate to Profile screen
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profile()));
              break;
          }
        }
      ),
    );
  }
}

class AddContactDialog extends StatefulWidget {
  @override
  _AddContactDialogState createState() => _AddContactDialogState();
}

class _AddContactDialogState extends State<AddContactDialog> {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Contact'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _phoneNumberController,
            decoration: InputDecoration(labelText: 'Phone Number'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final name = _nameController.text;
            final phoneNumber = _phoneNumberController.text;
            if (name.isNotEmpty && phoneNumber.isNotEmpty) {
              final newContact = Contact(id: '', name: name, phoneNumber: phoneNumber);
              Navigator.pop(context, newContact);
            } else {
              // Show error message
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
