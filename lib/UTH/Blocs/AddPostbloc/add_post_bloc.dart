import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scouts_minia/UTH/Repos/add_post_repo.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final AddPostRepo _repo = AddPostRepo();
  @override
  AddPostState get initialState => AddPostInitial();

  @override
  Stream<AddPostState> mapEventToState(
    AddPostEvent event,
  ) async* {
    if (event is OnButtonPressed) {
      yield AddPostLoading();
      await _repo.addPost(
          title: event.title, content: event.content, image: event.image);
      var response = await _repo.message;
      if (response == 'error')
        yield AddpostFailure(error: 'error');
      else {
        yield AddPostDone();
      }
    }
  }
}
