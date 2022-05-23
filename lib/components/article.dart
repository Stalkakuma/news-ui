class NewsArticle {
  final String? title;
  final String? imageUrl;
  final String? description;
  final String? author;
  final String? publishedAt;
  final String url;

  NewsArticle({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.author,
    required this.publishedAt,
    required this.url,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'],
      imageUrl: json['urlToImage'],
      description: json['description'],
      author: json['author'],
      publishedAt: json['publishedAt'],
      url: json['url'],
    );
  }
}
