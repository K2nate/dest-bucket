import 'package:dest_bucket/pages/signup_form.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('SignUp form'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SignUpForm(),
        ),
      ),
    );
  }
}
