// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_api/news_api.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsState());
  final NewsApi _newsApi = NewsOpenApi();

  Future<void> initiate() async {
    emit(state.copyWith(status: NewsStatus.loading));
    List<SourceEntity> sources = [];
    List<ArticleEntity> topNews = [];
    Map<ArticleCategory, List<ArticleEntity>> todaysNews = {};
    try {
      sources = (await _newsApi.fetchSources());
      // if (sources.isEmpty) throw SourcesNotFoundException();
      // print('Sources: $sources');

      topNews = (await _newsApi.fetchTopNews());
      // if (topNews.isEmpty) throw TopArticlesNotFoundException();
      // print('Top News: $topNews');

      todaysNews = (await _newsApi.fetchTodaysNews(sources));
      // if (todaysNews.isEmpty) throw TodaysArticlesNotFoundException();
      print('Today\'s News: ${todaysNews.values.length}');

      emit(state.copyWith(
          status: NewsStatus.success,
          sources: sources,
          topNews: topNews,
          todaysNews: todaysNews,
          errorMessage: ''));
    } on Exception {
      emit(state.copyWith(status: NewsStatus.failure, errorMessage: ''));
    } catch (err) {
      emit(state.copyWith(status: NewsStatus.failure, errorMessage: ''));
    }
  }

  List<ArticleCategory> getAvailableCategories() {
    print('at available categories: ${state.todaysNews} with ${state.status}');
    if (state.status == NewsStatus.success &&
        state.todaysNews != null &&
        state.todaysNews!.isNotEmpty) {
      //avoiding redundant values
      Set<ArticleCategory> categories = {ArticleCategory.all};
      for (ArticleCategory key in ArticleCategory.values) {
        if (state.todaysNews!.containsKey(key)) {
          categories.add(key);
        }
      }

      for (var v in categories) {
        print('Available Category: ${v.name}');
      }
      return categories.toList();
    }
    print('only all');
    return [ArticleCategory.all];
  }

  List<ArticleEntity> getCategoryArticles(ArticleCategory category) {
    if (state.status == NewsStatus.success &&
        state.todaysNews != null &&
        state.todaysNews!.isNotEmpty) {
      if (category == ArticleCategory.all) {
        for (var v in state.todaysNews!.values) {
          print('all Categories: ${v.length}');
        }
        return state.todaysNews!.values.expand((articles) => articles).toList();
      } else if (state.todaysNews!.containsKey(category)) {
        print('add Category: $category');
        return state.todaysNews![category]!.toList();
      } else {
        print('no added Category: $category');
      }
    }
    print('return []');
    return [];
  }
}
