import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_robin_app/blocs/AuthService.dart';
import 'package:the_robin_app/models/User.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  PickedFile _imageFile;
  dynamic _pickImageError;

  final ImagePicker _picker = ImagePicker();


  @override
  Widget build(BuildContext context) {

    final AuthService _auth = AuthService();
    final user = Provider.of<User>(context);
    final height = MediaQuery.of(context).size.height;

    Widget _buildInfoTile(String title, double width){
      return Container(
        width: width,
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(29),
            shadowColor: Colors.grey,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(title, textAlign: TextAlign.center,),
        )),
      );
    }
    double maxContWidth = 0;
    if(user != null) maxContWidth = ((user.email.length+5) * 10).toDouble();
    return user != null ? SizedBox.expand(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          CustomPaint(painter: BackDropPaint(),child: Container(height: height / 2.5 ,alignment: Alignment.bottomCenter,child: Material(borderRadius: BorderRadius.circular(60), shadowColor: Colors.grey,elevation: 6,child: ClipOval(child : Container(height: 120, width: 120,color: Colors.green,child: Placeholder()))),),),
          Positioned(
            top: height / 2.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 10,),
                Column(
                  children: <Widget>[
                    Text(user.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    _buildInfoTile('Email : ${user.email}', maxContWidth),
                    _buildInfoTile('Contact : ${user.phone}', maxContWidth),
                  ],
                ),
                SizedBox(height: 50,),
                RaisedButton(onPressed: _auth.signOut, child: Text("Log Out"), elevation: 6,)
              ],
            ),
          ),

        ],
      ),
    ) : Center(child: CircularProgressIndicator(),);
  }
}


class BackDropPaint extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width/2, -120);
    canvas.drawCircle(center, 300, Paint()..color = Colors.greenAccent);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}