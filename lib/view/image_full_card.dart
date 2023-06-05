import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../model/image_info.dart';
import '../redux/action.dart';
import '../redux/app_state.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/styles.dart';

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
        width: UIDimentions.fullImageHeight,
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
            },
            child: const Icon(
              Icons.favorite,
              color: UIColors.colorLikeIcon,
              size: UIDimentions.likeIconSize,
            )),
        const SizedBox(width: 10),
        Text(
          imageCard.countLike == 0 ? "" : imageCard.countLike.toString(),
          style: UIStyles.text_style(UIColors.counterTextColor),
        )
      ]),
      Container(
          margin: UIDimentions.defaultPadding,
          alignment: Alignment.topLeft,
          child: Text(
            imageCard.title,
            style: const TextStyle(color: Colors.black, fontSize: 18.0),
          )),
    ]));
  }
}
