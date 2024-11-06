import 'package:flutter/material.dart';
import 'package:skywalker/misc/journey.dart';
import 'package:skywalker/misc/values.dart';
import 'package:skywalker/widgets/cards/content_card.dart';
import 'package:skywalker/widgets/other/dots_with_dotted_line.dart';

class JourneyCard extends StatelessWidget {
  final bool hasCompleted;
  final bool isLast;
  final Journey journey;
  const JourneyCard(
      {super.key,
      required this.journey,
      this.hasCompleted = false,
      this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return ContentCard(
      height: 150,
      child: Padding(
        padding: comfortableCardInset,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DotsWithDottedLine(
              lineLength: 45,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    journey.from.location,
                    style: heading(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${journey.from.time.hour}:${journey.from.time.minute.toString().padLeft(2, "0")}",
                    style: subheading(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Expanded(child: nothing),
                  Text(
                    journey.to.location,
                    style: heading(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${journey.to.time.hour}:${journey.to.time.minute.toString().padLeft(2, "0")}",
                    style: subheading(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                journey.code.isNotEmpty
                    ? OutlinedButton.icon(
                        icon: Icon(journey.transport.icon()),
                        label: Text(journey.code),
                        onPressed: () {},
                      )
                    : Icon(journey.transport.icon()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
