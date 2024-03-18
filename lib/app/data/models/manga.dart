class Manga {
  Manga({
    required this.message,
    required this.page,
    required this.pagination,
    required this.datas,
  });

  final String? message;
  final int? page;
  final dynamic pagination;
  final List<MangaList> datas;

  factory Manga.fromJson(Map<String, dynamic> json) {
    return Manga(
      message: json["message"],
      page: json["page"],
      pagination: json["pagination"],
      datas: json["datas"] == null
          ? []
          : List<MangaList>.from(
              json["datas"]!.map((x) => MangaList.fromJson(x))),
    );
  }
}

class MangaList {
  MangaList({
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

  factory MangaList.fromJson(Map<String, dynamic> json) {
    return MangaList(
      title: json["title"],
      thumbnail: json["thumbnail"],
      newestChapter: json["newest_chapter"],
      rating: json["rating"],
      endpoint: json["endpoint"],
      type: json["type"],
    );
  }
}
