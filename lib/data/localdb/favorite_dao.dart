import 'package:moor_flutter/moor_flutter.dart';

import 'favorite_db.dart';

part 'favorite_dao.g.dart';

@UseDao(
  tables: [Movies],
)
class FavoriteDao extends DatabaseAccessor<MovieFavoriteDB>
    with _$FavoriteDaoMixin {
  FavoriteDao(MovieFavoriteDB db) : super(db);

  Future<List<Movie>> getAllFavorite() => select(movies).get();
  Stream<List<Movie>> watchAllFavorite() => select(movies).watch();
  Future insertNewMovie(Movie movie) => into(movies).insert(movie);
  Future deleteNewMovie(Movie movie) => delete(movies).delete(movie);

  // Future<bool?> isfavoritesById(int id) => (select(movies)..where((u) => u.id == id)).watchSingle();

  Stream<Movie> isfavoritesById(int id) {
    return (select(movies)..where((u) => u.id.equals(id))).watchSingle();
  }
}
