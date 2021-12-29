part of 'movie_bloc.dart';

enum MovieStatus { initial, success, failure }

class MovieState extends Equatable {
  const MovieState({
    this.status = MovieStatus.initial,
    this.movies = const <MovieModel>[],
    this.hasReachedMax = false,
    this.query = "money",
    this.page = 1,
  });

  final MovieStatus status;
  final List<MovieModel> movies;
  final bool hasReachedMax;
  final String query;
  final int page;

  MovieState copyWith(
      {MovieStatus? status,
      List<MovieModel>? movies,
      bool? hasReachedMax,
      String? query,
      int? page}) {
    return MovieState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      query: query ?? this.query,
      page: page ?? this.page,
    );
  }

  @override
  String toString() {
    return '''MovieState { status: $status, hasReachedMax: $hasReachedMax, movies: ${movies.length}, query: $query }''';
  }

  @override
  List<Object> get props => [status, movies, hasReachedMax, query, page];
}
