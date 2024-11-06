import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class DotsWithDottedLine extends StatelessWidget {
  const DotsWithDottedLine({
    super.key,
    this.lineLength = double.infinity
  });

  final double lineLength;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(Icons.adjust),
        DottedLine(
          direction: Axis.vertical,
          dashColor: theme.colorScheme.onSurface,
          dashLength: 5,
          lineThickness: 3,
          lineLength: lineLength,
        ),
        const Icon(Icons.adjust),
      ],
    );
  }
}
