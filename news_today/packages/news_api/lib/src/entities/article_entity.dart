import 'source_basic.dart';

class ArticleEntity {
  final String id; // Unique identifier for the article
  final String title; // Title of the article
  final String description; // Short description of the article
  final String author; // Author of the article
  final String url; // URL of the article
  final String urlToImage; // URL to the article's image
  final DateTime? publishedAt; // Publication date of the article
  final String content; // Content of the article
  final SourceBasic source; // Source of the article
  bool isSavedArticle;

  ArticleEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.source,
    required this.isSavedArticle,
  });
}
