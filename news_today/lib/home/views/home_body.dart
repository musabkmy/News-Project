import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/news_api.dart';
import 'package:news_today/home/cubit/icon_fav_cubit.dart';
import 'package:news_today/home/cubit/news_cubit.dart';
import 'package:news_today/home/views/shared.dart';
import 'package:news_today/themes/app_colors.dart';
import 'package:news_today/themes/app_text_styles.dart';
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
            newsState.sources == null
                ? const SizedBox()
                : QuickReadsLayout(
                    sources: newsState.sources!,
                    appTextStyles: themeState.themeData.appTextStyles,
                    appColors: themeState.themeData.appTextStyles.appColors),
          ],
        );
      },
    );
  }
}

class QuickReadsLayout extends StatelessWidget {
  const QuickReadsLayout(
      {required this.sources,
      required this.appTextStyles,
      required this.appColors,
      super.key});
  final List<SourceEntity> sources;
  final AppTextStyles appTextStyles;
  final AppColors appColors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: padding3, vertical: padding2),
          child: Text(
            'Quick Reads',
            style: appTextStyles.titleLarge,
          ),
        ),
        SizedBox(
          height: 160.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sources.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(2.0),
                margin: const EdgeInsets.only(bottom: padding1),
                width: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 80.0,
                      width: 80.0,
                      padding: const EdgeInsets.all(padding2),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: appColors.seconderColor),
                      child: CachedNetworkImage(
                        // fit: BoxFit.contain,
                        imageUrl: sources[index].favIconURL!,
                        placeholder: (context, url) => const SizedBox(
                            height: double.maxFinite, width: double.maxFinite),
                        errorWidget: (context, url, error) =>
                            const SizedBox(height: 60.0, width: 60.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: padding2),
                      child: Text(sources[index].name!,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: appTextStyles.bodyMedium),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
