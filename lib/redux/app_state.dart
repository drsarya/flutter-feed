import '../model/image_info.dart';

class AppState {
  final List<FlickrImageInfo> _images;
  final int _page;

  List<FlickrImageInfo> get images => _images;

  int get page => _page;

  AppState(this._images, this._page);

  AppState.initialState()
      : _images = List.empty(),
        _page = 1;
}
