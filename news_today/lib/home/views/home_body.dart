import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_today/home/cubit/news_cubit.dart';
import 'package:news_today/home/views/quick_reads_layout.dart';
import 'package:news_today/home/helpers/shared.dart';
import 'package:news_today/home/views/todays_news_layout.dart';
import 'package:news_today/home/views/top_news_layout.dart';
import 'package:news_today/themes/app_theme.dart';
import 'package:news_today/themes/cubit/theme_cubit.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final newsState = BlocProvider.of<NewsCubit>(context).state;
        final themeState = BlocProvider.of<ThemeCubit>(context).state;

        return ListView(
          children: [
            const SizedBox(height: padding3),
            QuickReadsLayout(
                sources: newsState.sources!,
                appTextStyles: themeState.themeData.appTextStyles,
                appColors: themeState.themeData.appTextStyles.appColors),
            const SizedBox(height: padding3),
            const TopNewsLayout(),
            const SizedBox(height: padding3),
            const TodaysNewsLayout(),
          ],
        );
      },
    );
  }
}
