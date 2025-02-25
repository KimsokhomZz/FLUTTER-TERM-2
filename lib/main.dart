import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/screens/ride_pref/widgets/ride_pref_form.dart';
import 'package:flutter_workspace_term2/widgets/actions/bla_button.dart';
import 'screens/ride_pref/ride_pref_screen.dart';
import 'theme/theme.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      // home: Scaffold(body: RidePrefScreen()),
      home: Scaffold(body: RidePrefForm()),
    );
  }
}
