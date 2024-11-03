import 'package:news_api/news_api.dart';

abstract class NewsApi {
  Future<List<SourceEntity>> fetchSources();
  Future<List<ArticleEntity>> fetchTopNews();
  Future<List<ArticleEntity>> fetchTodaysNews(String sources);
  Future<void> saveNews(List<ArticleModel> news);
}

/// Exception thrown when fetching sources fails.
class FetchSourcesFailure implements Exception {}

/// Exception thrown when not finding sources.
class SourcesNotFoundException implements Exception {}

/// Exception thrown when fetching articles fails.
class FetchTopArticlesFailure implements Exception {}

/// Exception thrown when not finding articles.
class TopArticlesNotFoundException implements Exception {}

/// Exception thrown when fetching articles fails.
class FetchTodaysArticlesFailure implements Exception {}

/// Exception thrown when not finding articles.
class TodaysArticlesNotFoundException implements Exception {}
