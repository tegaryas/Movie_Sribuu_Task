import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_sribuu_task/data/repository.dart';
import 'package:movie_sribuu_task/model/movie_model.dart';
import 'package:stream_transform/stream_transform.dart';

part 'movie_event.dart';
part 'movie_state.dart';

const throttleDuration = Duration(milliseconds: 500);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.debounce(duration), mapper);
  };
}

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository = MovieRepository();

  MovieBloc() : super(const MovieState()) {
    on<MovieFetched>(
      _onMovieSearch,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onMovieSearch(
    MovieFetched event,
    Emitter<MovieState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == MovieStatus.initial) {
        final movies = await movieRepository.getSearchMovies(state.query, 1);
        return emit(
          state.copyWith(
              status: MovieStatus.success,
              movies: movies,
              hasReachedMax: false,
              query: state.query),
        );
      }
      final movies =
          await movieRepository.getSearchMovies(state.query, state.page + 1);
      movies.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(state.copyWith(
              status: MovieStatus.success,
              movies: List.of(state.movies)..addAll(movies),
              hasReachedMax: false,
              query: state.query,
            ));
    } catch (e) {
      emit(state.copyWith(status: MovieStatus.failure));
    }
  }
}
