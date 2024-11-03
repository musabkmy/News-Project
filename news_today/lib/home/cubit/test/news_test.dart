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

    setUp(() {
      mockNewsApi = MockNewsApi();
      newsCubit = NewsCubit(mockNewsApi);
    });

    blocTest<NewsCubit, NewsState>(
        'emits [NewsState.loading, NewsState.success] when initiate is called and API calls succeed',
        build: () {
          print('mockSourceData.length ${mockSourceData.length}');
          when(() => mockNewsApi.fetchSources())
              .thenAnswer((_) async => mockSourceData);
          when(() => mockNewsApi.fetchTopNews())
              .thenAnswer((_) async => mockTopArticleData);
          when(() => mockNewsApi.fetchTodaysNews(getSources(mockSourceData)))
              .thenAnswer((_) async => mockTodaysArticles);
          return newsCubit;
        },
        act: (cubit) => cubit.initiate(),
        verify: (_) {
          verify(() => mockNewsApi.fetchSources()).called(1);
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
          when(() => mockNewsApi.fetchSources())
              .thenAnswer((_) async => mockSourceData);
          when(() => mockNewsApi.fetchTopNews())
              .thenAnswer((_) async => throw TopArticlesNotFoundException());
          return newsCubit;
        },
        act: (cubit) => cubit.initiate(),
        expect: () => [
              NewsState(status: NewsStatus.loading),
              NewsState(
                status: NewsStatus.failure,
                errorMessage: '',
              ),
            ]);

    tearDown(() {
      newsCubit.close();
    });
  });
}
