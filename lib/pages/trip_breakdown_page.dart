import 'package:flutter/material.dart';
import 'package:skywalker/backend/account.dart';
import 'package:skywalker/backend/database.dart';
import 'package:skywalker/misc/transport.dart';
import 'package:skywalker/misc/trip.dart';
import 'package:skywalker/misc/values.dart';
import 'package:skywalker/pages/page_content.dart';
import 'package:skywalker/widgets/cards/content_card.dart';
import 'package:skywalker/widgets/cards/trip_summary_card.dart';

class TripBreakdownPage extends StatelessWidget {
  final int tripNo;
  final Trip trip;
  const TripBreakdownPage(
      {super.key, required this.trip, required this.tripNo});

  @override
  Widget build(BuildContext context) {
    final account = Account.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("Trip Option $tripNo"),
        actions: [
          Padding(
            padding: comfortable,
            child: TextButton(
                onPressed: () {
                  toDatabaseSync(account.copyWith(trip: trip));
                  Navigator.pop(context);
                },
                child: Text("Confirm")),
          )
        ],
      ),
      body: PageContent(
        children: [
          for (final (index, journey) in trip.journeys.indexed)
            () {
              switch (journey.transport) {
                case Transport.flight:
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Circle(
                            color: theme.colorScheme.primary,
                            child: Text(
                              (index + 1).toString(),
                              style: subheading(context)
                                  .copyWith(color: theme.colorScheme.onPrimary),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${journey.transport.toString()} from ${journey.from.location} to ${journey.to.location}",
                                style: heading(context),
                              ),
                              journey.code.isNotEmpty
                                  ? Text(
                                      journey.code,
                                      style: subheading(context),
                                    )
                                  : nothing,
                              Text(
                                "${journey.from.time.day}/${journey.from.time.month} ${journey.from.time.hour.toString().padLeft(2, "0")}:${journey.from.time.minute.toString().padLeft(2, "0")}—${journey.to.time.day}/${journey.to.time.month} ${journey.to.time.hour.toString().padLeft(2, "0")}:${journey.to.time.minute.toString().padLeft(2, "0")}",
                                style: subheading(context),
                              ),
                            ],
                          ))
                        ],
                      ),
                      const SizedBox(height: 8,),
                      const FlightRemindersCard(),
                    ],
                  );
                default:
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Circle(
                            color: theme.colorScheme.primary,
                            child: Text(
                              (index + 1).toString(),
                              style: subheading(context)
                                  .copyWith(color: theme.colorScheme.onPrimary),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${journey.transport.toString()} from ${journey.from.location} to ${journey.to.location}",
                                style: heading(context),
                              ),
                              journey.code.isNotEmpty
                                  ? Text(
                                      journey.code,
                                      style: subheading(context),
                                    )
                                  : nothing,
                              Text(
                                "${journey.from.time.day}/${journey.from.time.month} ${journey.from.time.hour.toString().padLeft(2, "0")}:${journey.from.time.minute.toString().padLeft(2, "0")}—${journey.to.time.day}/${journey.to.time.month} ${journey.to.time.hour.toString().padLeft(2, "0")}:${journey.to.time.minute.toString().padLeft(2, "0")}",
                                style: subheading(context),
                              ),
                            ],
                          ))
                        ],
                      ),
                    ],
                  );
              }
            }()
        ],
      ),
    );
  }
}

class FlightRemindersCard extends StatefulWidget {
  const FlightRemindersCard({
    super.key,
  });

  @override
  State<FlightRemindersCard> createState() => _FlightRemindersCardState();
}

class _FlightRemindersCardState extends State<FlightRemindersCard> {
  bool visa = false;
  bool planeTicket = false;
  bool hotel = false;

  @override
  Widget build(BuildContext context) {
    return ContentCard(
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      padding: zero,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          ListTile(
            title: Text("Visa"),
            trailing: FilledButton.icon(
                icon: visa ? Icon(Icons.check) : null,
                onPressed: visa
                    ? null
                    : () {
                        setState(() {
                          visa = true;
                        });
                      },
                label: Text("Apply")),
          ),
          ListTile(
            title: Text("Plane ticket"),
            trailing: FilledButton.icon(
                icon: planeTicket ? Icon(Icons.check) : null,
                onPressed: planeTicket
                    ? null
                    : () {
                        setState(() {
                          planeTicket = true;
                        });
                      },
                label: Text("Book")),
          ),
          ListTile(
            title: Text("Hotel"),
            trailing: FilledButton.icon(
                icon: hotel ? Icon(Icons.check) : null,
                onPressed: hotel
                    ? null
                    : () {
                        setState(() {
                          hotel = true;
                        });
                      },
                label: Text("Book")),
          )
        ],
      ),
    );
  }
}
