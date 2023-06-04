import '../model/image_info.dart';

class AppState {
  final List<FlickrImageInfo> _images;
  final int _page;
  final FlickrImageInfo _selectedImage;

  List<FlickrImageInfo> get images => _images;

  FlickrImageInfo get selectedImage => _selectedImage;

  int get page => _page;

  AppState(this._images, this._page, this._selectedImage);

  AppState.initialState()
      : _images = List.empty(),
        _page = 1,
        _selectedImage = FlickrImageInfo(
            title: "", id: "", server: "", secret: "", countLike: 0);
}
