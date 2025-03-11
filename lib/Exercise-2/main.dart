import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/Exercise-2/provider/color_tap_provider.dart';
import 'package:flutter_workspace_term2/Exercise-2/screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ColorTapModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    ),
  );
}
