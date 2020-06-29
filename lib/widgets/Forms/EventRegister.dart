import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_robin_app/blocs/EventService.dart';
import 'package:the_robin_app/models/User.dart';
import 'package:the_robin_app/widgets/Forms/DateTimePicker.dart';
import 'package:the_robin_app/widgets/Forms/InputField.dart';
import 'package:validators/validators.dart' as validators;

class EventRegister extends StatefulWidget {
  @override
  _EventRegisterState createState() => _EventRegisterState();
}

class _EventRegisterState extends State<EventRegister> {
  DateTime _date;
  String _name = "", _phone = "", _location = "", _title = "", _description = "";
  bool _nameError = false, _titleError = false, _locationError = false, _phoneError = false, _descriptionError = false, _dateError = false;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final EventService _eventService = EventService();

  void inputHandler(String inputField, value) {
    switch (inputField) {
      case "Title":
        setState(() {
          _title = value;
          _titleError = false;
        });
        break;
      case "Description":
        setState(() {
          _description = value;
          _descriptionError = false;
        });
        break;
      case "Location":
        setState(() {
          _location = value;
          _locationError = false;
        });
        break;
      case "Donor Name":
        setState(() {
          _name = value;
          _nameError = false;
        });
        break;
      case 'Date':
        setState(() {
          _date = value;
          _dateError = false;
        });
        break;
      case "Phone":
        setState(() {
          _phone = value;
          _phoneError = false;
        });
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: constraints.maxHeight
              ),
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Event",
                               textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                  Column(
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[

                            CustomInputField(icon: Icons.title, inputHandler: inputHandler, error: _titleError, title: "Title"),
                            CustomInputField(icon: Icons.description, inputHandler: inputHandler, error: _descriptionError, title: "Description"),
                            CustomInputField(icon: Icons.person, inputHandler: inputHandler, error: _nameError, title: "Donor Name"),
                            CustomInputField(icon: Icons.phone, inputHandler: inputHandler, error: _phoneError, title: "Phone"),
                            CustomInputField(icon: Icons.lock, inputHandler: inputHandler, error: _locationError, title: "Location"),
                            DateTimePicker(inputHandler: inputHandler, error: _dateError,),
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      RaisedButton(
                        elevation: 6,
                        child: Text("Register"),
                        onPressed: () async {
                          print(_date);
                          if(_name.isEmpty) setState(() => _nameError = true);
                          if(_date == null) setState(() => _dateError = true);
                          if(_title.length <= 0) setState(() => _titleError = true);
                          if(!validators.isNumeric(_phone.trim()) || _phone.trim().length != 10) setState(() => _phoneError = true);
                          if(_description.length <= 0) setState(() => _descriptionError = true);
                          if(_location.length <= 0) setState(() => _locationError = true);
                          if(!_nameError && !_titleError && !_phoneError && !_descriptionError && !_dateError){
                            print('Uploading');
                            setState(() => isLoading = true);
                            await _eventService.updateEvent(_name, _title, 'food', _description, _location, _date , _phone, user.name);
                            setState(() => isLoading = false);

                          }
                        },
                      ),
                    ],
                  ),
                  ],
                ),
              ),
            ),
          ),
        ),
        isLoading ? Center(child: CircularProgressIndicator(),) : Container()
      ],
    );
  }
}
