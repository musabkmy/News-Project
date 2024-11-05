import 'package:news_api/news_api.dart';
import 'package:news_api/src/utils/string_extension.dart';

import '../../enums/category.dart';

class SourceModel implements SourceBase {
  static const String favIcon = '/favicon.ico';
  @override
  final String? id;
  @override
  final String? name;
  final String? description;
  final String? favIconURL;
  final Category? category;

  const SourceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.favIconURL,
    required this.category,
  });

  // Factory constructor to create an instance from JSON
  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'].toString().valueOrEmpty,
      name: json['name'].toString().valueOrEmpty,
      description: json['description'].toString().valueOrEmpty,
      favIconURL: (json['url'] != null
          ? (json['url'] as String).extractBaseUrl() + favIcon
          : ''),
      category: Category.values.firstWhere(
        (category) =>
            category.toString().split('.').last.toLowerCase() ==
            json['category'].toString().toLowerCase(),
        orElse: () => Category.unknown, // Handle unknown categories
      ),
    );
  }

  SourceEntity toEntity() {
    return SourceEntity(
        id: id,
        name: name,
        description: description,
        favIconURL: favIconURL,
        category: category);
  }
}
