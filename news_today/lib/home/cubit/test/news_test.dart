// ignore_for_file: avoid_print

import 'package:mocktail/mocktail.dart';
import 'package:news_api/news_api.dart';
import 'package:news_today/home/cubit/news_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';

import 'mock_data.dart';

class MockNewsApi extends Mock implements NewsApi {}

void main() {
  group('News Cubit', () {
    late MockNewsApi mockNewsApi;
    late NewsCubit newsCubit;
    // late FavIconCubit favIconCubit;
    // late String iconUrl;

    setUp(() {
      mockNewsApi = MockNewsApi();
      newsCubit = NewsCubit();
      // favIconCubit = FavIconCubit(mockNewsApi);
    });

    blocTest<NewsCubit, NewsState>(
        'emits [NewsState.loading, NewsState.success] when initiate is called and API calls succeed',
        build: () {
          print('mockSourceData.length ${mockSourceData.length}');
          when(() => mockNewsApi.fetchSources())
              .thenAnswer((_) async => mockSourceData);
          when(() => mockNewsApi.fetchTopNews())
              .thenAnswer((_) async => mockTopArticleData);
          when(() => mockNewsApi.fetchTodaysNews(mockSourceData))
              .thenAnswer((_) async => mockTodaysArticles);
          return newsCubit;
        },
        act: (cubit) async {
          cubit.initiate();
        },
        verify: (cubit) {
          final categories = cubit.getAvailableCategories();
          expect(categories.length, 5);

          final allArticle = cubit.getCategoryArticles(ArticleCategory.all);
          expect(allArticle.length, 8);

          final healthArticle =
              cubit.getCategoryArticles(ArticleCategory.health);
          expect(healthArticle.length, 2);

          final techArticle =
              cubit.getCategoryArticles(ArticleCategory.technology);
          expect(techArticle.length, 0);
        },
        expect: () => [
              NewsState(status: NewsStatus.loading),
              NewsState(
                status: NewsStatus.success,
                sources: mockSourceData,
                topNews: mockTopArticleData,
                todaysNews: mockTodaysArticles,
                errorMessage: '',
              )
            ]);

    blocTest<NewsCubit, NewsState>(
        'emits [NewsState.loading, NewsState.failure] when initiate is called and API calls failed',
        build: () {
          print('mockSourceData.length ${mockSourceData.length}');
          when(() => mockNewsApi.fetchSources())
              .thenAnswer((_) async => mockSourceData);
          when(() => mockNewsApi.fetchTopNews())
              .thenAnswer((_) async => mockTopArticleData);
          when(() => mockNewsApi.fetchTodaysNews(mockSourceData))
              .thenAnswer((_) async => throw TodaysArticlesNotFoundException());
          return newsCubit;
        },
        act: (cubit) => cubit.initiate(),
        expect: () => <NewsState>[
              NewsState(status: NewsStatus.loading),
              NewsState(
                status: NewsStatus.failure,
                errorMessage: '',
              ),
            ]);

    // blocTest<FavIconCubit, FavIconState>(
    //   'test if fav icon should be loaded when ',
    //   setUp: () {
    //     iconUrl = 'https://arstechnica.com/favicon.ico';
    //   },
    //   build: () {
    //     when(() => mockNewsApi.hasAFavIcon(iconUrl))
    //         .thenAnswer((_) async => true);
    //     return favIconCubit;
    //   },
    //   act: (cubit) => cubit.useFavIcon(iconUrl),
    //   expect: () => [
    //     FavIconState(isLoading: true),
    //     FavIconState(isLoading: true, isUsingUrl: true, faviconUrl: iconUrl),
    //     FavIconState(isLoading: false, isUsingUrl: true, faviconUrl: iconUrl),
    //   ],
    // );

    tearDown(() {
      newsCubit.close();
    });
  });
}
