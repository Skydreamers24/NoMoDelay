import 'package:flutter/material.dart';
import 'package:skywalker/backend/account.dart';
import 'package:skywalker/backend/database.dart';
import 'package:skywalker/misc/checkpoint.dart';
import 'package:skywalker/misc/journey.dart';
import 'package:skywalker/misc/transport.dart';
import 'package:skywalker/misc/trip.dart';
import 'package:skywalker/misc/values.dart';
import 'package:skywalker/pages/page_content.dart';
import 'package:skywalker/widgets/cards/journey_card.dart';
import 'package:skywalker/widgets/cards/trip_summary_card.dart';
import 'package:skywalker/widgets/other/hero_banner.dart';

class TripPage extends StatelessWidget {
  const TripPage({super.key});

  @override
  Widget build(BuildContext context) {
    final account = Account.of(context);
    final trip = account.trip;
    return PageContent.withTitleWidget(
      titlePadding: zero,
      titleWidget: SizedBox(
        height: 200,
        child: HeroBanner(
          image: trip.image,
          title: "Trip",
          subtitle: "Next trip: ${trip.destination}",
          child: IconButton.filled(
              onPressed: () {
                toDatabaseSync(account.copyWith(
                    trip: Trip(
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
                    ])));
              },
              icon: const Icon(Icons.add)),
        ),
      ),
      children: [
        SizedBox(),
        TripSummaryCard(
          trip: trip,
        ),
        for (final journey in trip.journeys)
          JourneyCard(
            journey: journey,
          )
      ],
    );
  }
}
