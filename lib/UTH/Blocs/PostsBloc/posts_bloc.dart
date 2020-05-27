import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scouts_minia/UTH/Repos/posts_repo.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepo _repo = PostsRepo();
  @override
  PostsState get initialState => PostsInitial();

  @override
  Stream<PostsState> mapEventToState(
    PostsEvent event,
  ) async* {
    if (event is OnSectionPressed) {
      try {
        yield PostsLoading();
        await _repo.get();
        var response = await _repo.message;
        if (response == 'error')
          yield PostsFailure(error: 'error');
        else {
          List posts = [];
          for (var i in response) {
            Map<String, dynamic> post = {
              'name': i['name'],
              'about': i['about'],
              'dp': i['dp'],
              'email': i['email'],
              'index': i['index'],
              'pic': i['picture'],
              'date': i['date'],
              'details': i['details'],
            };
            posts.add(post);
          }
          yield PostsDone(posts: posts);
        }
      } catch (e) {
        yield PostsFailure(error: 'error');
      }
    }
  }
}
