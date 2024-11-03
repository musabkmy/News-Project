import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_repository/news_repository.dart';

class App extends StatelessWidget {
  // final NewsRepository userRepo;
  const App({
    super.key,
    required this.newsRepository,
    // required this.settingsController,
  });
  final NewsRepository newsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: newsRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
