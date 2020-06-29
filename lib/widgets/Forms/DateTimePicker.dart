import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  final Function inputHandler;
  final bool error;
  DateTimePicker({this.inputHandler, this.error});
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  String _date;
  String formatDate(String text) => text.length == 1 ? '0$text': text;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(5),
      height: 50,
      child: Material(
        borderRadius: BorderRadius.circular(29),
        elevation: 6,
        color: widget.error ? Colors.red[100] : Colors.white,
        child: Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                  left: 15,
                  top: height/40,
                  child: Icon(Icons.calendar_today, color: widget.error ? Colors.red : Colors.green, size: 20,)
              ),
              InkWell(
                onTap: () async {
                  print("Tapped");
                  final date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2100));
                  final time = await showTimePicker(context: context, initialTime: TimeOfDay.now(), );
                  final dateTimeString = '${date.year}-${formatDate(date.month.toString())}-${formatDate(date.day.toString())} ${formatDate(time.hour.toString())}:${formatDate(time.minute.toString())}:00';
                  print(dateTimeString);
                  widget.inputHandler('Date', DateTime.parse(dateTimeString));
                    setState(() {
                      _date = dateTimeString;
                    });
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 50),
                  width: width,
                  child: Text(_date == null || _date == '' ? "Date" : _date, style: TextStyle(color: Colors.black54, fontSize: 16), ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
