import 'dart:math';

import 'package:flutter/material.dart';
import 'package:skywalker/backend/account.dart';
import 'package:skywalker/misc/trip_library.dart';
import 'package:skywalker/misc/values.dart';
import 'package:skywalker/pages/page_content.dart';
import 'package:skywalker/widgets/cards/journey_card.dart';
import 'package:skywalker/widgets/cards/trip_summary_card.dart';
import 'package:skywalker/widgets/other/hero_banner.dart';

class TripPage extends StatefulWidget {
  const TripPage({super.key});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  int currentJourney = 0;

  @override
  Widget build(BuildContext context) {
    final account = Account.of(context);
    final trip = account.trip;
    return PageContent.withTitleWidget(
      safeAreaTop: false,
      titlePadding: zero,
      titleWidget: SizedBox(
        height: 200,
        child: HeroBanner(
          image: trip.image,
          title: "Next trip: ${trip.destination}",
          titleStyle: pageTitle(context),
        ),
      ),
      children: [
        const SizedBox(),
        for (final (index, journey) in trip.journeys.indexed)
          JourneyCard(
            isCurrent: index == currentJourney,
            isLast: index == trip.journeys.length - 1,
            journey: journey,
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: comfortable,
              child: IconButton.filledTonal(
                  onPressed: () {
                    setState(() {
                      currentJourney = max(0, currentJourney - 1);
                    });
                  },
                  icon: const Icon(Icons.arrow_left)),
            ),
            Padding(
              padding: comfortable,
              child: IconButton.filledTonal(
                  onPressed: () {
                    setState(() {
                      currentJourney =
                          min(trip.journeys.length - 1, currentJourney + 1);
                    });
                  },
                  icon: const Icon(Icons.arrow_right)),
            )
          ],
        )
      ],
    );
  }
}
