import 'package:feed/model/image_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../redux/action.dart';
import '../redux/app_state.dart';

class FlickrFullImageCard extends StatelessWidget {
  final FlickrImageInfo imageCard;

  FlickrFullImageCard({
    required this.imageCard,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
      // first child
      Container(
        margin: const EdgeInsets.all(5),
        alignment: Alignment.center,
        child: Image.network(
            "https://live.staticflickr.com/${imageCard.server}/${imageCard.id}_${imageCard.secret}.jpg",
            fit: BoxFit.fitWidth),
      ),
      Container(
          height: 30,
          //second child
          margin: const EdgeInsets.all(5),
          alignment: Alignment.center,
          child: Text(
            imageCard.title,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22.0),
          )),

      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          imageCard.countLike.toString(),
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22.0),
        ),
        ElevatedButton(
            onPressed: () {
              var store = StoreProvider.of<AppState>(context);
              store.dispatch(LikeAction(imageCard));
              store.dispatch(likeImage);
            },
            child: const Icon(
              Icons.favorite,
              color: Colors.pink,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ))
      ])
    ]);
  }
}
