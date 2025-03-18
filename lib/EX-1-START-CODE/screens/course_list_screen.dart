import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/EX-1-START-CODE/providers/courses_provider.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import 'course_screen.dart';

const Color mainColor = Colors.blue;

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  // Autumatically fetch courses in the initState
  @override
  void initState() {
    super.initState();
    // 1- Access the coursesProvider
    final CoursesProvider coursesProvider = context.read<CoursesProvider>();
    // 2- fetching the courses
    coursesProvider.fetchCourses(); 
  }

  void _editCourse(String courseId) async {
    await Navigator.of(context).push<Course>(
      MaterialPageRoute(builder: (ctx) => CourseScreen(courseId: courseId)),
    );

    // setState(() {
    //   // trigger a rebuild
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('SCORE APP', style: TextStyle(color: Colors.white)),
      ),
      body: Consumer<CoursesProvider>(
        builder: (context, coursesProvider, child) {
          final List<Course> coursesList =
              coursesProvider.courses; // Access provider courses list
          return ListView.builder(
            itemCount: coursesList.length,
            itemBuilder: (ctx, index) {
              final Course course =
                  coursesList[index]; // Each course in the list
              return Dismissible(
                key: Key(course.id), // I used course id as key
                child: CourseTile(
                  course: course,
                  onEdit: () => _editCourse(course.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CourseTile extends StatelessWidget {
  const CourseTile({super.key, required this.course, required this.onEdit});

  final Course course;
  final VoidCallback onEdit;

  int get numberOfScores => course.scores.length;

  String get numberText {
    return course.hasScore ? "$numberOfScores scores" : 'No score';
  }

  String get averageText {
    String average = course.average.toStringAsFixed(1);
    return course.hasScore ? "Average : $average" : '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            onTap: onEdit,
            title: Text(course.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(numberText), Text(averageText)],
            ),
          ),
        ),
      ),
    );
  }
}
