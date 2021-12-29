import 'package:moor_flutter/moor_flutter.dart';

import 'favorite_dao.dart';
part 'favorite_db.g.dart';

class Movies extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get popularity => integer()();
  IntColumn get voteCount => integer()();
  BoolColumn get video => boolean()();
  TextColumn get posterPath => text().nullable()();
  TextColumn get idMovie => text()();
  BoolColumn get adult => boolean()();
  TextColumn get backdropPath => text().nullable()();
  TextColumn get originalLanguage => text()();
  TextColumn get originalTitle => text()();
  TextColumn get title => text().nullable()();
  IntColumn get voteAverage => integer()();
  TextColumn get overview => text()();
  TextColumn get releaseDate => text()();
}

@UseMoor(tables: [Movies], daos: [FavoriteDao])
class MovieFavoriteDB extends _$MovieFavoriteDB {
  MovieFavoriteDB()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'moviesfavorite.sqlite'));

  @override
  int get schemaVersion => 1;
}
