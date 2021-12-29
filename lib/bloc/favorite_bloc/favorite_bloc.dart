import 'package:bloc/bloc.dart';
import 'package:movie_sribuu_task/data/localdb/favorite_dao.dart';
import 'package:movie_sribuu_task/data/localdb/favorite_db.dart';

class FavoriteBloc extends BlocBase {
  final FavoriteDao? movieDao;
  FavoriteBloc({this.movieDao}) : super(null);

  getAllMovies() {
    return movieDao!.getAllFavorite();
  }

  watchAllMovies() {
    return movieDao!.watchAllFavorite();
  }

  removeMovie(Movie movie) {
    return movieDao!.deleteNewMovie(movie);
  }

  checkAlready(int id) {
    return movieDao!.isfavoritesById(id);
  }

  addMovie(Movie movie) {
    return movieDao!.insertNewMovie(movie);
  }
}
