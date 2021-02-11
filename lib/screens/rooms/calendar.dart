import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subtwo/models/event_model.dart';
import 'package:subtwo/res/event_firestore_service.dart';
import 'package:subtwo/screens/pages/view_event.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;
  DateTime eventDate;
  // bool _onDaySelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final _selectedDay = DateTime.now();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = _events[_selectedDay] ?? [];
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
        decodeMap(
          json.decode(
            prefs.getString(
                  "events",
                ) ??
                "{}",
          ),
        ),
      );
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  Map<DateTime, List<dynamic>> _groupEvents(List<EventModel> events) {
    Map<DateTime, List<dynamic>> data = {};
    events.forEach((event) {
      DateTime date = DateTime(
          event.eventDate.year, event.eventDate.month, event.eventDate.day, 12);
      if (data[date] == null) data[date] = [];
      data[date].add(event);
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Calendar'),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<List<EventModel>>(
          stream: eventDBS.streamList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<EventModel> allEvents = snapshot.data;
              if (allEvents.isNotEmpty) {
                _events = _groupEvents(allEvents);
              }
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TableCalendar(
                    events: _events,
                    initialCalendarFormat: CalendarFormat.month,
                    initialSelectedDay: DateTime.now(),
                    headerStyle: HeaderStyle(
                      centerHeaderTitle: true,
                      formatButtonShowsNext: false,
                    ),
                    onDaySelected: (date, events) {
                      setState(() {
                        _selectedEvents = events;
                        eventDate = date;
                        // _onDaySelected = true;
                      });
                    },
                    builders: CalendarBuilders(
                      selectedDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      todayDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.purpleAccent[100],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    calendarController: _controller,
                  ),
                  ..._selectedEvents.map(
                    (event) => Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.8),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: InkWell(
                        child: ListTile(
                          title: Text(event.title),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EventDetails(
                                  event: event,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(
          context,
          'add_event',
          arguments: {
            "eventDate": eventDate != null ? eventDate : DateTime.now()
          },
        ),
      ),
    );
  }

  // _showAddDialog() {
  //   showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             content: TextField(
  //               controller: _eventController,
  //             ),
  //             actions: <Widget>[
  //               FlatButton(
  //                 child: Text("Save"),
  //                 onPressed: () {
  //                   if (_eventController.text.isEmpty) return;
  //                   setState(() {
  //                     if (_events[_controller.selectedDay] != null) {
  //                       _events[_controller.selectedDay]
  //                           .add(_eventController.text);
  //                     } else {
  //                       _events[_controller.selectedDay] = [
  //                         _eventController.text
  //                       ];
  //                     }
  //                     prefs.setString(
  //                         "events", json.encode(encodeMap(_events)));
  //                     _eventController.clear();
  //                     Navigator.pop(context);
  //                   });
  //                 },
  //               )
  //             ],
  //           ));
  // }
}
