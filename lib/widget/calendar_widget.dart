import 'package:flutter/material.dart';


import 'package:table_calendar/table_calendar.dart';
import 'package:tika/Utils/appconfig.dart';
class CalendarWidget extends StatefulWidget {
  final eventModel;

  const CalendarWidget({Key key, this.eventModel}) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {

  CalendarController _controller;
  @override
  void initState() {
    // TODO: implement initState
    _controller = CalendarController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TableCalendar(
            initialCalendarFormat: CalendarFormat.month,
            calendarStyle: CalendarStyle(
              todayColor: Colors.blue,
              selectedColor: AppColor.colorGreen,
              todayStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  color: Colors.white
              ),

            ),
            headerStyle:  HeaderStyle(
                centerHeaderTitle: true,
                formatButtonVisible: false,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(22.0),
                ), formatButtonTextStyle: TextStyle(color: Colors.white) ,formatButtonShowsNext: false ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (date, e, _){
              widget.eventModel.date = date.toUtc();
              // print(date.toUtc());
            },
            builders: CalendarBuilders(
              selectedDayBuilder: (context, date, events)=> Container(
                margin: const EdgeInsets.all(5.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(0.0)),
                child: Text(
                  date.day.toString(),
                  style: TextStyle(color: Colors.white),
                ),



              ),
              todayDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(0.0)),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
            ),

            calendarController: _controller)
      ],
    );
  }
}
