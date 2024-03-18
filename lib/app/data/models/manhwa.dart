class Manhwa {
  Manhwa({
    required this.message,
    required this.page,
    required this.pagination,
    required this.datas,
  });

  final String? message;
  final int? page;
  final int? pagination;
  final List<ManhwaList> datas;

  factory Manhwa.fromJson(Map<String, dynamic> json) {
    return Manhwa(
      message: json["message"],
      page: json["page"],
      pagination: json["pagination"],
      datas: json["datas"] == null
          ? []
          : List<ManhwaList>.from(
              json["datas"]!.map((x) => ManhwaList.fromJson(x))),
    );
  }
}

class ManhwaList {
  ManhwaList({
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

  factory ManhwaList.fromJson(Map<String, dynamic> json) {
    return ManhwaList(
      title: json["title"],
      thumbnail: json["thumbnail"],
      newestChapter: json["newest_chapter"],
      rating: json["rating"],
      endpoint: json["endpoint"],
      type: json["type"],
    );
  }
}
