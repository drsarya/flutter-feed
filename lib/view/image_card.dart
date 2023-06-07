import 'package:flutter/material.dart';
import 'package:flutter_feed/resources/colors.dart';
import 'package:flutter_feed/resources/dimens.dart';
import 'package:flutter_feed/resources/styles.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../model/image_info.dart';
import '../redux/action.dart';
import '../redux/app_state.dart';

class FlickrImageCard extends StatelessWidget {
  final FlickrImageInfo imageCard;

  FlickrImageCard({
    required this.imageCard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black38)),
        child: Column(children: [
          // first child
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: UIDimentions.smallImageHeight,
            child: Image.network(
              "https://live.staticflickr.com/${imageCard.server}/${imageCard.id}_${imageCard.secret}.jpg",
              fit: BoxFit.cover,
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
              //second child
              margin: UIDimentions.defaultPadding,
              alignment: Alignment.topLeft,
              child: Text(
                imageCard.title,
                style: UIStyles.text_style(Colors.black),
              )),
        ]));
  }
}
