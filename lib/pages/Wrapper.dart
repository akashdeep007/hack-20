import 'package:flutter/material.dart';
import 'package:the_robin_app/pages/LandingPage.dart';
import 'package:the_robin_app/widgets/authForm.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthForm(
      signup: true,
    );
//  return LandingPage();
  }
}
