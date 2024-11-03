import 'package:news_api/news_api.dart';
import 'package:news_api/src/utils/string_extension.dart';

import '../../enums/category.dart';

class SourceModel implements SourceBase {
  @override
  final String? id;
  @override
  final String? name;
  final String? description;
  final String? url;
  final Category? category;

  const SourceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.category,
  });

  // Factory constructor to create an instance from JSON
  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'].toString().valueOrEmpty,
      name: json['name'].toString().valueOrEmpty,
      description: json['description'].toString().valueOrEmpty,
      url: json['url'].toString().valueOrEmpty,
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
        url: url,
        category: category);
  }
}
