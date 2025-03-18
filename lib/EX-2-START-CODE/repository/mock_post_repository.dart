import '../model/post.dart';

import 'post_repository.dart';

class MockPostRepository extends PostRepository {
  // Mock post data
  final List<Post> _posts = [
    Post(
        id: 1,
        title: 'Flutter The Best',
        description: 'Learn fundamental of Flutter.'),
    Post(id: 2, title: 'Who is the best?', description: 'Ronan is the best.'),
    Post(id: 3, title: 'State Management', description: 'Understand Provider.')
  ];
  
  @override
  Future<List<Post>> getPosts() {
    return Future.delayed(Duration(seconds: 5), () {
      return _posts;
    });
  }
}
