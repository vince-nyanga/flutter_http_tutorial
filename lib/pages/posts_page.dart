import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/posts/post_bloc.dart';
import '../blocs/posts/post_state.dart';

class PostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostsStateError) {
            return _buildErrorView(state);
          }

          if (state is PostsStateLoaded) {
            return _buildPostsView(state);
          }
          return _buildLoadingView();
        },
      ),
    );
  }

  Widget _buildErrorView(PostsStateError state) {
    final sliver = SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Container(
          height: MediaQuery.of(context).size.height * .7,
          child: Center(
            child: Text(state.message),
          ),
        );
      }, childCount: 1),
    );
    return _buildFromBaseView(sliver);
  }

  Widget _buildPostsView(PostsStateLoaded state) {
    final sliver = SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final post = state.posts[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Material(
              color: Colors.transparent,
              child: ListTile(
                title: Text(
                  post.title,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  post.body,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            if (index < state.posts.length - 1) // don't add divider to the last item
              Divider(
                color: Colors.grey,
              )
          ],
        );
      }, childCount: state.posts.length),
    );
    return _buildFromBaseView(sliver);
  }

  Widget _buildLoadingView() {
    final sliver = SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Container(
            height: MediaQuery.of(context).size.height * .7,
            child: Center(
              child: CupertinoActivityIndicator(),
            ));
      }, childCount: 1),
    );
    return _buildFromBaseView(sliver);
  }

  Widget _buildFromBaseView(sliver) {
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text('Posts'),
        ),
        SliverSafeArea(
          top: false,
          minimum: const EdgeInsets.all(8),
          sliver: sliver,
        )
      ],
    );
  }
}
