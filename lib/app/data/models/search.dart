class Genres {
  Genres({
    required this.message,
    required this.pagination,
    required this.datas,
  });

  final String? message;
  final int? pagination;
  final List<Data> datas;

  factory Genres.fromJson(Map<String, dynamic> json) {
    return Genres(
      message: json["message"],
      pagination: json["pagination"],
      datas: json["datas"] == null
          ? []
          : List<Data>.from(json["datas"]!.map((x) => Data.fromJson(x))),
    );
  }
}

class Data {
  Data({
    required this.title,
    required this.thumbnail,
    required this.newestChapter,
    required this.rating,
    required this.endpoint,
    required this.type,
  });

  final String? title;
  final String? thumbnail;
  final String? newestChapter;
  final String? rating;
  final String? endpoint;
  final String? type;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      title: json["title"],
      thumbnail: json["thumbnail"],
      newestChapter: json["newest_chapter"],
      rating: json["rating"],
      endpoint: json["endpoint"],
      type: json["type"],
    );
  }
}
