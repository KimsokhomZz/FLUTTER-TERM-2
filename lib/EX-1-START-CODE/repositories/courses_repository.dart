import 'package:flutter_workspace_term2/EX-1-START-CODE/models/course.dart';

abstract class CoursesRepository {
  List<Course> getCourses();
  Course getCourseFor(String courseId);
  void addScore(String courseId, CourseScore score);
}