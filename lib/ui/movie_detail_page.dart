import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_sribuu_task/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:movie_sribuu_task/bloc/movie_bloc/movie_bloc.dart';
import 'package:movie_sribuu_task/data/localdb/favorite_db.dart';
import 'package:movie_sribuu_task/model/movie_model.dart';

class DetailMoviePage extends StatefulWidget {
  final MovieModel movie;
  final BuildContext prevcontext;
  final bool? fromFavorite;
  const DetailMoviePage({
    Key? key,
    required this.movie,
    required this.prevcontext,
    this.fromFavorite = false,
  }) : super(key: key);

  @override
  State<DetailMoviePage> createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  FavoriteBloc? favoriteBloc;

  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(MovieFetched());

    favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
  }

  @override
  void dispose() {
    favoriteBloc!.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              widget.movie.posterPath != null
                  ? _buildImageMovie(widget.movie)
                  : _buildImageMovieNull(context),
              _buildMovieInfo(widget.movie),
            ],
          ),
        ));
  }

  Widget _buildImageMovieNull(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      decoration: const BoxDecoration(
        color: Colors.grey,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Colors.transparent,
            Colors.transparent,
            Colors.black,
          ],
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.not_interested,
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }

  Widget _buildMovieInfo(MovieModel detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            detail.title ?? "",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                '${detail.voteAverage!.toInt() * 10}% match',
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                detail.releaseDate!.length > 3
                    ? detail.releaseDate!.substring(0, 4)
                    : detail.releaseDate!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 1,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Center(
                  child: Text(
                    detail.adult == true ? "R18" : "PG",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 1,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const Center(
                  child: Text(
                    "HD",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Popularity: " + detail.popularity.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            detail.overview!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildfavoriteButton(detail),
              SizedBox(
                width: 80,
                child: Column(
                  children: const [
                    Icon(
                      Icons.thumb_up_alt,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Rated',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: SizedBox(
                  width: 80,
                  child: Column(
                    children: const [
                      Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Share',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget _buildfavoriteButton(MovieModel movie) {
    return StreamBuilder<Object>(
        stream: favoriteBloc!.checkAlready(movie.id!),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return GestureDetector(
              onTap: () {
                context.read<FavoriteBloc>().removeMovie(
                      Movie(
                        id: movie.id!,
                        popularity: movie.popularity!.toInt(),
                        voteCount: movie.voteCount!.toInt(),
                        video: movie.video!,
                        idMovie: movie.id!.toString(),
                        adult: movie.adult!,
                        originalLanguage: movie.originalLanguage!,
                        originalTitle: movie.originalTitle!,
                        voteAverage: movie.voteAverage!.toInt(),
                        overview: movie.overview!,
                        releaseDate: movie.releaseDate!,
                        posterPath: movie.posterPath,
                        backdropPath: movie.backdropPath,
                        title: movie.title,
                      ),
                    );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(
                      milliseconds: 500,
                    ),
                    content: Text("Movie Remove From Favorite"),
                  ),
                );
              },
              child: SizedBox(
                width: 80,
                child: Column(
                  children: const [
                    Icon(
                      Icons.favorite_rounded,
                      color: Colors.red,
                      size: 28,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Favorite',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return GestureDetector(
            onTap: () {
              context.read<FavoriteBloc>().addMovie(
                    Movie(
                      id: movie.id!,
                      popularity: movie.popularity!.toInt(),
                      voteCount: movie.voteCount!.toInt(),
                      video: movie.video!,
                      idMovie: movie.id!.toString(),
                      adult: movie.adult!,
                      originalLanguage: movie.originalLanguage!,
                      originalTitle: movie.originalTitle!,
                      voteAverage: movie.voteAverage!.toInt(),
                      overview: movie.overview!,
                      releaseDate: movie.releaseDate!,
                      posterPath: movie.posterPath,
                      backdropPath: movie.backdropPath,
                      title: movie.title,
                    ),
                  );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(
                    milliseconds: 500,
                  ),
                  content: Text("Movie Add To Favorite"),
                ),
              );
            },
            child: SizedBox(
              width: 80,
              child: Column(
                children: const [
                  Icon(
                    Icons.favorite_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Favorite',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  _buildImageMovie(MovieModel movie) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "http://image.tmdb.org/t/p/w500" + movie.posterPath!,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Colors.transparent,
              Colors.transparent,
              Colors.black,
            ],
          ),
        ),
      ),
    );
  }
}
