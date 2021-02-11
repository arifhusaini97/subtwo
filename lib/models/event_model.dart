import 'package:firebase_helpers/firebase_helpers.dart';

class EventModel extends DatabaseItem {
  final String id;
  final String title;
  final String description;
  final String venue;
  final bool repeatative;
  final String repeatBy;
  final DateTime eventDate;
  final DateTime eventDateStart;
  final DateTime eventDateEnd;
  final String createdBy;

  EventModel(
      {this.id,
      this.title,
      this.description,
      this.venue,
      this.repeatative,
      this.repeatBy,
      this.eventDate,
      this.eventDateStart,
      this.eventDateEnd,
      this.createdBy})
      : super(id);

  factory EventModel.fromMap(Map data) {
    return EventModel(
      title: data['title'],
      description: data['description'],
      eventDate: data['event_date'],
    );
  }

  factory EventModel.fromDS(String id, Map<String, dynamic> data) {
    return EventModel(
      id: id,
      title: data['title'],
      description: data['description'],
      eventDate: data['event_date'].toDate(),
      createdBy: data['created_by'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "event_date": eventDate,
      "venue": venue,
      "repeatative": repeatative,
      "repeatBy": repeatBy,
      "eventDate": eventDate,
      "eventDateStart": eventDateStart,
      "eventDateEnd": eventDateEnd,
      "id": id,
      "created_by": createdBy,
    };
  }
}
