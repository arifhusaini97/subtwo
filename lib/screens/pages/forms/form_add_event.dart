import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtwo/models/event_model.dart';
import 'package:subtwo/models/user_model.dart';
import 'package:subtwo/res/event_firestore_service.dart';
import 'package:subtwo/screens/shared/constants.dart';

class FormAddEvent extends StatefulWidget {
  final EventModel note;
  final DateTime eventDate;

  const FormAddEvent({Key key, this.note, this.eventDate}) : super(key: key);

  @override
  _FormAddEventState createState() => _FormAddEventState(eventDate);
}

class _FormAddEventState extends State<FormAddEvent> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _title;
  TextEditingController _description;
  TextEditingController _venue;
  TimeOfDay _timeStart = TimeOfDay.now();
  TimeOfDay _timeEnd = TimeOfDay.now();
  bool _repeatative = false;
  final List<String> _repeatBy = ['Daily', 'Weekly', 'Monthly'];
  String _currentRepeatBy;
  DateTime _eventDateStart;
  DateTime _eventDateEnd;
  DateTime _eventDate;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool processing;

  _FormAddEventState(this._eventDate);

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(
        text: widget.note != null ? widget.note.title : "");
    _description = TextEditingController(
        text: widget.note != null ? widget.note.description : "");
    _venue = TextEditingController(
        text: widget.note != null ? widget.note.description : "");
    _eventDateStart = _eventDate;
    _eventDateEnd = _eventDate;
    _eventDate = _eventDate;
    processing = false;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note != null ? "Edit Event" : "Create Event"),
      ),
      key: _key,
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _title,
                  validator: (value) =>
                      (value.isEmpty) ? "Please Enter title" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Title",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _description,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) =>
                      (value.isEmpty) ? "Please Enter description" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _venue,
                  validator: (value) => (value.isEmpty)
                      ? "Please state the venue/platform"
                      : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Venue/Platform",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(height: 10.0),
              ListTile(
                title: Text("Time Start (hh:mm)"),
                subtitle: Text(
                    "${_timeStart.hour.toString().padLeft(2, '0')} : ${_timeStart.minute.toString().padLeft(2, '0')}"),
                onTap: () async {
                  TimeOfDay picked = await showTimePicker(
                    context: context,
                    initialTime: _timeStart,
                  );
                  if (picked != null) {
                    setState(() {
                      _timeStart = picked;
                    });
                  }
                },
              ),
              ListTile(
                title: Text("Time End (hh:mm)"),
                subtitle: Text(
                    "${_timeEnd.hour.toString().padLeft(2, '0')} : ${_timeEnd.minute.toString().padLeft(2, '0')}"),
                onTap: () async {
                  TimeOfDay picked = await showTimePicker(
                    context: context,
                    initialTime: _timeEnd,
                  );
                  if (picked != null) {
                    setState(() {
                      _timeEnd = picked;
                    });
                  }
                },
              ),
              ListTile(
                title: Text('Repeatative Event'),
                subtitle: Row(
                  children: [
                    Text('No'),
                    Switch(
                        value: _repeatative,
                        onChanged: (value) {
                          setState(() {
                            _repeatative = !_repeatative;
                          });
                        }),
                    Text('Yes'),
                  ],
                ),
              ),
              _repeatative == true
                  ?
                  //dropdown
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: DropdownButtonFormField(
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Repeat By',
                        ),
                        value: _currentRepeatBy,
                        items: _repeatBy.map((_repeatBy) {
                          return DropdownMenuItem(
                              value: _repeatBy, child: Text(_repeatBy));
                        }).toList(),
                        onChanged: (val) =>
                            setState(() => _currentRepeatBy = val),
                      ),
                    )
                  : SizedBox(),
              ListTile(
                title: _repeatative == false
                    ? Text("Date (YYYY-MM-DD)")
                    : Text("Date Start (YYYY-MM-DD)"),
                subtitle: Text(
                    "${_eventDateStart.year.toString().padLeft(4, '0')} - ${_eventDateStart.month.toString().padLeft(2, '0')} - ${_eventDateStart.day.toString().padLeft(2, '0')}"),
                onTap: () async {
                  DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: _eventDateStart,
                      firstDate: DateTime(_eventDateStart.year - 5),
                      lastDate: DateTime(_eventDateStart.year + 5));
                  if (picked != null) {
                    setState(() {
                      _eventDateStart = picked;
                    });
                  }
                },
              ),
              _repeatative == true
                  ? ListTile(
                      title: Text("Date End (YYYY-MM-DD)"),
                      subtitle: Text(
                          "${_eventDateEnd.year.toString().padLeft(4, '0')} - ${_eventDateEnd.month.toString().padLeft(2, '0')} - ${_eventDateEnd.day.toString().padLeft(2, '0')}"),
                      onTap: () async {
                        DateTime picked = await showDatePicker(
                            context: context,
                            initialDate: _eventDateEnd,
                            firstDate: DateTime(_eventDateEnd.year - 5),
                            lastDate: DateTime(_eventDateEnd.year + 5));
                        if (picked != null) {
                          setState(() {
                            _eventDateEnd = picked;
                          });
                        }
                      },
                    )
                  : SizedBox(),
              SizedBox(height: 10.0),
              processing
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      //child: SizedBox(height: 0.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Theme.of(context).primaryColor,
                        child: MaterialButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                processing = true;
                              });
                              if (widget.note != null) {
                                await eventDBS.updateData(widget.note.id, {
                                  "title": _title.text,
                                  "description": _description.text,
                                  "event_date": widget.note.eventDate
                                });
                              } else {
                                await eventDBS.createItem(
                                  EventModel(
                                    id: user.uid,
                                    title: _title.text,
                                    description: _description.text,
                                    venue: _venue.text,
                                    repeatative: _repeatative,
                                    repeatBy: _currentRepeatBy,
                                    eventDate: _eventDate,
                                    eventDateStart: _eventDateStart,
                                    eventDateEnd: _eventDateEnd,
                                    createdBy: user.uid,
                                  ),
                                );
                              }
                              Navigator.pop(context);
                              setState(() {
                                processing = false;
                              });
                            }
                          },
                          child: Text(
                            "Save",
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }
}
