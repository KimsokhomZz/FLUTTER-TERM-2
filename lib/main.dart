import 'package:flutter/material.dart';
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
      home: Scaffold(
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    BlaButton(
                      text: 'Request to book',
                      onPressed: () => print('Request button pressed'),
                      icon: CupertinoIcons.calendar_circle,
                    ),
                    const SizedBox(height: 20),
                    BlaButton(
                      text: 'Contack Volodia',
                      onPressed: () => print('Contack Volodia'),
                      icon: CupertinoIcons.bubble_left_bubble_right,
                      isPrimary: false,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
