import 'package:flutter/material.dart';
import 'package:movieapp/src/models/movie_models.dart';
import 'package:movieapp/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {
  final movies = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam',
    'Ironman',
    'Captain America'
  ];

  final recentMovies = ['Spiderman', 'Captain America'];

  final movieProvider = new MoviesProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Accions appBar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon leaf appBar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show response
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
        future: movieProvider.searchMovie(query),
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasData) {
            final movies = snapshot.data;

            return ListView(children: movies.map((movie) =>
                ListTile(
                  leading: FadeInImage(
                    placeholder: AssetImage(
                        'assets/img/1517731370_help_loader.gif'),
                    image: NetworkImage(movie.getPostersImage()),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    movie.title,
                    overflow: TextOverflow.ellipsis,),
                  subtitle: Text(
                      movie.originalTitle,
                      overflow: TextOverflow.ellipsis),
                  onTap: () {
                    close(context, null);
                    movie.uniqueId = '';
                    Navigator.pushNamed(context, 'detail', arguments: movie);
                  },
                )).toList());
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
    //
    //   final suggestList = (query.isEmpty)
    //       ? recentMovies
    //       : movies
    //           .where((element) =>
    //               element.toLowerCase().startsWith(query.toLowerCase()))
    //           .toList();
    //
    //   // Search suggestion
    //   return ListView.builder(
    //       itemCount: suggestList.length,
    //       itemBuilder: (context, i) {
    //         return ListTile(
    //           leading: Icon(Icons.movie),
    //           title: Text(suggestList[i]),
    //           onTap: () {},
    //         );
    //       });
  }
}
