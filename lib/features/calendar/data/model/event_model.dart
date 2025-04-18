class EventModel {
  String? eventName;
  String? description;
  String? date;

  EventModel({this.eventName, this.description, this.date});

  EventModel.fromJson(Map<String, dynamic> json) {
    eventName = json['event_name'];
    description = json['description'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event_name'] = eventName;
    data['description'] = description;
    data['date'] = date;
    return data;
  }
}