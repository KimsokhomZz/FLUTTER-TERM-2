import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_workspace_term2/EX-2-START-CODE/model/post.dart';
import 'package:flutter_workspace_term2/EX-2-START-CODE/repository/post_repository.dart';

class HttpPostsRepository extends PostRepository {
  static const String url = "https://jsonplaceholder.typicode.com/posts";

  @override
  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception("Failed to get posts");
    }
  }
}
