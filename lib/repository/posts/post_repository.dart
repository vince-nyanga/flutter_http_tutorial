import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../models/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
}

class HttpPostRepository extends PostRepository {
  final String baseUrl;

  HttpPostRepository({this.baseUrl = 'https://jsonplaceholder.typicode.com'}) : assert(baseUrl != null);

  @override
  Future<List<Post>> getPosts() async {
    final response = await http.get('$baseUrl/posts');

    if (response.statusCode == 200) {
      final List<dynamic> postsJson = jsonDecode(response.body);
      return postsJson.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
