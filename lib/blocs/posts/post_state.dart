import 'package:equatable/equatable.dart';
import '../../models/post.dart';

abstract class PostsState extends Equatable {
  @override
  List<Object> get props => const [];
}

class PostsStateInitial extends PostsState {}

class PostsStateLoading extends PostsState {}

class PostsStateLoaded extends PostsState {
  final List<Post> posts;

  PostsStateLoaded({this.posts}) : assert(posts != null);

  @override
  List<Object> get props => [posts];
}

class PostsStateError extends PostsState {
  final String message;

  PostsStateError({this.message}) : assert(message != null);
}
