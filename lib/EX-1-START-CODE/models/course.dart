class Course {
  Course({required this.name, required this.id});

  final String name;
  final String id; // I added id property to Course
  final List<CourseScore> scores = [];

  void addScore(CourseScore score) {
    scores.add(score);
  }

  bool get hasScore => scores.isNotEmpty;

  double get average {
    if (scores.isNotEmpty) {
      double total = scores.fold(0, (prev, score) => prev + score.studenScore);
      return total / scores.length;
    }
    return 0;
  }
}

class CourseScore {
  const CourseScore({required this.studentName, required this.studenScore});

  final String studentName;
  final double studenScore;
}
