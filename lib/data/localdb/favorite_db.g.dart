// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Movie extends DataClass implements Insertable<Movie> {
  final int id;
  final int popularity;
  final int voteCount;
  final bool video;
  final String? posterPath;
  final String idMovie;
  final bool adult;
  final String? backdropPath;
  final String originalLanguage;
  final String originalTitle;
  final String? title;
  final int voteAverage;
  final String overview;
  final String releaseDate;
  Movie(
      {required this.id,
      required this.popularity,
      required this.voteCount,
      required this.video,
      this.posterPath,
      required this.idMovie,
      required this.adult,
      this.backdropPath,
      required this.originalLanguage,
      required this.originalTitle,
      this.title,
      required this.voteAverage,
      required this.overview,
      required this.releaseDate});
  factory Movie.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Movie(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      popularity: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}popularity'])!,
      voteCount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}vote_count'])!,
      video: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}video'])!,
      posterPath: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}poster_path']),
      idMovie: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id_movie'])!,
      adult: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}adult'])!,
      backdropPath: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}backdrop_path']),
      originalLanguage: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}original_language'])!,
      originalTitle: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}original_title'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title']),
      voteAverage: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}vote_average'])!,
      overview: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}overview'])!,
      releaseDate: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}release_date'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['popularity'] = Variable<int>(popularity);
    map['vote_count'] = Variable<int>(voteCount);
    map['video'] = Variable<bool>(video);
    if (!nullToAbsent || posterPath != null) {
      map['poster_path'] = Variable<String?>(posterPath);
    }
    map['id_movie'] = Variable<String>(idMovie);
    map['adult'] = Variable<bool>(adult);
    if (!nullToAbsent || backdropPath != null) {
      map['backdrop_path'] = Variable<String?>(backdropPath);
    }
    map['original_language'] = Variable<String>(originalLanguage);
    map['original_title'] = Variable<String>(originalTitle);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String?>(title);
    }
    map['vote_average'] = Variable<int>(voteAverage);
    map['overview'] = Variable<String>(overview);
    map['release_date'] = Variable<String>(releaseDate);
    return map;
  }

  MoviesCompanion toCompanion(bool nullToAbsent) {
    return MoviesCompanion(
      id: Value(id),
      popularity: Value(popularity),
      voteCount: Value(voteCount),
      video: Value(video),
      posterPath: posterPath == null && nullToAbsent
          ? const Value.absent()
          : Value(posterPath),
      idMovie: Value(idMovie),
      adult: Value(adult),
      backdropPath: backdropPath == null && nullToAbsent
          ? const Value.absent()
          : Value(backdropPath),
      originalLanguage: Value(originalLanguage),
      originalTitle: Value(originalTitle),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      voteAverage: Value(voteAverage),
      overview: Value(overview),
      releaseDate: Value(releaseDate),
    );
  }

  factory Movie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Movie(
      id: serializer.fromJson<int>(json['id']),
      popularity: serializer.fromJson<int>(json['popularity']),
      voteCount: serializer.fromJson<int>(json['voteCount']),
      video: serializer.fromJson<bool>(json['video']),
      posterPath: serializer.fromJson<String?>(json['posterPath']),
      idMovie: serializer.fromJson<String>(json['idMovie']),
      adult: serializer.fromJson<bool>(json['adult']),
      backdropPath: serializer.fromJson<String?>(json['backdropPath']),
      originalLanguage: serializer.fromJson<String>(json['originalLanguage']),
      originalTitle: serializer.fromJson<String>(json['originalTitle']),
      title: serializer.fromJson<String?>(json['title']),
      voteAverage: serializer.fromJson<int>(json['voteAverage']),
      overview: serializer.fromJson<String>(json['overview']),
      releaseDate: serializer.fromJson<String>(json['releaseDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'popularity': serializer.toJson<int>(popularity),
      'voteCount': serializer.toJson<int>(voteCount),
      'video': serializer.toJson<bool>(video),
      'posterPath': serializer.toJson<String?>(posterPath),
      'idMovie': serializer.toJson<String>(idMovie),
      'adult': serializer.toJson<bool>(adult),
      'backdropPath': serializer.toJson<String?>(backdropPath),
      'originalLanguage': serializer.toJson<String>(originalLanguage),
      'originalTitle': serializer.toJson<String>(originalTitle),
      'title': serializer.toJson<String?>(title),
      'voteAverage': serializer.toJson<int>(voteAverage),
      'overview': serializer.toJson<String>(overview),
      'releaseDate': serializer.toJson<String>(releaseDate),
    };
  }

  Movie copyWith(
          {int? id,
          int? popularity,
          int? voteCount,
          bool? video,
          String? posterPath,
          String? idMovie,
          bool? adult,
          String? backdropPath,
          String? originalLanguage,
          String? originalTitle,
          String? title,
          int? voteAverage,
          String? overview,
          String? releaseDate}) =>
      Movie(
        id: id ?? this.id,
        popularity: popularity ?? this.popularity,
        voteCount: voteCount ?? this.voteCount,
        video: video ?? this.video,
        posterPath: posterPath ?? this.posterPath,
        idMovie: idMovie ?? this.idMovie,
        adult: adult ?? this.adult,
        backdropPath: backdropPath ?? this.backdropPath,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        originalTitle: originalTitle ?? this.originalTitle,
        title: title ?? this.title,
        voteAverage: voteAverage ?? this.voteAverage,
        overview: overview ?? this.overview,
        releaseDate: releaseDate ?? this.releaseDate,
      );
  @override
  String toString() {
    return (StringBuffer('Movie(')
          ..write('id: $id, ')
          ..write('popularity: $popularity, ')
          ..write('voteCount: $voteCount, ')
          ..write('video: $video, ')
          ..write('posterPath: $posterPath, ')
          ..write('idMovie: $idMovie, ')
          ..write('adult: $adult, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('originalLanguage: $originalLanguage, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('title: $title, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('overview: $overview, ')
          ..write('releaseDate: $releaseDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      popularity,
      voteCount,
      video,
      posterPath,
      idMovie,
      adult,
      backdropPath,
      originalLanguage,
      originalTitle,
      title,
      voteAverage,
      overview,
      releaseDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Movie &&
          other.id == this.id &&
          other.popularity == this.popularity &&
          other.voteCount == this.voteCount &&
          other.video == this.video &&
          other.posterPath == this.posterPath &&
          other.idMovie == this.idMovie &&
          other.adult == this.adult &&
          other.backdropPath == this.backdropPath &&
          other.originalLanguage == this.originalLanguage &&
          other.originalTitle == this.originalTitle &&
          other.title == this.title &&
          other.voteAverage == this.voteAverage &&
          other.overview == this.overview &&
          other.releaseDate == this.releaseDate);
}

class MoviesCompanion extends UpdateCompanion<Movie> {
  final Value<int> id;
  final Value<int> popularity;
  final Value<int> voteCount;
  final Value<bool> video;
  final Value<String?> posterPath;
  final Value<String> idMovie;
  final Value<bool> adult;
  final Value<String?> backdropPath;
  final Value<String> originalLanguage;
  final Value<String> originalTitle;
  final Value<String?> title;
  final Value<int> voteAverage;
  final Value<String> overview;
  final Value<String> releaseDate;
  const MoviesCompanion({
    this.id = const Value.absent(),
    this.popularity = const Value.absent(),
    this.voteCount = const Value.absent(),
    this.video = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.idMovie = const Value.absent(),
    this.adult = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.originalLanguage = const Value.absent(),
    this.originalTitle = const Value.absent(),
    this.title = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.overview = const Value.absent(),
    this.releaseDate = const Value.absent(),
  });
  MoviesCompanion.insert({
    this.id = const Value.absent(),
    required int popularity,
    required int voteCount,
    required bool video,
    this.posterPath = const Value.absent(),
    required String idMovie,
    required bool adult,
    this.backdropPath = const Value.absent(),
    required String originalLanguage,
    required String originalTitle,
    this.title = const Value.absent(),
    required int voteAverage,
    required String overview,
    required String releaseDate,
  })  : popularity = Value(popularity),
        voteCount = Value(voteCount),
        video = Value(video),
        idMovie = Value(idMovie),
        adult = Value(adult),
        originalLanguage = Value(originalLanguage),
        originalTitle = Value(originalTitle),
        voteAverage = Value(voteAverage),
        overview = Value(overview),
        releaseDate = Value(releaseDate);
  static Insertable<Movie> custom({
    Expression<int>? id,
    Expression<int>? popularity,
    Expression<int>? voteCount,
    Expression<bool>? video,
    Expression<String?>? posterPath,
    Expression<String>? idMovie,
    Expression<bool>? adult,
    Expression<String?>? backdropPath,
    Expression<String>? originalLanguage,
    Expression<String>? originalTitle,
    Expression<String?>? title,
    Expression<int>? voteAverage,
    Expression<String>? overview,
    Expression<String>? releaseDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (popularity != null) 'popularity': popularity,
      if (voteCount != null) 'vote_count': voteCount,
      if (video != null) 'video': video,
      if (posterPath != null) 'poster_path': posterPath,
      if (idMovie != null) 'id_movie': idMovie,
      if (adult != null) 'adult': adult,
      if (backdropPath != null) 'backdrop_path': backdropPath,
      if (originalLanguage != null) 'original_language': originalLanguage,
      if (originalTitle != null) 'original_title': originalTitle,
      if (title != null) 'title': title,
      if (voteAverage != null) 'vote_average': voteAverage,
      if (overview != null) 'overview': overview,
      if (releaseDate != null) 'release_date': releaseDate,
    });
  }

  MoviesCompanion copyWith(
      {Value<int>? id,
      Value<int>? popularity,
      Value<int>? voteCount,
      Value<bool>? video,
      Value<String?>? posterPath,
      Value<String>? idMovie,
      Value<bool>? adult,
      Value<String?>? backdropPath,
      Value<String>? originalLanguage,
      Value<String>? originalTitle,
      Value<String?>? title,
      Value<int>? voteAverage,
      Value<String>? overview,
      Value<String>? releaseDate}) {
    return MoviesCompanion(
      id: id ?? this.id,
      popularity: popularity ?? this.popularity,
      voteCount: voteCount ?? this.voteCount,
      video: video ?? this.video,
      posterPath: posterPath ?? this.posterPath,
      idMovie: idMovie ?? this.idMovie,
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      title: title ?? this.title,
      voteAverage: voteAverage ?? this.voteAverage,
      overview: overview ?? this.overview,
      releaseDate: releaseDate ?? this.releaseDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (popularity.present) {
      map['popularity'] = Variable<int>(popularity.value);
    }
    if (voteCount.present) {
      map['vote_count'] = Variable<int>(voteCount.value);
    }
    if (video.present) {
      map['video'] = Variable<bool>(video.value);
    }
    if (posterPath.present) {
      map['poster_path'] = Variable<String?>(posterPath.value);
    }
    if (idMovie.present) {
      map['id_movie'] = Variable<String>(idMovie.value);
    }
    if (adult.present) {
      map['adult'] = Variable<bool>(adult.value);
    }
    if (backdropPath.present) {
      map['backdrop_path'] = Variable<String?>(backdropPath.value);
    }
    if (originalLanguage.present) {
      map['original_language'] = Variable<String>(originalLanguage.value);
    }
    if (originalTitle.present) {
      map['original_title'] = Variable<String>(originalTitle.value);
    }
    if (title.present) {
      map['title'] = Variable<String?>(title.value);
    }
    if (voteAverage.present) {
      map['vote_average'] = Variable<int>(voteAverage.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String>(releaseDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MoviesCompanion(')
          ..write('id: $id, ')
          ..write('popularity: $popularity, ')
          ..write('voteCount: $voteCount, ')
          ..write('video: $video, ')
          ..write('posterPath: $posterPath, ')
          ..write('idMovie: $idMovie, ')
          ..write('adult: $adult, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('originalLanguage: $originalLanguage, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('title: $title, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('overview: $overview, ')
          ..write('releaseDate: $releaseDate')
          ..write(')'))
        .toString();
  }
}

class $MoviesTable extends Movies with TableInfo<$MoviesTable, Movie> {
  final GeneratedDatabase _db;
  final String? _alias;
  $MoviesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _popularityMeta = const VerificationMeta('popularity');
  @override
  late final GeneratedColumn<int?> popularity = GeneratedColumn<int?>(
      'popularity', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _voteCountMeta = const VerificationMeta('voteCount');
  @override
  late final GeneratedColumn<int?> voteCount = GeneratedColumn<int?>(
      'vote_count', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _videoMeta = const VerificationMeta('video');
  @override
  late final GeneratedColumn<bool?> video = GeneratedColumn<bool?>(
      'video', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (video IN (0, 1))');
  final VerificationMeta _posterPathMeta = const VerificationMeta('posterPath');
  @override
  late final GeneratedColumn<String?> posterPath = GeneratedColumn<String?>(
      'poster_path', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _idMovieMeta = const VerificationMeta('idMovie');
  @override
  late final GeneratedColumn<String?> idMovie = GeneratedColumn<String?>(
      'id_movie', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _adultMeta = const VerificationMeta('adult');
  @override
  late final GeneratedColumn<bool?> adult = GeneratedColumn<bool?>(
      'adult', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (adult IN (0, 1))');
  final VerificationMeta _backdropPathMeta =
      const VerificationMeta('backdropPath');
  @override
  late final GeneratedColumn<String?> backdropPath = GeneratedColumn<String?>(
      'backdrop_path', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _originalLanguageMeta =
      const VerificationMeta('originalLanguage');
  @override
  late final GeneratedColumn<String?> originalLanguage =
      GeneratedColumn<String?>('original_language', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _originalTitleMeta =
      const VerificationMeta('originalTitle');
  @override
  late final GeneratedColumn<String?> originalTitle = GeneratedColumn<String?>(
      'original_title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _voteAverageMeta =
      const VerificationMeta('voteAverage');
  @override
  late final GeneratedColumn<int?> voteAverage = GeneratedColumn<int?>(
      'vote_average', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _overviewMeta = const VerificationMeta('overview');
  @override
  late final GeneratedColumn<String?> overview = GeneratedColumn<String?>(
      'overview', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  @override
  late final GeneratedColumn<String?> releaseDate = GeneratedColumn<String?>(
      'release_date', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        popularity,
        voteCount,
        video,
        posterPath,
        idMovie,
        adult,
        backdropPath,
        originalLanguage,
        originalTitle,
        title,
        voteAverage,
        overview,
        releaseDate
      ];
  @override
  String get aliasedName => _alias ?? 'movies';
  @override
  String get actualTableName => 'movies';
  @override
  VerificationContext validateIntegrity(Insertable<Movie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('popularity')) {
      context.handle(
          _popularityMeta,
          popularity.isAcceptableOrUnknown(
              data['popularity']!, _popularityMeta));
    } else if (isInserting) {
      context.missing(_popularityMeta);
    }
    if (data.containsKey('vote_count')) {
      context.handle(_voteCountMeta,
          voteCount.isAcceptableOrUnknown(data['vote_count']!, _voteCountMeta));
    } else if (isInserting) {
      context.missing(_voteCountMeta);
    }
    if (data.containsKey('video')) {
      context.handle(
          _videoMeta, video.isAcceptableOrUnknown(data['video']!, _videoMeta));
    } else if (isInserting) {
      context.missing(_videoMeta);
    }
    if (data.containsKey('poster_path')) {
      context.handle(
          _posterPathMeta,
          posterPath.isAcceptableOrUnknown(
              data['poster_path']!, _posterPathMeta));
    }
    if (data.containsKey('id_movie')) {
      context.handle(_idMovieMeta,
          idMovie.isAcceptableOrUnknown(data['id_movie']!, _idMovieMeta));
    } else if (isInserting) {
      context.missing(_idMovieMeta);
    }
    if (data.containsKey('adult')) {
      context.handle(
          _adultMeta, adult.isAcceptableOrUnknown(data['adult']!, _adultMeta));
    } else if (isInserting) {
      context.missing(_adultMeta);
    }
    if (data.containsKey('backdrop_path')) {
      context.handle(
          _backdropPathMeta,
          backdropPath.isAcceptableOrUnknown(
              data['backdrop_path']!, _backdropPathMeta));
    }
    if (data.containsKey('original_language')) {
      context.handle(
          _originalLanguageMeta,
          originalLanguage.isAcceptableOrUnknown(
              data['original_language']!, _originalLanguageMeta));
    } else if (isInserting) {
      context.missing(_originalLanguageMeta);
    }
    if (data.containsKey('original_title')) {
      context.handle(
          _originalTitleMeta,
          originalTitle.isAcceptableOrUnknown(
              data['original_title']!, _originalTitleMeta));
    } else if (isInserting) {
      context.missing(_originalTitleMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('vote_average')) {
      context.handle(
          _voteAverageMeta,
          voteAverage.isAcceptableOrUnknown(
              data['vote_average']!, _voteAverageMeta));
    } else if (isInserting) {
      context.missing(_voteAverageMeta);
    }
    if (data.containsKey('overview')) {
      context.handle(_overviewMeta,
          overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta));
    } else if (isInserting) {
      context.missing(_overviewMeta);
    }
    if (data.containsKey('release_date')) {
      context.handle(
          _releaseDateMeta,
          releaseDate.isAcceptableOrUnknown(
              data['release_date']!, _releaseDateMeta));
    } else if (isInserting) {
      context.missing(_releaseDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Movie map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Movie.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $MoviesTable createAlias(String alias) {
    return $MoviesTable(_db, alias);
  }
}

abstract class _$MovieFavoriteDB extends GeneratedDatabase {
  _$MovieFavoriteDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $MoviesTable movies = $MoviesTable(this);
  late final FavoriteDao favoriteDao = FavoriteDao(this as MovieFavoriteDB);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [movies];
}
