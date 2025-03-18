import 'package:flutter_workspace_term2/EX-1-START-CODE/models/course.dart';
import 'package:flutter_workspace_term2/EX-1-START-CODE/repositories/courses_repository.dart';

class CoursesMockRepository extends CoursesRepository {
  // Mock data
  final List<Course> _mockCourses = [
    Course(name: "Java", id: "1"),
    Course(name: "Dart", id: "2"),
    Course(name: "Flutter", id: "3"),
  ];

  @override
  List<Course> getCourses() {
    return _mockCourses; 
  }

  @override
  Course getCourseFor(String courseId) {
    // return course with id and throw exception if the course not found
    return _mockCourses.firstWhere((course) => course.id == courseId,
        orElse: () => throw Exception("Course cannot found"));
  }

  @override
  void addScore(String courseId, CourseScore score) {
    // 1- I get the course
    final Course course = getCourseFor(courseId);
    // 2- I add the score to the course
    course.addScore(score);
  }
}
