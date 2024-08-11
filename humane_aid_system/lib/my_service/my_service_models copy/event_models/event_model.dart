class EventModel {
   String? id;
  final String? eventTime;
   String? title;
   String? description;
   String? roomName;
   int? level;
   double? myLatitude;
   double? myLongitude;
   String? userId;

   EventModel({
    this.id = "",
    this.eventTime = "",
    this.title = "",
    this.description = "",
    this.roomName = "",
    this.level = 0,
    this.myLatitude =  0,
    this.myLongitude =  0,
    this.userId = "",
  });

  DateTime get eventDateTime =>
      DateTime.tryParse(eventTime.toString()) ?? DateTime.now();

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["id"] ?? "",
        eventTime: json["eventTime"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        roomName: json["roomName"] ?? "",
        level: json["level"] ?? 0,
        myLatitude: json["myLatitude"]?.toDouble() ?? 0,
        myLongitude: json["myLongitude"]?.toDouble() ?? 0,
        userId: json["userId"] ?? "",
      );
}
