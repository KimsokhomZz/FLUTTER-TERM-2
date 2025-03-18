import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/EX-1-START-CODE/providers/courses_provider.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import 'course_score_form.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key, required this.courseId});

  // final Course course;
  final String courseId;

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  void _addScore() async {
    CourseScore? newScore = await Navigator.of(context).push<CourseScore>(
      MaterialPageRoute(builder: (ctx) => const CourseScoreForm()),
    );

    if (newScore != null && mounted) {
      // Add new score through provider addScore method
      context.read<CoursesProvider>().addScore(widget.courseId, newScore);
    }
  }

  Color scoreColor(double score) {
    return score > 50 ? Colors.green : Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    // Get course through provider
    final Course course =
        context.read<CoursesProvider>().getCourseFor(widget.courseId);
    // Accese course's scores list
    final List<CourseScore> scores = course.scores;

    Widget content = const Center(child: Text('No Scores added yet.'));

    if (scores.isNotEmpty) {
      content = ListView.builder(
        itemCount: scores.length,
        itemBuilder: (ctx, index) => ListTile(
          title: Text(scores[index].studentName),
          trailing: Text(
            scores[index].studenScore.toString(),
            style: TextStyle(
              color: scoreColor(scores[index].studenScore),
              fontSize: 15,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          course.name,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: _addScore, icon: const Icon(Icons.add)),
        ],
      ),
      body: content,
    );
  }
}
