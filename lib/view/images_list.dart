import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../redux/action.dart';
import '../redux/app_state.dart';
import '../resources/dimens.dart';
import '../resources/text.dart';
import 'image_card.dart';
import 'image_full_card.dart';

class ImagesListPage extends StatefulWidget {
  @override
  ImagesListState createState() => ImagesListState();
}

class ImagesListState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(UIText.title),
        ),
        body: Center(
            child: SizedBox(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
              Expanded(
                child: StoreConnector<AppState, AppState>(
                  converter: (store) => store.state,
                  builder: (_, state) {
                    var store = StoreProvider.of<AppState>(context);
                    if (state.images.isEmpty) {
                      store.dispatch(fetchImages);
                    }
                    return GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: state.images.length,
                      itemBuilder: (context, index) {
                        if (index == state.images.length - 1) {
                          store.dispatch(fetchImages);
                        }
                        return GestureDetector(
                          child: FlickrImageCard(
                            imageCard: state.images[index],
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return StoreConnector<AppState, AppState>(
                                  converter: (store) => store.state,
                                  builder: (_, state) {
                                    return FlickrFullImageCard(
                                      imageCard: state.images[index],
                                    );
                                  });
                            }));
                          },
                        );
                      },
                      gridDelegate: UIDimentions.gridPadding,
                    );
                  },
                ),
              )
            ]))));
    //
  }
}
