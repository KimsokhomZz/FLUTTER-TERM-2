import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/EX-2-START-CODE/repository/http_posts_repository.dart';
import 'package:provider/provider.dart';
import 'ui/providers/post_provider.dart';
import 'ui/screens/post_screen.dart';

void main() {
  // 1- Create the repository
  HttpPostsRepository httpPostsRepository = HttpPostsRepository();

  // 2 - Run the UI
  runApp(
    ChangeNotifierProvider(
      create: (context) => PostProvider(repository: httpPostsRepository),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: PostScreen()),
    ),
  );
}
