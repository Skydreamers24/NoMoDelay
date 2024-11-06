import 'package:flutter/material.dart';

enum Transport {
  flight,
  taxi,
  metro,
  train;

  @override
  String toString() {
    return const {
      Transport.flight: "Flight",
      Transport.taxi: "Taxi",
      Transport.train: "Train",
      Transport.metro: "Metro",
    } [this] ?? "Flight";
  }

  static Transport fromString(String s) {
    return const {
      "Flight": Transport.flight,
      "Taxi": Transport.taxi,
      "Train": Transport.train,
      "Metro": Transport.metro,
    } [s] ?? Transport.flight;
  }

  IconData icon() {
    return const {
      Transport.flight: Icons.flight,
      Transport.taxi: Icons.local_taxi,
      Transport.train: Icons.train,
      Transport.metro: Icons.directions_transit
    } [this] ?? Icons.flight;
  }
}
