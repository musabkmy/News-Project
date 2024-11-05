import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_api/news_api.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit(this._newsApi) : super(NewsState());
  final NewsApi _newsApi;

  Future<void> initiate() async {
    emit(state.copyWith(status: NewsStatus.loading));
    List<SourceEntity> sources = [];
    List<ArticleEntity> topNews = [];
    List<ArticleEntity> todaysNews = [];
    try {
      sources = (await _newsApi.fetchSources());
      // if (sources.isEmpty) throw SourcesNotFoundException();
      // print('Sources: $sources');

      topNews = (await _newsApi.fetchTopNews());
      // if (topNews.isEmpty) throw TopArticlesNotFoundException();
      // print('Top News: $topNews');

      todaysNews = (await _newsApi.fetchTodaysNews(getSources(sources)));
      // if (todaysNews.isEmpty) throw TodaysArticlesNotFoundException();
      // print('Today\'s News: $todaysNews');

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
}
