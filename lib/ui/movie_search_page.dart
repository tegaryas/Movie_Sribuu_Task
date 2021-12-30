import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_sribuu_task/bloc/search_bloc/search_cubit.dart';
import 'package:movie_sribuu_task/model/movie_model.dart';
import 'package:movie_sribuu_task/ui/movie_detail_page.dart';

class MovieSearchPage extends StatefulWidget {
  const MovieSearchPage({Key? key}) : super(key: key);

  @override
  State<MovieSearchPage> createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  final TextEditingController _searchTextController = TextEditingController();
  @override
  void initState() {
    context.read<SearchCubit>().reset();
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  void _onPressClear() {
    _searchTextController.clear();
    context.read<SearchCubit>().reset();
  }

  void _getSearchMovies(String query) {
    context.read<SearchCubit>().onSearchMovie(query);
  }

  void _onPressMovie(MovieModel? movie) {
    if (movie != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailMoviePage(
            movie: movie,
            prevcontext: context,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        title: _buildSearchField(),
        actions: [
          IconButton(
            onPressed: _onPressClear,
            icon: const Icon(
              Icons.close,
              size: 24,
            ),
          ),
        ],
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white,
                  ),
                ),
              ),
            );
          } else if (state is SearchLoaded) {
            return _buildSearchList(state);
          } else if (state is SearchInitial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    "https://www.freepnglogos.com/uploads/netflix-logo-circle-png-5.png",
                    height: 200,
                    fit: BoxFit.fitHeight,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: Text(
                      'Silahkan Cari Film Yang Anda Mau',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text(
                "Search Failed",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildSearchList(SearchLoaded state) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 20,
      ),
      itemBuilder: (context, index) {
        final movie = state.movies[index];
        return GestureDetector(
          onTap: () {
            _onPressMovie(movie);
          },
          child: Container(
            color: Colors.black,
            child: Row(
              children: [
                movie.backdropPath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          "http://image.tmdb.org/t/p/w185" +
                              movie.backdropPath!,
                          height: 60,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        height: 60,
                        width: 50,
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
                        movie.title!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        movie.releaseDate!.length > 3
                            ? movie.releaseDate!.substring(0, 4)
                            : movie.releaseDate!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 25,
        );
      },
      itemCount: state.movies.length,
    );
  }

  _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        hintText: "Search Movie",
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
      onChanged: (query) {
        _getSearchMovies(query);
      },
    );
  }
}
