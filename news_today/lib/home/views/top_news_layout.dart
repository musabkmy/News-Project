// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/news_api.dart';
import 'package:news_today/home/cubit/news_cubit.dart';
import 'package:news_today/home/helpers/shared.dart';
import 'package:news_today/themes/App_theme.dart';
import 'package:news_today/themes/cubit/theme_cubit.dart';

class TopNewsLayout extends StatelessWidget {
  const TopNewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(builder: (context, themeState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(padding3),
            child: Text('Top News',
                style: themeState.themeData.appTextStyles.titleLarge),
          ),
          BlocBuilder<NewsCubit, NewsState>(builder: (context, newsState) {
            return SizedBox(
              height: 200.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: newsState.topNews!.length,
                itemBuilder: (context, index) {
                  return TopNewsArticle(
                    article: newsState.topNews![index],
                    articleTitleStyle:
                        themeState.themeData.appTextStyles.bodyLarge2,
                    placementColor: themeState.themeData.appColors.accentColor,
                  );
                },
              ),
            );
          }),
        ],
      );
    });
  }
}

class TopNewsArticle extends StatelessWidget {
  const TopNewsArticle(
      {super.key,
      required this.article,
      required this.articleTitleStyle,
      required this.placementColor});
  final ArticleEntity article;
  final TextStyle articleTitleStyle;
  final Color placementColor;

  @override
  Widget build(BuildContext context) {
    print('image url: ${article.urlToImage}');
    return Container(
      height: 340.0,
      width: 340.0,
      margin: const EdgeInsets.symmetric(horizontal: padding3),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radius2),
            child: CachedNetworkImage(
              height: 340.0,
              width: 340,
              fit: BoxFit.cover,
              imageUrl: article.urlToImage,
              color: placementColor.withOpacity(0.5), // Color tint
              colorBlendMode: BlendMode.multiply,
              placeholder: (context, url) => Container(
                  decoration: BoxDecoration(
                      color: placementColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(radius2)),
                  height: double.maxFinite,
                  width: double.maxFinite),
              errorWidget: (context, url, error) => Container(
                  decoration: BoxDecoration(
                      color: placementColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(radius2)),
                  height: double.maxFinite,
                  width: double.maxFinite),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(padding3),
            child: Text(article.title,
                style: articleTitleStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
