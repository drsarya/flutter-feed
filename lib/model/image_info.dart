class FlickrImageInfo {
  final String title;
  final String id;
  final String server;
  final String secret;
  final int countLike;

  FlickrImageInfo(
      {required this.title,
      required this.id,
      required this.server,
      required this.secret,
      required this.countLike});

  factory FlickrImageInfo.fromJson(dynamic value) {
    return FlickrImageInfo(
      title: value['title'] as String,
      id: value['id'] as String,
      server: value['server'] as String,
      secret: value['secret'] as String,
      countLike: 0,
    );
  }

  FlickrImageInfo copyWith(int countLike) {
    return FlickrImageInfo(
      title: title,
      id: id,
      server: server,
      secret: secret,
      countLike: countLike,
    );
  }

  static List<FlickrImageInfo> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return FlickrImageInfo.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'FlickrImageInfo{title: $title, id: $id, server: $server, secret: $secret, countLike: $countLike}';
  }
}
