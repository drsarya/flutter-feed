import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../model/image_info.dart';
import '../redux/action.dart';
import '../redux/app_state.dart';

class FlickrFullImageCard extends StatelessWidget {
  final FlickrImageInfo imageCard;

  FlickrFullImageCard({
    required this.imageCard,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      // first child
      SizedBox(
        width: 500,
        child: Image.network(
          "https://live.staticflickr.com/${imageCard.server}/${imageCard.id}_${imageCard.secret}.jpg",
          fit: BoxFit.fitWidth,
        ),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {
              var store = StoreProvider.of<AppState>(context);
              store.dispatch(LikeAction(imageCard));
              store.dispatch(likeImage);
            },
            child: const Icon(
              Icons.favorite,
              color: Colors.redAccent,
              size: 24.0,
            )),
        SizedBox(width: 10),
        Text(
          imageCard.countLike == 0 ? "" : imageCard.countLike.toString(),
          style: const TextStyle(color: Colors.black54, fontSize: 18.0),
        )
      ]),
      Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.topLeft,
          child: Text(
            imageCard.title,
            style: const TextStyle(color: Colors.black, fontSize: 18.0),
          )),
    ]));
  }
}
