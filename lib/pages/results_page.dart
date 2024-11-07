import 'package:flutter/material.dart';
import 'package:skywalker/misc/journey.dart';
import 'package:skywalker/misc/sort_option.dart';
import 'package:skywalker/misc/transport.dart';
import 'package:skywalker/misc/trip.dart';
import 'package:skywalker/misc/trip_library.dart';
import 'package:skywalker/misc/values.dart';
import 'package:skywalker/widgets/cards/trip_summary_card.dart';
import 'package:skywalker/widgets/other/filtered_list_view.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Your options"),
      ),
      body: SizedBox.expand(
        child: FilteredListView<Trip>(
          data: trips,
          filters: [
            ListFilter(name: "All", test: (trip) => true),
            for (final transport in Transport.values)
              ListFilter(
                  name: transport.toString(),
                  test: (trip) => trip.journeys
                      .any((journey) => journey.transport == transport))
          ],
          sortOptions: [
            SortOption(name: "Sort by price", sortFunction: (trip1, trip2) => trip1.price.compareTo(trip2.price)),
            SortOption(name: "Sort by time", sortFunction: (trip1, trip2) => trip1.time.compareTo(trip2.time)),
          ],
          builder: (index, trip) => Padding(
            padding: comfortable,
            child: TripSummaryCard(
              number: index + 1,
              trip: trip,
              showDetailsButton: true,
            ),
          ),
        ),
      ),
    );
  }
}
