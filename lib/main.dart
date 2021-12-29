import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_sribuu_task/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:movie_sribuu_task/bloc/movie_bloc/movie_bloc.dart';
import 'package:movie_sribuu_task/bloc_observer.dart';
import 'package:movie_sribuu_task/data/localdb/favorite_dao.dart';
import 'package:movie_sribuu_task/data/localdb/favorite_db.dart';
import 'package:movie_sribuu_task/ui/movie_navigation.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieFavoriteDB db = MovieFavoriteDB();
    final FavoriteDao favoriteDao = FavoriteDao(db);

    return MultiBlocProvider(
      providers: [
        BlocProvider<FavoriteBloc>(
          create: (context) => FavoriteBloc(
            movieDao: favoriteDao,
          ),
        ),
        BlocProvider<MovieBloc>(
          create: (_) => MovieBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const MovieNavigation(),
      ),
    );
  }
}
