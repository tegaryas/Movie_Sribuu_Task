import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_sribuu_task/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:movie_sribuu_task/data/localdb/favorite_db.dart';
import 'package:movie_sribuu_task/model/movie_model.dart';
import 'package:movie_sribuu_task/ui/movie_detail_page.dart';

class MovieFavoritePage extends StatefulWidget {
  const MovieFavoritePage({Key? key}) : super(key: key);

  @override
  State<MovieFavoritePage> createState() => _MovieFavoritePageState();
}

class _MovieFavoritePageState extends State<MovieFavoritePage> {
  FavoriteBloc? favoriteBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    favoriteBloc!.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 20,
          ),
          child: Image.network(
            "http://image.tmdb.org/t/p/w92/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: favoriteBloc!.watchAllMovies(),
        builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
          // ignore: prefer_is_empty
          return snapshot.data?.length == 0
              ? const Center(
                  child: Text(
                    'Favorite Is Empty',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(snapshot.data![index].id.toString()),
                      onDismissed: (direction) {
                        context
                            .read<FavoriteBloc>()
                            .removeMovie(snapshot.data![index]);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(
                              milliseconds: 500,
                            ),
                            content: Text("Movie Remove from Favorite"),
                          ),
                        );
                      },
                      child: _buildMovieList(
                        movie: snapshot.data![index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 30,
                    );
                  },
                  itemCount: snapshot.data?.length ?? 0,
                );
        },
      ),
    );
  }

  Widget _buildMovieList({required Movie movie}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailMoviePage(
              movie: MovieModel(
                id: movie.id,
                backdropPath: movie.backdropPath,
                posterPath: movie.posterPath,
                popularity: movie.popularity.toDouble(),
                releaseDate: movie.releaseDate,
                title: movie.title,
                overview: movie.overview,
                adult: movie.adult,
                voteAverage: movie.voteAverage.toDouble(),
                originalLanguage: movie.originalLanguage,
                originalTitle: movie.originalTitle,
                video: movie.video,
                voteCount: movie.voteCount.toDouble(),
              ),
              prevcontext: context,
            ),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          movie.posterPath != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "http://image.tmdb.org/t/p/w185" + movie.posterPath!,
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.not_interested,
                    ),
                  ),
                ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.originalTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  movie.overview,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  movie.releaseDate.length > 3
                      ? movie.releaseDate.substring(0, 4)
                      : movie.releaseDate,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
