import 'package:flutter/material.dart';

// One entry in the multilevel list displayed by this app.
class EntryModel {
  EntryModel(this.icon, this.title, this.subtitle,
      [this.children = const <EntryModel>[]]);
  final IconData icon;
  final String title;
  final String subtitle;
  final List<EntryModel> children;
}

final List<EntryModel> dummyDataActivity = <EntryModel>[
  EntryModel(
    null,
    'Parallel Processing Class 1',
    'CSC580/M20/CS2476B/CS2476C',
    <EntryModel>[
      EntryModel(
        null,
        'Day: Wednesday (Every Week) \nDate: 01/07/2020 - 15/07/2020 \nTime: 08:00a.m - 10:00a.m \nPlatform/Place: Google Meet \nCreated by @arifhusaini97',
        null,
      ),
    ],
  ),
  EntryModel(
    null,
    'Parallel Processing Class 2',
    'CSC580/M20/CS2476B/CS2476C',
    <EntryModel>[
      EntryModel(
        null,
        'Day: Thursday (Every Week) \nDate: 02/07/2020 - 16/07/2020 \nTime: 02:00p.m - 04:00p.m \nPlatform/Place: Google Meet \nCreated by @arifhusaini97',
        null,
      ),
    ],
  ),
  EntryModel(
    null,
    'Coding and Cryptography Class 1',
    'CSC525/M20/CS2476B/CS2476B1/CS2476C',
    <EntryModel>[
      EntryModel(
        null,
        'Day: Friday (Every Week) \nDate: 03/07/2020 - 17/07/2020 \nTime: 08:00a.m - 10:00a.m \nPlatform/Place: Microsoft Team \nCreated by @arifhusaini97',
        null,
      ),
    ],
  ),
  EntryModel(
    null,
    'Coding and Cryptography Final Exam',
    'CSC525/M20/CS2476B/CS2476B1/CS2476C',
    <EntryModel>[
      EntryModel(
        null,
        'Day: Monday - Tuesday (Continuously) \nFrom: 13/07/2020 (02:00p.m) \nUntil: 14/07/2020 (10:00a.m) \nPlatform/Place: Google Meet \nCreated by @arifhusaini97',
        null,
      ),
    ],
  ),
];
