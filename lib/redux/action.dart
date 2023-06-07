import 'dart:convert';

import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../model/image_info.dart';
import 'app_state.dart';

class FetchImagesAction {
  final List<FlickrImageInfo> _images;
  final int _page;

  List<FlickrImageInfo> get images => _images;

  int get page => _page;

  FetchImagesAction(this._images, this._page);
}

class LikeAction {
  final FlickrImageInfo _image;

  FlickrImageInfo get image => _image;

  LikeAction(this._image);
}

AppState reducer(AppState prev, dynamic action) {
  if (action is FetchImagesAction) {
    return AppState(action.images, action.page);
  }
  if (action is LikeAction) {
    return _likeImage(prev, action);
  }
  return prev;
}

ThunkAction<AppState> fetchImages = (Store<AppState> store) async {
  try {
    print('LOAD DATA ${store.state.page}');
    final String key = "baad74872a87835b1b407a608d86058f";
    final String userId = "151794345@N05";
    final int pageSize = 10;
    Response response = await get(Uri.parse(
        'https://www.flickr.com/services/rest/?method=flickr.photos.getPopular&api_key=$key&format=json&user_id=$userId&page=${store.state.page.toString()}&per_page=${pageSize}'));
    var body = "";
    if (response.body.startsWith("jsonFlickrApi(")) {
      body = response.body.substring(14, response.body.length - 1);
    }
    Map data = jsonDecode(body);
    List _temp = data['photos']['photo'];
    var recipesFromSnapshot = FlickrImageInfo.recipesFromSnapshot(_temp);
    List<FlickrImageInfo> result = [];
    result.addAll(store.state.images);
    result.addAll(recipesFromSnapshot);
    store.dispatch(FetchImagesAction(result, store.state.page + 1));
  } catch (e) {
    print('caught error: $e');
    return;
  }
};

AppState _likeImage(AppState store, LikeAction action) {
  try {
    print('LIKE ${action.image.title}');
    var firstWhere = store.images.firstWhere((element) =>
        element.id == action.image.id &&
        element.server == action.image.server &&
        element.secret == action.image.secret);
    var indexOfSelectedImage = store.images.indexOf(firstWhere);
    List<FlickrImageInfo> copyImages = List.from(store.images);
    var copyWith =
        copyImages[indexOfSelectedImage].copyWith(firstWhere.countLike + 1);
    copyImages.setAll(indexOfSelectedImage, [copyWith]);
    return AppState(copyImages, store.page);
  } catch (e) {
    print('caught error: $e');
  }
  return AppState(store.images, store.page);
}
