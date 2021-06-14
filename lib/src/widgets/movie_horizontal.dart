import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/src/models/movie_models.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;
  Function nextPage;

  MovieHorizontal({@required this.movies, @required this.nextPage});

  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _cards(),
        itemCount: movies.length,
        itemBuilder: (context,i){
          return _card(context, movies[i]);
        },
      ),
    );
  }

  Widget _card(BuildContext context,Movie movie){

    return Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder:
                AssetImage('assets/img/1517731370_help_loader.gif'),
                image: NetworkImage(movie.getPostersImage()),
                fit: BoxFit.cover,
                height: 160.0,
              )),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  List<Widget> _cards() {
    return movies.map((movie) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder:
                      AssetImage('assets/img/1517731370_help_loader.gif'),
                  image: NetworkImage(movie.getPostersImage()),
                  fit: BoxFit.cover,
                  height: 160.0,
                )),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      );
    }).toList();
  }
}
