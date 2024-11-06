class Checkpoint {
  final DateTime time;
  final String shortform;
  final String location;
  final int locationId;
  const Checkpoint(
      {required this.time, this.shortform = "", required this.location, this.locationId=1});

  Checkpoint.fromMap(Map<String, dynamic> json)
      : time = DateTime.parse(json["time"] ?? "2024-11-07 00:00"),
        shortform = json["shortform"] ?? "",
        location = json["location"] ?? "",
        locationId = int.parse(json["locationId"] ?? "1");

  static Map<String, dynamic> toMap(Checkpoint value) => {
        "time": value.time.toString(),
        "shortform": value.shortform,
        "location": value.location,
        "locationId": value.locationId.toString(),
      };
}
