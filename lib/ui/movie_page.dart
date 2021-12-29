import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_sribuu_task/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:movie_sribuu_task/bloc/movie_bloc/movie_bloc.dart';
import 'package:movie_sribuu_task/data/localdb/favorite_db.dart';
import 'package:movie_sribuu_task/model/movie_model.dart';
import 'package:movie_sribuu_task/ui/movie_detail_page.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ListMovie(),
    );
  }
}

class ListMovie extends StatefulWidget {
  const ListMovie({Key? key}) : super(key: key);

  @override
  State<ListMovie> createState() => _ListMovieState();
}

class _ListMovieState extends State<ListMovie>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();
  bool isChangeView = false;

  FavoriteBloc? favoriteBloc;

  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(MovieFetched());
    _scrollController.addListener(_onScroll);
    favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    favoriteBloc!.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _onRefresh() async {
    context.read<MovieBloc>().add(MovieRefresh());
    context.read<MovieBloc>().add(MovieFetched());
  }

  void _changeView() {
    setState(() {
      isChangeView = !isChangeView;
    });
  }

  void _onScroll() {
    if (_isBottom) context.read<MovieBloc>().add(MovieFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
        actions: [
          IconButton(
            onPressed: _changeView,
            icon: Icon(
              isChangeView ? Icons.grid_view : Icons.list_alt,
              size: 24,
            ),
          )
        ],
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          switch (state.status) {
            case MovieStatus.failure:
              return const Center(child: Text('failed to fetch movies'));
            case MovieStatus.success:
              if (state.movies.isEmpty) {
                return const Center(child: Text('no movies'));
              }
              return isChangeView
                  ? RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        itemBuilder: (context, index) {
                          return index >= state.movies.length
                              ? const BottomLoader()
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailMoviePage(
                                          movie: state.movies[index],
                                          prevcontext: context,
                                        ),
                                      ),
                                    );
                                  },
                                  child: _buildMovieList(
                                      movie: state.movies[index]));
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 30,
                          );
                        },
                        itemCount: state.hasReachedMax
                            ? state.movies.length
                            : state.movies.length + 1,
                        controller: _scrollController,
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        controller: _scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3 / 5,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: state.hasReachedMax
                            ? state.movies.length
                            : state.movies.length + 1,
                        itemBuilder: (BuildContext ctx, index) {
                          return index >= state.movies.length
                              ? Container()
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailMoviePage(
                                          movie: state.movies[index],
                                          prevcontext: context,
                                        ),
                                      ),
                                    );
                                  },
                                  child: _buildMovieGrid(
                                      movie: state.movies[index]),
                                );
                        },
                      ),
                    );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildMovieList({required MovieModel movie}) {
    return Row(
      children: [
        movie.posterPath != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "http://image.tmdb.org/t/p/w185" + movie.posterPath!,
                  height: 120,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              )
            : Container(
                height: 120,
                width: 100,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.originalTitle!,
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
                movie.overview!,
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
                movie.releaseDate!.length > 3
                    ? movie.releaseDate!.substring(0, 4)
                    : movie.releaseDate!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  _buildfavoriteButton(movie),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: const Icon(
                      Icons.thumb_up_alt,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: const Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
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
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                  ),
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: Colors.red,
                  size: 15,
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
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: const Icon(
                Icons.favorite_rounded,
                color: Colors.white,
                size: 15,
              ),
            ),
          );
        });
  }

  Widget _buildMovieGrid({required MovieModel movie}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        movie.backdropPath != null
            ? Container(
                height: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(
                      "http://image.tmdb.org/t/p/w500" + movie.backdropPath!,
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
              )
            : Container(
                height: 120,
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
              ),
        Row(
          children: [
            _buildfavoriteButton(movie),
            const SizedBox(
              width: 8,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: const Icon(
                Icons.thumb_up_alt,
                color: Colors.white,
                size: 15,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: const Icon(
                Icons.share,
                color: Colors.white,
                size: 15,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          movie.title!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          movie.overview!,
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
          movie.releaseDate!.length > 3
              ? movie.releaseDate!.substring(0, 4)
              : movie.releaseDate!,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(strokeWidth: 1.5),
        ),
      ),
    );
  }
}
