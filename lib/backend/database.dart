import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:skywalker/backend/account.dart';

void toDatabaseSync(AccountData account) async {
  print("Sync up");
  var db = FirebaseFirestore.instance;
  final accountMap = await account.toMap();
  try {
    db.collection("users").doc(account.uid).set(accountMap).onError((error, stacktrace) => print("Failed to set accountMap: $error \n $stacktrace"));
  } on FirebaseException catch (error) {
    print("Could not upload profileImage to Firebase Storage: $error");
  }
}
