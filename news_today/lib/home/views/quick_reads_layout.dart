import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        // Padding(
        //   padding:
        //       EdgeInsets.symmetric(horizontal: spPadding1, vertical: padding3),
        //   child: Text(
        //     'Quick Reads',
        //     style: appTextStyles.titleLarge,
        //   ),
        // ),
        Container(
          height: 90.0.sp,
          // padding: EdgeInsets.only(left: spPadding1),
          constraints: const BoxConstraints(maxHeight: 200.0),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: sources.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: padding3),
            itemBuilder: (context, index) {
              return Container(
                width: 70.0.sp,
                margin: EdgeInsets.only(
                    left: index == 0 ? spPadding1 : 0.0,
                    right: index == sources.length - 1 ? spPadding1 : 0.0),
                constraints: const BoxConstraints(
                  maxWidth: 140.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 70.0.sp,
                      width: 70.0.sp,
                      // padding: const EdgeInsets.all(padding2),
                      constraints: const BoxConstraints(
                        maxHeight: 140.0,
                        maxWidth: 140.0,
                      ),
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
                    // Text(sources[index].name!,
                    //     textAlign: TextAlign.center,
                    //     maxLines: 1,
                    //     style: appTextStyles.bodySmall),
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
