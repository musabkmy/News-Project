import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/news_api.dart';
import 'package:news_today/home/cubit/news_cubit.dart';
import 'package:news_today/home/views/home_screen.dart';
import 'package:news_today/themes/App_theme.dart';
import 'package:news_today/themes/cubit/theme_cubit.dart';

class App extends StatelessWidget {
  // final NewsRepository userRepo;
  const App({
    super.key,
    required this.newsRepository,
    // required this.settingsController,
  });
  final NewsApi newsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: newsRepository,
      child: MultiBlocProvider(
          providers: [
            BlocProvider<ThemeCubit>(
              create: (context) => ThemeCubit(
                appTheme: appLightTheme(),
              ),
            ),
            BlocProvider<NewsCubit>(
              create: (context) => NewsCubit(newsRepository),
            ),
          ],
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: themeState.themeData,
                home: const HomeScreen(),
              );
            },
          )),
    );
  }
}
