import 'package:flutter/material.dart';
import 'package:movieapp/src/providers/movies_provider.dart';
import 'package:movieapp/src/widgets/card_swipe_widget.dart';
import 'package:movieapp/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {

    moviesProvider.getMoviePopulars();

    return Scaffold(
      appBar: AppBar(
          title: Text('Movies'),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ]),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Theme.of(context).accentColor)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swipperCards(),
            _footer(context),
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
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
              child: Text('Populars',
                  style: Theme.of(context).textTheme.subtitle1)),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: moviesProvider.popularsStream,

            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(movies: snapshot.data,nextPage: moviesProvider.getMoviePopulars);
              } else {
                return Center(child: CircularProgressIndicator());
              }

              // snapshot.data?.forEach((p)=>print(p.title));
              // return Container();
            },
          ),
        ],
      ),
    );
  }
}
