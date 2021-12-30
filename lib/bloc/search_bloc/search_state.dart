part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<MovieModel> movies;
  final bool hasReachMax;

  const SearchLoaded({required this.movies, required this.hasReachMax});

  @override
  List<Object> get props => [movies, hasReachMax];
}

class SearchFailed extends SearchState {}
