import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/EX-1-START-CODE/models/course.dart';
import 'package:flutter_workspace_term2/EX-1-START-CODE/repositories/courses_mock_repository.dart';

class CoursesProvider extends ChangeNotifier {
  final CoursesMockRepository _repository = CoursesMockRepository();
  List<Course> _courses = [];

  List<Course> get courses => _courses;

  // Handle fetching all courses
  void fetchCourses() {
    // 1- I create new copy of the list that return from repository
    _courses = List.from(_repository.getCourses());
    // 2- Notify listeners
    notifyListeners();
  }

  // Handle returning a course by id
  Course getCourseFor(String courseId) {
    return _repository.getCourseFor(courseId);
  }

  // Handle adding new score to course
  void addScore(String courseId, CourseScore score) {
    // 1- Adding new score to the course
    _repository.addScore(courseId, score);
    // 2- Fetching latest courses list from repository
    _courses = List.from(_repository.getCourses());
    // 3. Notify listeners
    notifyListeners();
  }
}
