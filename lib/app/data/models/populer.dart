class Populer {
  Populer({
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

  factory Populer.fromJson(Map<String, dynamic> json) {
    return Populer(
      title: json["title"],
      thumbnail: json["thumbnail"],
      newestChapter: json["newest_chapter"],
      rating: json["rating"],
      endpoint: json["endpoint"],
      type: json["type"],
    );
  }
}
