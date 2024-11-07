import 'package:flutter/material.dart';

enum Transport {
  flight,
  airPlusSea,
  taxi,
  metro,
  train,
  coach;

  @override
  String toString() {
    return const {
      Transport.flight: "Flight",
      Transport.airPlusSea: "Cathay Air+Sea Service",
      Transport.taxi: "Taxi",
      Transport.train: "Train",
      Transport.metro: "Metro",
      Transport.coach: "Coach"
    } [this] ?? "Flight";
  }

  static Transport fromString(String s) {
    return const {
      "Flight": Transport.flight,
      "Cathay Air+Sea Service": Transport.airPlusSea,
      "Taxi": Transport.taxi,
      "Train": Transport.train,
      "Metro": Transport.metro,
      "Coach": Transport.coach
    } [s] ?? Transport.flight;
  }

  IconData icon() {
    return const {
      Transport.flight: Icons.flight,
      Transport.airPlusSea: Icons.directions_ferry,
      Transport.taxi: Icons.local_taxi,
      Transport.train: Icons.train,
      Transport.metro: Icons.directions_transit,
      Transport.coach: Icons.directions_bus
    } [this] ?? Icons.flight;
  }
}
