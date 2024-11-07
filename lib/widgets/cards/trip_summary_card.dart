import 'package:flutter/material.dart';
import 'package:skywalker/misc/show_popup.dart';
import 'package:skywalker/misc/trip.dart';
import 'package:skywalker/misc/values.dart';
import 'package:skywalker/pages/trip_breakdown_page.dart';
import 'package:skywalker/widgets/cards/content_card.dart';
import 'package:skywalker/widgets/other/rounded_rectangle.dart';

class TripSummaryCard extends StatelessWidget {
  final int number;
  final Trip trip;
  final bool showDetailsButton;
  const TripSummaryCard(
      {super.key, this.trip = const Trip(), this.showDetailsButton = false, this.number=1});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ContentCard(
      width: double.infinity,
      padding: comfortableCardInset,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Circle(color: theme.colorScheme.primary, child: Text(number.toString(), style: subheading(context).copyWith(color: theme.colorScheme.onPrimary),),),
          Text(
            "${trip.journeys.map((journey) => journey.from.location).reduce((journey1, journey2) => "$journey1→$journey2")}→${trip.destination}",
            style: heading(context),
          ),
          Row(
            children: [
              for (final transport in trip.transports)
                Padding(padding: tight, child: Icon(transport.icon()),)
            ],
          ),
          Padding(padding: comfortable, child: Text("${(trip.time.inMinutes/60).floor()} hours ${trip.time.inMinutes % 60} minutes"),),
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
                  onPressed: showNewPage(context, TripBreakdownPage(tripNo: number, trip: trip,)),
                  label: const Text("Details"),
                  icon: const Icon(Icons.arrow_forward_ios),
              )
            ],
          )
        ],
      ),
    );
  }
}

class Circle extends StatelessWidget {
  const Circle({
    super.key,
    this.color,
    this.child,
  });

  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: child,
      ),
    );
  }
}
