enum ArticleCategory {
  all('All'),
  general('General'),
  business('Business'),
  entertainment('Entertainment'),
  health('Health'),
  science('Science'),
  sports('Sports'),
  technology('Technology'),
  unknown('Unknown');

  final String value;

  const ArticleCategory(this.value);
}
