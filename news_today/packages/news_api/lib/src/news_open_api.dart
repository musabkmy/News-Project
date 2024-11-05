import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_api/config/config.dart';
import 'package:news_api/news_api.dart';

/// {@template news_open_api}
/// API to fetch news from various sources across multiple categories.
/// {@endtemplate}
class NewsOpenApi implements NewsApi {
  final String apiKey = Config.newsApiKey;
  final String language = 'en';
  final String baseUrl = "https://newsapi.org/v2";

  /// {@macro news_open_api}
  NewsOpenApi();

  @override
  Future<List<SourceEntity>> fetchSources() async {
    try {
      final response = await http.get(Uri.parse(
          '$baseUrl/top-headlines/sources?apiKey=$apiKey&language=$language'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        if (!jsonResponse.containsKey('sources')) {
          throw SourcesNotFoundException();
        }
        final List<dynamic> sourcesJson = jsonResponse['sources'];

        if (sourcesJson.isEmpty) {
          throw SourcesNotFoundException();
        }
        print('sourcesJson: $sourcesJson');
        final List<SourceModel> sources = sourcesJson
            .map((response) =>
                SourceModel.fromJson(response as Map<String, dynamic>))
            .toList()
            .sublist(0, sourcesJson.length >= 20 ? 20 : sourcesJson.length);
        return sources.map((element) => element.toEntity()).toList();
      } else {
        throw FetchSourcesFailure();
      }
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }

  @override
  Future<bool> hasAFavIcon(String url) async {
    try {
      // Attempt to fetch the image from the provided URL
      final response = await http.head(Uri.parse(url));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<ArticleEntity>> fetchTopNews() async {
    try {
      final response = await http.get(Uri.parse(
          '$baseUrl/top-headlines?apiKey=$apiKey&language=$language'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        if (!jsonResponse.containsKey('articles')) {
          throw TopArticlesNotFoundException();
        }
        final List<dynamic> articlesJson = jsonResponse['articles'];

        if (articlesJson.isEmpty) {
          throw TopArticlesNotFoundException();
        }
        final List<ArticleModel> articles = articlesJson
            .map((response) =>
                ArticleModel.fromJson(response as Map<String, dynamic>))
            .toList();
        return articles.map((element) => element.toEntity()).toList();
      } else {
        throw FetchTopArticlesFailure();
      }
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }

  @override
  Future<List<ArticleEntity>> fetchTodaysNews(String sources) async {
    try {
      final response = await http.get(Uri.parse(
          '$baseUrl/everything?apiKey=$apiKey&language=$language&sources=$sources'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        if (!jsonResponse.containsKey('articles')) {
          throw TodaysArticlesNotFoundException();
        }
        final List<dynamic> sourcesJson = jsonResponse['articles'];

        if (sourcesJson.isEmpty) {
          throw TodaysArticlesNotFoundException();
        }
        final List<ArticleModel> sources = sourcesJson
            .map((response) =>
                ArticleModel.fromJson(response as Map<String, dynamic>))
            .toList();
        return sources.map((element) => element.toEntity()).toList();
      } else {
        throw FetchTodaysArticlesFailure();
      }
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }

  @override
  Future<void> saveNews(List<ArticleModel> news) {
    // TODO: implement saveNews
    throw UnimplementedError();
  }
}
