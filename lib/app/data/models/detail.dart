class Detail {
  Detail({
    required this.title,
    required this.rating,
    required this.endpoint,
    required this.titleAlt,
    required this.description,
    required this.thumbnail,
    required this.status,
    required this.type,
    required this.released,
    required this.updatedAt,
    required this.genres,
    required this.related,
    required this.chapterList,
  });

  final String? title;
  final String? rating;
  final String? endpoint;
  final String? titleAlt;
  final String? description;
  final String? thumbnail;
  final String? status;
  final String? type;
  final String? released;
  final String? updatedAt;
  final List<Genre> genres;
  final List<Related> related;
  final List<ChapterList> chapterList;

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      title: json["title"],
      rating: json["rating"],
      endpoint: json["endpoint"],
      titleAlt: json["title_alt"],
      description: json["description"],
      thumbnail: json["thumbnail"],
      status: json["status"],
      type: json["type"],
      released: json["released"],
      updatedAt: json["updated_at"],
      genres: json["genres"] == null
          ? []
          : List<Genre>.from(json["genres"]!.map((x) => Genre.fromJson(x))),
      related: json["related"] == null
          ? []
          : List<Related>.from(
              json["related"]!.map((x) => Related.fromJson(x))),
      chapterList: json["chapterList"] == null
          ? []
          : List<ChapterList>.from(
              json["chapterList"]!.map((x) => ChapterList.fromJson(x))),
    );
  }
}

class ChapterList {
  ChapterList({
    required this.title,
    required this.updatedAt,
    required this.endpoint,
  });

  final String? title;
  final String? updatedAt;
  final String? endpoint;

  factory ChapterList.fromJson(Map<String, dynamic> json) {
    return ChapterList(
      title: json["title"],
      updatedAt: json["updated_at"],
      endpoint: json["endpoint"],
    );
  }
}

class Genre {
  Genre({
    required this.title,
    required this.endpoint,
  });

  final String? title;
  final String? endpoint;

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      title: json["title"],
      endpoint: json["endpoint"],
    );
  }
}

class Related {
  Related({
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

  factory Related.fromJson(Map<String, dynamic> json) {
    return Related(
      title: json["title"],
      thumbnail: json["thumbnail"],
      newestChapter: json["newest_chapter"],
      rating: json["rating"],
      endpoint: json["endpoint"],
      type: json["type"],
    );
  }
}
