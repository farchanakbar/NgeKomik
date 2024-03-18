class Latest {
  Latest({
    required this.title,
    required this.thumbnail,
    required this.type,
    required this.endpoint,
    required this.chapters,
  });

  final String? title;
  final String? thumbnail;
  final String? type;
  final String? endpoint;
  final List<Chapter> chapters;

  factory Latest.fromJson(Map<String, dynamic> json) {
    return Latest(
      title: json["title"],
      thumbnail: json["thumbnail"],
      type: json["type"],
      endpoint: json["endpoint"],
      chapters: json["chapters"] == null
          ? []
          : List<Chapter>.from(
              json["chapters"]!.map((x) => Chapter.fromJson(x))),
    );
  }
}

class Chapter {
  Chapter({
    required this.title,
    required this.updatedAt,
    required this.endpoint,
  });

  final String? title;
  final String? updatedAt;
  final String? endpoint;

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      title: json["title"],
      updatedAt: json["updated_at"],
      endpoint: json["endpoint"],
    );
  }
}
