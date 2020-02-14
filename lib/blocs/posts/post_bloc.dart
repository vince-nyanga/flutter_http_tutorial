import 'package:bloc/bloc.dart';
import '../../repository/posts/post_repository.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostRepository _repository;

  PostsBloc(PostRepository repository)
      : assert(repository != null),
        _repository = repository;

  @override
  PostsState get initialState => PostsStateInitial();

  @override
  Stream<PostsState> mapEventToState(PostsEvent event) async* {
    if (event is PostsPageLoaded) {
      yield* _mapPageLoadedToState(event);
    }
  }

  Stream<PostsState> _mapPageLoadedToState(PostsPageLoaded event) async* {
    yield PostsStateLoading();
    try {
      final posts = await _repository.getPosts();
      yield PostsStateLoaded(posts: posts);
    } catch (e) {
      yield PostsStateError(message: e.message ?? 'An unexpected error occured');
    }
  }
}
