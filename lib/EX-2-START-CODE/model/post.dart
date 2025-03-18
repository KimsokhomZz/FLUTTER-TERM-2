class Post {
  final int id;
  final String title;
  final String description;

  Post({required this.id, required this.title, required this.description});

  // Add factory constructor to convert JSON object to Post object
  factory Post.fromJson(Map<String, dynamic> json) {
    assert(json['id'] is int);
    return Post(
      id: json['id'],
      title: json['title'],
      description: json['body'],
    );
  }
}
