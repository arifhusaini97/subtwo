import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtwo/models/user_model.dart';
import 'package:subtwo/screens/pages/forms/form_add_event.dart';
import 'package:subtwo/screens/pages/forms/form_profile.dart';
import 'package:subtwo/services/auth.dart';
import 'package:subtwo/widgets/wrapper.dart';

// const EventsRoute='/';
// const EventDetailsRoute='/profile/event';
// const PersonDetailsRoute='/profile/person';
// const OrganizationDetailsRoute='/profile/organization';

class MyApp extends StatelessWidget {
  RouteFactory _routes() {
    return (settings) {
      final Map<String, dynamic> arguments = settings.arguments;
      Widget screen;
      switch (settings.name) {
        case "add_event":
          screen = FormAddEvent(eventDate: arguments['eventDate']);
          break;
        case "form_profile":
          screen = FormProfile(
            title: 'Edit Profile',
          );
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Subtwo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: Wrapper(),
        onGenerateRoute: _routes(),
      ),
    );
  }
}
