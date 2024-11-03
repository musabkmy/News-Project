// ignore_for_file: prefer_const_constructors

import 'package:news_api/enums/category.dart';
import 'package:news_api/news_api.dart';

final List<SourceEntity> mockSourceData = [
  SourceEntity(
    id: '1',
    name: 'Mock Source 1',
    description: 'Description for Mock Source 1',
    url: 'https://source1.com',
    category: Category.business,
  ),
  SourceEntity(
    id: '2',
    name: 'Mock Source 2',
    description: 'Description for Mock Source 2',
    url: 'https://source2.com',
    category: Category.technology,
  ),
  // Add more mock data as needed
];

final List<ArticleEntity> mockTopArticleData = [
  ArticleEntity(
    id: '1',
    title: 'Mock Article 1',
    description: 'Description for Mock Article 1',
    author: 'Author 1',
    url: 'https://article1.com',
    urlToImage: 'https://article1.com/image.jpg',
    publishedAt: DateTime.now().subtract(Duration(days: 1)),
    content: 'Content for Mock Article 1',
    source: SourceBasic(id: 'source1', name: 'Mock Source 1'),
    isSavedArticle: false,
  ),
  ArticleEntity(
    id: '2',
    title: 'Mock Article 2',
    description: 'Description for Mock Article 2',
    author: 'Author 2',
    url: 'https://article2.com',
    urlToImage: 'https://article2.com/image.jpg',
    publishedAt: DateTime.now(),
    content: 'Content for Mock Article 2',
    source: SourceBasic(id: 'source2', name: 'Mock Source 2'),
    isSavedArticle: true,
  ), // Add more mock data as needed
];

final List<ArticleEntity> mockTodaysArticles = [
  ArticleEntity(
    id: '3',
    title: 'Today\'s Article 1',
    description: 'Description for Today\'s Article 1',
    author: 'Author 3',
    url: 'https://todaysarticle1.com',
    urlToImage: 'https://todaysarticle1.com/image.jpg',
    publishedAt: DateTime.now(),
    content: 'Content for Today\'s Article 1',
    source: SourceBasic(id: 'source3', name: 'Source 3'),
    isSavedArticle: false,
  ),
  ArticleEntity(
    id: '4',
    title: 'Today\'s Article 2',
    description: 'Description for Today\'s Article 2',
    author: 'Author 4',
    url: 'https://todaysarticle2.com',
    urlToImage: 'https://todaysarticle2.com/image.jpg',
    publishedAt: DateTime.now(),
    content: 'Content for Today\'s Article 2',
    source: SourceBasic(id: 'source4', name: 'Source 4'),
    isSavedArticle: true,
  ),
  // Add more mock data as needed
];
