class GenreList {
  GenreList({
    required this.title,
    required this.endpoint,
  });

  final String? title;
  final String? endpoint;

  factory GenreList.fromJson(Map<String, dynamic> json) {
    return GenreList(
      title: json["title"],
      endpoint: json["endpoint"],
    );
  }
}
