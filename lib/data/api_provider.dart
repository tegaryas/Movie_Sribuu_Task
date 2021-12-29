import 'package:dio/dio.dart';
import 'package:movie_sribuu_task/model/movie_model.dart';

class ApiProvider {
  Dio dio = Dio();

  final baseUrl = "https://api.themoviedb.org/3";
  final apiKey = "73df602186fec3d2c2eb7878df8338b5";

  Future<List<MovieModel>> getSearchMovies(String? query, int? page) async {
    try {
      Response response = await dio
          .get('$baseUrl/search/movie?api_key=$apiKey&query=$query&page=$page');
      return response.data['results']
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
