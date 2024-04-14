import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class PhotoVaultHomePage extends StatefulWidget {
  @override
  _PhotoVaultHomePageState createState() => _PhotoVaultHomePageState();
}

class _PhotoVaultHomePageState extends State<PhotoVaultHomePage> {
  List<File> _photos = [];
  late String _userIdentifier; // Unique identifier for the user (e.g., email or username)

  @override
  void initState() {
    super.initState();
    _getUserID();
  }

  Future<void> _getUserID() async {
    // Get the current user's ID
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userIdentifier = user.uid;
      });
      await _loadPhotos();
    } else {
      // Handle if no user is logged in
    }
  }

  Future<void> _loadPhotos() async {
    // Fetch the user's photos from Firestore
    final snapshot = await FirebaseFirestore.instance
        .collection('photos')
        .doc(_userIdentifier)
        .get();

    if (snapshot.exists) {
      // If photos exist, load them into the _photos list
      setState(() {
        _photos = List<File>.from(snapshot['paths'].map((path) => File(path)));
      });
    }
  }

  Future<void> _savePhotos() async {
    // Save the user's photos to Firestore
    List<String> paths = _photos.map((file) => file.path).toList();
    await FirebaseFirestore.instance
        .collection('photos')
        .doc(_userIdentifier)
        .set({'paths': paths});
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _photos.add(File(pickedFile.path));
      });
      await _savePhotos();
    }
  }

  Future<void> _deletePhoto(int index) async {
    setState(() {
      _photos.removeAt(index);
    });
    await _savePhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Vault'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: _photos.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Image.file(
                _photos[index],
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deletePhoto(index),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _pickImage(ImageSource.gallery);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

