import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_queen/models/UserModel.dart';
import 'package:safe_queen/screens/authentication/authenticate.dart';
import 'package:safe_queen/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //the user data that the provider proides this can be a user data or can be null.
    final user = Provider.of<UserModel?>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
    