import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_api/news_api.dart';
import 'package:news_today/home/helpers/shared.dart';
import 'package:news_today/themes/app_colors.dart';
import 'package:news_today/themes/app_text_styles.dart';

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
          padding: const EdgeInsets.all(padding3),
          child: Text(
            'Quick Reads',
            style: appTextStyles.titleLarge,
          ),
        ),
        SizedBox(
          height: 120.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sources.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(2.0),
                // margin: const EdgeInsets.only(bottom: padding1),
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
                        errorWidget: (context, url, error) => const SizedBox(
                            height: double.maxFinite, width: double.maxFinite),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: padding2),
                      child: Text(sources[index].name!,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: appTextStyles.bodyBoldSmall),
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
