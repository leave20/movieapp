import 'package:flutter/material.dart';
import 'package:movieapp/src/providers/movies_provider.dart';
import 'package:movieapp/src/widgets/card_swipe_widget.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Movies'),
          backgroundColor: Colors.black54,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ]),
      body: Container(
        child: Column(
          children: <Widget>[
            _swipperCards(),
          ],
        ),
      ),
    );
  }

  //Agregamos el swipper a la vista

  Widget _swipperCards() {
    moviesProvider.getMovieNowPlaying();

    return FutureBuilder(
      future: moviesProvider.getMovieNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return CardSwipe(movies: snapshot.data);
        } else {
          return Container(
              height: 400.0,
              child: Center(
                  child: CircularProgressIndicator()));
        }
      },
    );
  }
}
