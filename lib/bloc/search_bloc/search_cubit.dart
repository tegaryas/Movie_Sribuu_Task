import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_sribuu_task/data/repository.dart';
import 'package:movie_sribuu_task/model/movie_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  MovieRepository movieRepository = MovieRepository();

  Future<void> onSearchMovie(String query) async {
    try {
      emit(SearchLoading());
      final result = await movieRepository.getSearchMovies(query, 1);
      emit(SearchLoaded(movies: result, hasReachMax: false));
    } catch (e) {
      emit(SearchFailed());
    }
  }

  void reset() => emit(SearchInitial());
}
