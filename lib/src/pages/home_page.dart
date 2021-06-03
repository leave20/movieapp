import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatelessWidget {
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
    return Container(
      width: double.infinity,
      height: 300.0,
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemCount: 5,
        itemWidth: 300.0,
        itemBuilder: (BuildContext context, int index) {
          return Image.network("https://startech-rd.io/content/images/size/w2000/2020/03/Flutter-1-1-1.png",
              fit: BoxFit.fill);
        },
        pagination: SwiperPagination(),
        // control: SwiperControl(),
      ),
    );
  }
}
