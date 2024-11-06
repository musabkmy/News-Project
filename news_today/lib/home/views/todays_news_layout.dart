import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/news_api.dart';
import 'package:news_today/home/cubit/news_cubit.dart';
import 'package:news_today/home/helpers/shared.dart';
import 'package:news_today/themes/App_theme.dart';
import 'package:news_today/themes/app_colors.dart';
import 'package:news_today/themes/app_text_styles.dart';
import 'package:news_today/themes/cubit/theme_cubit.dart';

class TodaysNewsLayout extends StatefulWidget {
  const TodaysNewsLayout({super.key});

  @override
  State<TodaysNewsLayout> createState() => _TodaysNewsLayoutState();
}

class _TodaysNewsLayoutState extends State<TodaysNewsLayout>
    with SingleTickerProviderStateMixin {
  late NewsCubit _newsCubit;
  late List<ArticleCategory> _availableCategories;
  late TabController _tabController;
  late List<List<ArticleEntity>> _fetchedArticles;
  int currentTabIndex = 0;
  @override
  void initState() {
    super.initState();
    //retrieving available categories
    _newsCubit = BlocProvider.of<NewsCubit>(context);
    _availableCategories = _newsCubit.getAvailableCategories();
    _fetchedArticles = List.generate(_availableCategories.length, (_) => []);
    _tabController =
        TabController(length: _availableCategories.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          currentTabIndex = _tabController.index; // Update index
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _newsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double fullWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<ThemeCubit, ThemeState>(builder: (context, themeState) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(padding3),
            child: Text('Today\'s News',
                style: themeState.themeData.appTextStyles.titleLarge),
          ),
          SizedBox(
            height: 28.0,
            child: TabBar(
              isScrollable: true,
              padding: EdgeInsets.zero,
              splashFactory: NoSplash.splashFactory,
              overlayColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
                  return states.contains(WidgetState.focused)
                      ? null
                      : Colors.transparent;
                },
              ),
              tabAlignment: TabAlignment.start,
              controller: _tabController,
              dividerColor: Colors.transparent,
              tabs: _availableCategories
                  .asMap()
                  .entries
                  .map((item) => TabLayout(
                      tabTitle: item.value.value,
                      isPressed: currentTabIndex == item.key,
                      textStyles: themeState.themeData.appTextStyles,
                      appColors: themeState.themeData.appColors))
                  .toList(),
            ),
          ),
          SizedBox(
            height: fullWidth - 48.0,
            child: TabBarView(
              controller: _tabController,
              children: _availableCategories.asMap().entries.map((category) {
                _fetchedArticles[category.key] =
                    _newsCubit.getCategoryArticles(category.value);
                print(
                    '_fetchedArticles: ${_fetchedArticles[category.key].length}');
                return _fetchedArticles[category.key].isEmpty
                    ? const SizedBox()
                    : ListView.separated(
                        itemCount: _fetchedArticles[category.key].length,
                        separatorBuilder: (context, index) => Divider(
                          height: 2.0,
                          color: themeState.themeData.appColors.seconderColor,
                        ),
                        itemBuilder: (context, index) {
                          if (index >= _fetchedArticles[category.key].length) {
                            // Logging and handling out-of-range index
                            print('Index out of range: $index');
                            return const SizedBox();
                          }
                          return TabViewLayout(
                            article: _fetchedArticles[category.key][index],
                            appTextStyles: themeState.themeData.appTextStyles,
                            fullWidth: fullWidth,
                            imagePlacementColor: themeState
                                .themeData.appColors.accentColor
                                .withOpacity(0.4),
                          );
                        },
                      );
              }).toList(),
            ),
          ),
        ],
      );
    });
  }
}

class TabLayout extends StatelessWidget {
  const TabLayout(
      {super.key,
      required this.isPressed,
      required this.textStyles,
      required this.tabTitle,
      required this.appColors});
  final String tabTitle;
  final bool isPressed;
  final AppTextStyles textStyles;
  final AppColors appColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 120.0,
      // height: double.maxFinite,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius1),
        color: isPressed ? appColors.pinkColor : appColors.seconderColor,
      ),
      constraints: const BoxConstraints(
        minWidth: 32.0,
      ),
      margin: const EdgeInsets.only(left: padding3),
      padding: const EdgeInsets.symmetric(horizontal: padding3),
      child: Text(
        tabTitle,
        style: isPressed ? textStyles.bodyLarge2 : textStyles.bodyMedium,
      ),
    );
  }
}

class TodaysNewsArticle extends StatelessWidget {
  const TodaysNewsArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TabViewLayout extends StatelessWidget {
  const TabViewLayout(
      {super.key,
      required this.article,
      required this.appTextStyles,
      required this.fullWidth,
      required this.imagePlacementColor});
  final ArticleEntity article;
  final AppTextStyles appTextStyles;
  final Color imagePlacementColor;
  final double fullWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(padding3),
      child: Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 84,
                width: fullWidth / 3 - 24.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius1),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: article.urlToImage,
                    placeholder: (context, url) => Container(
                        color: imagePlacementColor,
                        height: double.maxFinite,
                        width: double.maxFinite),
                    errorWidget: (context, url, error) => Container(
                        color: imagePlacementColor,
                        height: double.maxFinite,
                        width: double.maxFinite),
                  ),
                )),
            const SizedBox(width: padding2),
            Expanded(
              // height: 84.0,
              // width: fullWidth - (fullWidth / 3 + 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    article.title,
                    maxLines: 2,
                    style: appTextStyles.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        article.source.name!,
                        style: appTextStyles.bodySmall,
                      ),
                      // Text(
                      //   article.publishedAt!.day.toString(),
                      //   style: appTextStyles.bodySmall,
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
