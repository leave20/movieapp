import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/src/models/actors_models.dart';
import 'package:movieapp/src/models/movie_models.dart';
import 'package:movieapp/src/providers/movies_provider.dart';

class DetailMovie extends StatelessWidget {
  // const DetailMovie({Key? key}) : super(key: key);

  // DetailMovie(Movie movie);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Movie Details'),
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10.0),
              _posterTitle(context, movie),
              _description(movie),
              _description(movie),
              _description(movie),
              _description(movie),
              _description(movie),
              _castingCreate(movie),
            ]),
          )
        ],
      ),
    );
  }

  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 300.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
          overflow: TextOverflow.ellipsis,
        ),
        background: FadeInImage(
          image: NetworkImage(movie.getPostersImage()),
          placeholder: AssetImage('assets/img/1517731370_help_loader.gif'),
          fadeInDuration: Duration(microseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitle(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(movie.getPostersImage()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                movie.title,
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.ellipsis,
              ),
              Text(movie.originalTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis),
              Row(
                children: <Widget>[
                  Icon(Icons.star_border),
                  Text(
                    movie.voteAverage.toString(),
                    style: Theme.of(context).textTheme.subtitle2,
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _description(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _castingCreate(Movie movie) {
    final movieProvider = new MoviesProvider();
    return FutureBuilder(
        future: movieProvider.getCast(movie.id.toString()),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return _actorsCreatePageView(snapshot.data);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _actorsCreatePageView(List<Actor> actors) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemCount: actors.length,
        itemBuilder: (context, i) {
          // return Text('Hello');
          return _cardActors(actors[i]);
        },
      ),
    );
  }

  Widget _cardActors(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
                image: NetworkImage(actor.getPhoto()),
                placeholder: AssetImage('assets/img/1517731370_help_loader.gif'),
            height: 150.0,
            fit: BoxFit.cover,),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
