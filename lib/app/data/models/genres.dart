class Genres {
  Genres({
    required this.message,
    required this.page,
    required this.pagination,
    required this.datas,
  });

  final String? message;
  final int? page;
  final int? pagination;
  final List<GenreList> datas;

  factory Genres.fromJson(Map<String, dynamic> json) {
    return Genres(
      message: json["message"],
      page: json["page"],
      pagination: json["pagination"],
      datas: json["datas"] == null
          ? []
          : List<GenreList>.from(
              json["datas"]!.map((x) => GenreList.fromJson(x))),
    );
  }
}

class GenreList {
  GenreList({
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

  factory GenreList.fromJson(Map<String, dynamic> json) {
    return GenreList(
      title: json["title"],
      thumbnail: json["thumbnail"],
      newestChapter: json["newest_chapter"],
      rating: json["rating"],
      endpoint: json["endpoint"],
      type: json["type"],
    );
  }
}
