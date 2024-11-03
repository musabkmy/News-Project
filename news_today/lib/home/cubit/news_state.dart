// ignore_for_file: prefer_const_constructors_in_immutables

part of 'news_cubit.dart';

enum NewsStatus { initial, loading, success, failure }

extension NewsStatusX on NewsStatus {
  bool get isInitial => this == NewsStatus.initial;
  bool get isLoading => this == NewsStatus.loading;
  bool get isSuccess => this == NewsStatus.success;
  bool get isFailure => this == NewsStatus.failure;
}

final class NewsState extends Equatable {
  NewsState({
    this.status = NewsStatus.initial,
    this.sources,
    this.topNews,
    this.todaysNews,
    this.errorMessage = '',
  });
  final NewsStatus status;
  final List<SourceEntity>? sources;
  final List<ArticleEntity>? topNews;
  final List<ArticleEntity>? todaysNews;
  final String errorMessage;

  NewsState copyWith({
    NewsStatus? status,
    List<SourceEntity>? sources,
    List<ArticleEntity>? topNews,
    List<ArticleEntity>? todaysNews,
    String? errorMessage,
  }) {
    return NewsState(
      status: status ?? this.status,
      sources: sources ?? this.sources,
      topNews: topNews ?? this.topNews,
      todaysNews: todaysNews ?? this.todaysNews,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, sources, topNews, todaysNews, errorMessage];
}
