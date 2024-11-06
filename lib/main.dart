import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skywalker/backend/account.dart';
import 'package:skywalker/backend/auth_gate.dart';
import 'package:skywalker/main_app.dart';
import 'package:i18n_extension/i18n_extension.dart';
import 'package:skywalker/backend/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(ThemedApp(
    home: I18n(
        child: AuthGate(
            child: Account(
      child: MainApp(),
    ))),
  ));
}
