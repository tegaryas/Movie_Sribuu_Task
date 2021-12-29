import 'package:movie_sribuu_task/data/api_provider.dart';
import 'package:movie_sribuu_task/model/movie_model.dart';

class MovieRepository {
  ApiProvider apiProvider = ApiProvider();

  Future<List<MovieModel>> getSearchMovies(String? query, int? page) =>
      apiProvider.getSearchMovies(query, page);
}
