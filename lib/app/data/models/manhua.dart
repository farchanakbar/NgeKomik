class Manhua {
  Manhua({
    required this.message,
    required this.page,
    required this.pagination,
    required this.datas,
  });

  final String? message;
  final int? page;
  final int? pagination;
  final List<ManhuaList> datas;

  factory Manhua.fromJson(Map<String, dynamic> json) {
    return Manhua(
      message: json["message"],
      page: json["page"],
      pagination: json["pagination"],
      datas: json["datas"] == null
          ? []
          : List<ManhuaList>.from(
              json["datas"]!.map((x) => ManhuaList.fromJson(x))),
    );
  }
}

class ManhuaList {
  ManhuaList({
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

  factory ManhuaList.fromJson(Map<String, dynamic> json) {
    return ManhuaList(
      title: json["title"],
      thumbnail: json["thumbnail"],
      newestChapter: json["newest_chapter"],
      rating: json["rating"],
      endpoint: json["endpoint"],
      type: json["type"],
    );
  }
}
