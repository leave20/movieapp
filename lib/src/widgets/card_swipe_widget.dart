import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movieapp/src/models/movie_models.dart';

class CardSwipe extends StatelessWidget {
  final List<Movie> movies;

  CardSwipe({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemCount: 10,
        itemHeight: _screenSize.height * 0.5,
        itemWidth: _screenSize.width * 0.7,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
                fit: BoxFit.cover,
              image: NetworkImage(
                  movies[index].getPostersImage()), placeholder: AssetImage('assets/img/1517731370_help_loader.gif'),),
          );
        },
        // pagination: SwiperPagination(),
        // control: SwiperControl(),
      ),
    );
  }
}
