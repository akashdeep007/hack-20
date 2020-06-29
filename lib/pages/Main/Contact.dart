import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[500].withOpacity(.3),
      body: ContactUs(
        logo: AssetImage('assets/images/logo.jpg'),
        email: 'info@robinhoodarmy.com',
        companyName: 'Robin Hood Army',
        website: 'https://robinhoodarmy.com/',
        tagLine: 'Fight Against Hunger',
        twitterHandle: 'rha_india',
        instagram: 'rha_india',
      ),
    );
  }
}
