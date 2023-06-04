import 'dart:convert';

import 'package:feed/model/image_info.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'app_state.dart';

class FetchTimeAction {
  final List<FlickrImageInfo> _images;
  final int _page;

  List<FlickrImageInfo> get images => _images;

  int get page => _page;

  FetchTimeAction(this._images, this._page);
}

class LikeAction {
  final FlickrImageInfo _card;

  FlickrImageInfo get card => _card;

  LikeAction(this._card);
}

AppState reducer(AppState prev, dynamic action) {
  if (action is FetchTimeAction) {
    return AppState(action._images, action._page, prev.selectedImage);
  }
  if (action is LikeAction) {
    return AppState(prev.images, prev.page, action.card);
  }
  return prev;
}

ThunkAction<AppState> fetchImages = (Store<AppState> store) async {
  try {
    print('LOAD DATA ' + store.state.page.toString());
    final String key = "baad74872a87835b1b407a608d86058f";
    final String userId = "151794345@N05";
    Response response = await get(Uri.parse(
        'https://www.flickr.com/services/rest/?method=flickr.photos.getPopular&api_key=' +
            key +
            '&format=json&user_id=' +
            userId +
            "&page=" +
            store.state.page.toString() +"&per_page=40"));
    var substring = "";
    if (response.body.startsWith("jsonFlickrApi(")) {
      substring = response.body.substring(14, response.body.length - 1);
    }
    Map data = jsonDecode(substring);
    List _temp = data['photos']['photo'];
    var recipesFromSnapshot = FlickrImageInfo.recipesFromSnapshot(_temp);
    List<FlickrImageInfo> result = [];
    result.addAll(store.state.images);
    result.addAll(recipesFromSnapshot);
    store.dispatch(FetchTimeAction(result, store.state.page + 1));
  } catch (e) {
    print('caught error: $e');
    return;
  }
};

ThunkAction<AppState> likeImage = (Store<AppState> store) {
  try {
    if (store.state.selectedImage == null) {
      return;
    }
    print('Like image');
    var firstWhere = store.state.images.firstWhere((element) =>
        element.id == store.state.selectedImage.id &&
        element.server == store.state.selectedImage.server &&
        element.secret == store.state.selectedImage.secret);
    var indexOf = store.state.images.indexOf(firstWhere);

    var copyWith =
        store.state.images[indexOf].copyWith(firstWhere.countLike + 1);
    store.state.images.setAll(indexOf, [copyWith]);
    store.dispatch(FetchTimeAction(store.state.images, store.state.page));
  } catch (e) {
    print('caught error: $e');
    return;
  }
};
