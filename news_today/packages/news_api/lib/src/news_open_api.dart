// ignore_for_file: avoid_print

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
  Future<Map<ArticleCategory, List<ArticleEntity>>> fetchTodaysNews(
      List<SourceEntity> sourcesEntity) async {
    //create sources query
    String sources = getSources(sourcesEntity);

    try {
      final response = await http.get(Uri.parse(
          '$baseUrl/everything?apiKey=$apiKey&language=$language&sources=$sources'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        if (!jsonResponse.containsKey('articles')) {
          throw TodaysArticlesNotFoundException();
        }
        final List<dynamic> articlesJson = jsonResponse['articles'];

        if (articlesJson.isEmpty) {
          throw TodaysArticlesNotFoundException();
        }

        //json to model
        final List<ArticleModel> articlesModel = articlesJson
            .map((response) =>
                ArticleModel.fromJson(response as Map<String, dynamic>))
            .toList();
        //model to entity
        final List<ArticleEntity> articlesEntity =
            articlesModel.map((element) => element.toEntity()).toList();

        //create a list of categories depending on th sources ArticleCategory
        final Map<ArticleCategory, List<ArticleEntity>> categorizedArticles =
            {};
        SourceEntity selectedSource;
        for (var article in articlesEntity) {
          selectedSource = sourcesEntity.firstWhere(
              (source) => source.id == article.source.id,
              orElse: () => SourceEntity.defaultInstance());
          if (selectedSource != SourceEntity.defaultInstance()) {
            categorizedArticles
                .putIfAbsent(selectedSource.category!, () => [])
                .add(article);
          }
        }

        return categorizedArticles;
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
