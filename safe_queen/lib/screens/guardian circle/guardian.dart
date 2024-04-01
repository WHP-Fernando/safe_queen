import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Guardian extends StatefulWidget {
  @override
  _GuardianState createState() => _GuardianState();
}

class _GuardianState extends State<Guardian> {
  List<Map<String, String>> contacts = [];

  // Controllers for the text fields
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  // Function to load contacts from SharedPreferences
  void loadContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? contactsData = prefs.getStringList('contacts');
    if (contactsData != null) {
      setState(() {
        contacts = contactsData
            .map((contact) => Map<String, String>.from(jsonDecode(contact)))
            .toList();
      });
    }
  }

  // Function to save contacts to SharedPreferences
  void saveContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> contactsData = contacts.map((contact) => jsonEncode(contact)).toList();
    prefs.setStringList('contacts', contactsData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            'Add your Trusted Contacts',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'You can only add 5 contacts',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black38,
            ),
          ),
          Expanded(
            child: Center(
              child: contacts.isEmpty
                  ? Text('No contacts added yet')
                  : ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(contacts[index]['name']!),
                          subtitle: Text(contacts[index]['phone']!),
                          trailing: IconButton(
                            icon: Icon(Icons.call),
                            onPressed: () {
                              // Implement call functionality
                              // You can use contacts[index]['phone'] to get the number to call
                            },
                          ),
                        );
                      },
                    ),
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(30.0),
              ),
              margin: EdgeInsets.all(20.0),
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: contacts.length >= 5
                    ? null
                    : () {
                        // Show dialog to add contact
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Add Contact'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter name',
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  TextField(
                                    controller: _phoneNumberController,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      hintText: 'Enter phone number',
                                    ),
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Add'),
                                  onPressed: () {
                                    // Add contact to the list
                                    String name = _nameController.text.trim();
                                    String phone = _phoneNumberController.text.trim();
                                    if (name.isNotEmpty && phone.isNotEmpty) {
                                      setState(() {
                                        contacts.add({'name': name, 'phone': phone});
                                      });
                                      _nameController.clear();
                                      _phoneNumberController.clear();
                                      saveContacts(); // Save contacts to SharedPreferences
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _nameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }
}
