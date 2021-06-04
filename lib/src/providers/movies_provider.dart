import 'dart:convert';

import 'package:movieapp/src/models/movie_models.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apiKey = 'ba6731704f00c2a9f5bf100535964c2f';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  Future<List<Movie>> getMovieNowPlaying() async {
    final url = Uri.https(_url,'3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    // almacenamos la información del http en una variable
    final resp = await http.get(url);

    // decodificamos la data que hay en nuestra variable
    final decodeData = json.decode(resp.body);

final movies=new Movies.fromJsonList(decodeData['results']);
    // print(movies.items[3].title);

    return movies.items;
  }
}
