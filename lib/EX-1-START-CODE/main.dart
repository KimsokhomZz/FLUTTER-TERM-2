import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/EX-1-START-CODE/providers/courses_provider.dart';
import 'package:provider/provider.dart';
import 'screens/course_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CoursesProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CourseListScreen(),
    );
  }
}
