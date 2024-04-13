import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(PhotoVault());
}

class PhotoVault extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Vault',
      home: PhotoVaultHomePage(),
    );
  }
}

class PhotoVaultHomePage extends StatefulWidget {
  @override
  _PhotoVaultHomePageState createState() => _PhotoVaultHomePageState();
}

class _PhotoVaultHomePageState extends State<PhotoVaultHomePage> {
  List<File> _photos = [];
  late SharedPreferences _prefs;
  late String _userIdentifier; // Unique identifier for the user (e.g., user ID)

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    _prefs = await SharedPreferences.getInstance();
    // Replace 'userIdentifier' with the actual unique identifier for the user (e.g., user ID)
    _userIdentifier = _prefs.getString('userIdentifier') ?? ''; 
    await _loadPhotos();
  }

  Future<void> _loadPhotos() async {
    final String? photosJson = _prefs.getString('photos_$_userIdentifier'); 
    if (photosJson != null) {
      final List<dynamic> decodedList = jsonDecode(photosJson);
      setState(() {
        _photos = decodedList.map((path) => File(path)).toList();
      });
    }
  }

  Future<void> _savePhotos() async {
    final List<String> paths = _photos.map((file) => file.path).toList();
    final String encodedList = jsonEncode(paths);
    await _prefs.setString('photos_$_userIdentifier', encodedList); 
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

  void _deletePhoto(int index) {
    setState(() {
      _photos.removeAt(index);
    });
    _savePhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Vault'),
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
