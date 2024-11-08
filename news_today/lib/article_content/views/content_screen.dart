import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/news_api.dart';
import 'package:news_today/home/cubit/news_cubit.dart';
import 'package:news_today/home/helpers/shared.dart';
import 'package:news_today/themes/cubit/theme_cubit.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key, required this.articleId});
  final String articleId;

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializer();
    });
  }

  void _initializer() {
    if (!mounted) {
      print('mounted');
      return;
    }
    context.read<NewsCubit>().fetchFullContent(articleId: widget.articleId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          // final ThemeCubit themeCubit = context.watch<ThemeCubit>();
          // final ContentLoadStatus contentLoadStatus =
          //     context.watch<NewsCubit>().state.contentLoadStatus;
          return const ContentLayout();
        },
      ),
    );
  }
}

class ContentLayout extends StatelessWidget {
  const ContentLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spPadding1),
      child: Builder(
        builder: (context) {
          final ThemeCubit appTheme = context.watch<ThemeCubit>();
          // final ArticleEntity? article =
          //     context.watch<NewsCubit>().state.selectedArticle;
          //     context.watch<NewsCubit>().state.contentLoadStatus;
          return BlocSelector<NewsCubit, NewsState,
                  (ArticleEntity?, ContentLoadStatus)>(
              selector: (state) =>
                  (state.selectedArticle, state.contentLoadStatus),
              builder: (context, state) {
                final ArticleEntity? article = state.$1;
                final ContentLoadStatus contentLoadStatus = state.$2;
                return article == null
                    ? const SizedBox()
                    : Column(children: [
                        Text(
                          article.title,
                          style: appTheme.appTextStyles.bodyLarge,
                        ),
                        const SizedBox(height: padding1),
                        Hero(
                            tag: article.id,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(radius1),
                              child: CachedNetworkImage(
                                imageUrl: article.urlToImage,
                                placeholder: (context, url) => Container(
                                    color: appTheme.appColors.primaryColor,
                                    height: double.maxFinite,
                                    width: double.maxFinite),
                                errorWidget: (context, url, error) => Container(
                                    color: appTheme.appColors.primaryColor,
                                    height: double.maxFinite,
                                    width: double.maxFinite),
                              ),
                            )),
                        const SizedBox(height: padding1),
                        article.source.name == null
                            ? const Placeholder()
                            : Text(article.source.name!,
                                style: appTheme.appTextStyles.bodySmall),
                        Divider(
                          height: padding3,
                          thickness: padding1,
                          color: appTheme.appColors.seconderColor,
                        ),

                        // Check the Content availability
                        switch (contentLoadStatus) {
                          ContentLoadStatus.initial => const SizedBox(),
                          ContentLoadStatus.loading =>
                            const Center(child: CircularProgressIndicator()),
                          ContentLoadStatus.success =>
                            const Center(child: Text('success')),
                          // ContentLoadStatus.success => Text(article.content,
                          //     style: appTheme.appTextStyles.bodyMedium),
                          ContentLoadStatus.failure => Center(
                              child: Text(
                                context
                                    .watch<NewsCubit>()
                                    .state
                                    .contentLoadErrorMessage,
                                style: appTheme.appTextStyles.bodyMedium,
                              ),
                            ),
                        },
                      ]);
              });
        },
      ),
    );
  }
}

class TopScreenWidget extends StatelessWidget {
  const TopScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_rounded,
              color: context.watch<ThemeCubit>().appColors.primaryColor),
          onPressed: () {},
        ),
      ],
    );
  }
}
