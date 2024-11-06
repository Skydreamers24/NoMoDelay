import 'package:flutter/material.dart';
import 'package:skywalker/misc/show_popup.dart';
import 'package:skywalker/misc/trip.dart';
import 'package:skywalker/misc/values.dart';
import 'package:skywalker/pages/trip_breakdown_page.dart';
import 'package:skywalker/widgets/cards/content_card.dart';
import 'package:skywalker/widgets/other/rounded_rectangle.dart';

class TripSummaryCard extends StatelessWidget {
  final Trip trip;
  final bool showSelectButton;
  const TripSummaryCard(
      {super.key, this.trip = const Trip(), this.showSelectButton = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ContentCard(
      width: double.infinity,
      padding: comfortableCardInset,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${trip.journeys.map((journey) => journey.from.location).reduce((journey1, journey2) => "$journey1→$journey2")}→${trip.destination}",
            style: heading(context),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              RoundedRectangle(
                color: theme.colorScheme.surfaceContainerHigh,
                padding: comfortable,
                child: Text(
                  "\$${trip.price}",
                  style: subheading(context),
                ),
              ),
              const Expanded(child: SizedBox()),
              FilledButton.icon(
                  onPressed: showNewPage(context, const TripBreakdownPage()),
                  label: const Text("Select"),
                  icon: const Icon(Icons.arrow_forward_ios),
              )
            ],
          )
        ],
      ),
    );
  }
}
