import 'package:skywalker/misc/checkpoint.dart';
import 'package:skywalker/misc/journey.dart';
import 'package:skywalker/misc/transport.dart';
import 'package:skywalker/misc/trip.dart';

final List<Trip> trips = [
  Trip(
      image:
          "https://a.cdn-hotels.com/gdcs/production85/d1715/475fcc95-21d7-44a7-9d42-4fd6219d9f55.jpg",
      journeys: [
        Journey(
            transport: Transport.train,
            price: 200,
            from: Checkpoint(
              time: DateTime.parse("2024-05-26 16:00"),
              location: "Guangzhou",
            ),
            to: Checkpoint(
              time: DateTime.parse("2024-05-26 17:15"),
              location: "Hong Kong",
            )),
        Journey(
            transport: Transport.metro,
            price: 105,
            from: Checkpoint(
                time: DateTime.parse("2024-05-26 17:45"),
                location: "Hong Kong West Kowloon"),
            to: Checkpoint(
                time: DateTime.parse("2024-05-26 18:30"),
                location: "Hong Kong International Airport")),
        Journey(
            transport: Transport.flight,
            price: 6500,
            code: "CX255",
            from: Checkpoint(
              time: DateTime.parse("2024-05-26 23:15"),
              location: "Hong Kong",
            ),
            to: Checkpoint(
              time: DateTime.parse("2024-05-27 12:10"),
              location: "London",
            ))
      ]),
  Trip(
      image:
          "https://d36tnp772eyphs.cloudfront.net/blogs/1/2019/08/Macau-city-skyline-at-night.jpg",
      journeys: [
        Journey(
            transport: Transport.flight,
            price: 9128,
            code: "CX260",
            from: Checkpoint(
              time: DateTime.parse("2024-11-07 11:40"),
              location: "Paris",
            ),
            to: Checkpoint(
              time: DateTime.parse("2024-11-08 06:55"),
              location: "Hong Kong",
            )),
        Journey(
            transport: Transport.airPlusSea,
            price: 400,
            from: Checkpoint(
                time: DateTime.parse("2024-11-08 08:00"),
                location: "Hong Kong"),
            to: Checkpoint(
                time: DateTime.parse("2024-11-08 09:30"),
                location: "Macao")),
        Journey(
            transport: Transport.taxi,
            price: 100,
            from: Checkpoint(
              time: DateTime.parse("2024-11-08 09:45"),
              location: "Macao Maritime Ferry Terminal",
            ),
            to: Checkpoint(
              time: DateTime.parse("2024-11-08 10:10"),
              location: "Grand Lisboa",
            ))
      ]),
  Trip(
      image:
          "https://a.cdn-hotels.com/gdcs/production85/d1715/475fcc95-21d7-44a7-9d42-4fd6219d9f55.jpg",
      journeys: [
        Journey(
            transport: Transport.coach,
            price: 65,
            from: Checkpoint(
              time: DateTime.parse("2024-05-26 16:00"),
              location: "Guangzhou",
            ),
            to: Checkpoint(
              time: DateTime.parse("2024-05-26 18:30"),
              location: "Hong Kong",
            )),
        Journey(
            transport: Transport.metro,
            price: 155,
            from: Checkpoint(
                time: DateTime.parse("2024-05-26 17:45"),
                location: "Hong Kong Lo Wu Port"),
            to: Checkpoint(
                time: DateTime.parse("2024-05-26 19:00"),
                location: "Hong Kong International Airport")),
        Journey(
            transport: Transport.flight,
            price: 6500,
            code: "CX255",
            from: Checkpoint(
              time: DateTime.parse("2024-05-26 23:15"),
              location: "Hong Kong",
            ),
            to: Checkpoint(
              time: DateTime.parse("2024-05-27 12:10"),
              location: "London",
            ))
      ]),
];