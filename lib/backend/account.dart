import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skywalker/backend/auth_gate.dart';
import 'package:skywalker/misc/gender.dart';
import 'package:skywalker/misc/name.dart';
import 'package:skywalker/misc/trip.dart';

class Account extends StatelessWidget {
  const Account({
    super.key,
    this.child = const Scaffold(),
  });

  final Widget child;

  static AccountData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AccountData>()!;
  }

  @override
  Widget build(BuildContext context) {
    final authInfo = AuthInfo.of(context);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(authInfo.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.data() == null) {
            return AccountData(
              uid: authInfo.uid,
              child: const CircularProgressIndicator.adaptive(),
            );
          }

          final data = snapshot.data!.data()!;

          DateTime? dateOfBirth =
              ((data["dateOfBirth"] ?? Timestamp.now()) as Timestamp).toDate();
          if (dateOfBirth.year < 1900) {
            dateOfBirth = null;
          }

          var newAccountData = AccountData(
            uid: authInfo.uid,
            name: Name((data["givenName"] ?? "") as String,
                (data["familyName"] ?? "") as String),
            dateOfBirth: dateOfBirth,
            email: (data["email"] ?? "") as String,
            gender: Gender.fromString((data["gender"] ?? "Male") as String),
            phoneNo: (data["phoneNo"] ?? "") as String,
            region: (data["region"] ?? "") as String,
            trip: Trip.fromMap(
                data["trip"] ?? const {"image": "", "journeys": []}),
            child: child,
          );

          return newAccountData;
        });
  }
}

class AccountData extends InheritedWidget {
  final String uid;
  final Name name;
  final Gender gender;
  final DateTime? dateOfBirth;
  final String email;
  final String phoneNo;
  final String region;
  final Trip trip;

  int get age =>
      (DateTime.now().difference(dateOfBirth ?? DateTime.now()).inDays / 365.25)
          .floor();

  const AccountData(
      {super.key,
      this.uid = "",
      this.name = const Name("", ""),
      this.gender = Gender.male,
      this.dateOfBirth,
      this.email = "",
      this.phoneNo = "",
      this.region = "",
      this.trip = const Trip(),
      super.child = const Placeholder()});

  AccountData copyWithEmpty() {
    return AccountData(
      name: const Name("", ""),
      dateOfBirth: DateTime.now(),
      gender: Gender.male,
      email: "",
      phoneNo: "",
      region: "",
      trip: const Trip(),
      uid: uid,
    );
  }

  AccountData copyWith({
    String? uid,
    Name? name,
    Gender? gender,
    int? age,
    DateTime? dateOfBirth,
    String? email,
    String? phoneNo,
    Widget? child,
    String? region,
    Trip? trip,
    Trip? plan,
  }) {
    return AccountData(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      region: region ?? this.region,
      trip: trip ?? this.trip,
      child: child ?? this.child,
    );
  }

  Future<Map<String, dynamic>> toMap() async {
    Timestamp dateOfBirthConverted =
        Timestamp.fromDate(dateOfBirth ?? DateTime.now());
    return {
      "givenName": name.given,
      "familyName": name.family,
      "gender": gender.toString(),
      "dateOfBirth": dateOfBirthConverted,
      "email": email,
      "phoneNo": phoneNo,
      "region": region,
      "trip": trip.toMap(),
    };
  }

  @override
  bool updateShouldNotify(AccountData oldWidget) {
    return name != oldWidget.name ||
        gender != oldWidget.gender ||
        dateOfBirth != oldWidget.dateOfBirth ||
        email != oldWidget.email ||
        phoneNo != oldWidget.phoneNo ||
        uid != oldWidget.uid ||
        region != oldWidget.region ||
        trip != oldWidget.trip;
  }
}
