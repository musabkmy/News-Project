import 'package:news_api/news_api.dart';

class SourceEntity implements SourceBase {
  @override
  final String? id;
  @override
  final String? name;
  final String? description;
  final String? favIconURL;
  final ArticleCategory? category;
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

  factory SourceEntity.defaultInstance() {
    return const SourceEntity(
        id: '',
        name: '',
        description: '',
        favIconURL: '',
        category: ArticleCategory.unknown);
  }

  // Override == operator for custom equality check
  @override
  bool operator ==(Object other) {
    //share same memory
    if (identical(this, other)) return true;
    return other is SourceEntity && other.id == id;
  }

  // Override hashCode to match the equality operator in hashCode / hashSet
  @override
  int get hashCode => id.hashCode;
}
