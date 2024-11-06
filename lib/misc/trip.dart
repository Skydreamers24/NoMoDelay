import 'package:skywalker/misc/journey.dart';
import 'package:skywalker/misc/transport.dart';

class Trip {
  final String image;
  final List<Journey> journeys;
  const Trip({this.journeys = const [], this.image = ""});

  Journey get first => journeys[0];
  Journey get last => journeys[journeys.length-1];
  String get origin => journeys.isNotEmpty ? journeys[0].from.location : "";
  String get destination =>
      journeys.isNotEmpty ? journeys[journeys.length - 1].to.location : "";
  double get price => journeys
      .map((journey) => journey.price)
      .reduce((journey1Price, journey2Price) => journey1Price + journey2Price);
  List<Transport> get transports =>
      journeys.map((journey) => journey.transport).toList();
  Duration get time => last.to.time.difference(first.from.time);

  Trip.fromMap(Map<String, dynamic> map)
      : image = map["image"],
        journeys = [
          for (Map<String, dynamic> object in map["journeys"])
            Journey.fromMap(object)
        ];

  Map<String, dynamic> toMap() => {
        "image": image,
        "journeys": [for (final journey in journeys) Journey.toMap(journey)]
      };
}
