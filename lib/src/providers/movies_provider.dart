import 'dart:async';
import 'dart:convert';

import 'package:movieapp/src/models/actors_models.dart';
import 'package:movieapp/src/models/movie_models.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apiKey = 'ba6731704f00c2a9f5bf100535964c2f';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  int _popularsPage = 0;
  bool _upload = false;

  List<Movie> _populars = [];
  final _popularsStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;

  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  void disposeStream() {
    _popularsStreamController?.close();
  }

  Future<List<Movie>> _buildResponse(Uri url) async {
    final resp = await http.get(url);

    // decodificamos la data que hay en nuestra variable
    final decodeData = json.decode(resp.body);

    final movies = new Movies.fromJsonList(decodeData['results']);
    // print(movies.items[3].title);

    return movies.items;
  }

  Future<List<Movie>> getMovieNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    // almacenamos la información del http en una variable
    // final resp = await http.get(url);
    //
    // // decodificamos la data que hay en nuestra variable
    // final decodeData = json.decode(resp.body);
    //
    // final movies = new Movies.fromJsonList(decodeData['results']);
    // // print(movies.items[3].title);
    //
    // return movies.items;
    return await _buildResponse(url);
  }

  Future<List<Movie>> getMoviePopulars() async {
    if (_upload) return [];

    _upload = true;

    _popularsPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularsPage.toString()
    });

    // almacenamos la información del http en una variable
    // final resp = await http.get(url);
    //
    // // decodificamos la data que hay en nuestra variable
    // final decodeData = json.decode(resp.body);
    //
    // final movies = new Movies.fromJsonList(decodeData['results']);
    // // print(movies.items[3].title);
    //
    // return movies.items;

    final resp = await _buildResponse(url);

    _populars.addAll(resp);
    popularsSink(_populars);

    _upload = false;

    return resp;
  }

  Future<List<Actor>> getCast(String movieId) async{
    final url=Uri.https(_url, '3/movie/$movieId/credits',{
      'api_key':_apiKey,
      'languages':_language
    });

    final  resp=await http.get(url);
    final decodedData=json.decode(resp.body);

    final cast =new Cast.fromJsonList(decodedData['cast']);

    return cast.actors;
  }

  Future<List<Movie>> searchMovie(String query) async{

    final url=Uri.https(_url, '3/search/movie',{
      'api_key':_apiKey,
      'language':_language,
      'query':query
    });

    return await _buildResponse(url);
  }
}
