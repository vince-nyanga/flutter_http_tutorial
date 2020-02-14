import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repository/posts/post_repository.dart';
import 'pages/posts_page.dart';
import 'blocs/posts/post_bloc.dart';
import 'blocs/posts/post_event.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'My Posts',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      theme: CupertinoThemeData(
        primaryColor: Colors.purple
      ),
      home: BlocProvider<PostsBloc>(
        create: (context) => PostsBloc(HttpPostRepository())..add(PostsPageLoaded()),
        child: PostsPage(),
      ),
    );
  }
}
