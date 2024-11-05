import 'package:news_api/news_api.dart';

import '../../enums/category.dart';

class SourceEntity implements SourceBase {
  @override
  final String? id;
  @override
  final String? name;
  final String? description;
  final String? favIconURL;
  final Category? category;
  // final String language;
  // final String country;

  const SourceEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.favIconURL,
    required this.category,
    // required this.language,
    // required this.country,
  });
}
