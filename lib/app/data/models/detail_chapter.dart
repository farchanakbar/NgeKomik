class DetailChapter {
  DetailChapter({
    required this.title,
    required this.titleComic,
    required this.prevUrl,
    required this.nextUrl,
    required this.chapters,
  });

  final String? title;
  final String? titleComic;
  final String? prevUrl;
  final String? nextUrl;
  final List<String> chapters;

  factory DetailChapter.fromJson(Map<String, dynamic> json) {
    return DetailChapter(
      title: json["title"],
      titleComic: json["title_comic"],
      prevUrl: json["prev_url"],
      nextUrl: json["next_url"],
      chapters: json["chapters"] == null
          ? []
          : List<String>.from(json["chapters"]!.map((x) => x)),
    );
  }
}
