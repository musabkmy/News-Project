import 'package:flutter/material.dart';
import 'package:news_api/news_api.dart';
import 'package:news_today/bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final newsApi = NewsOpenApi();

  bootstrap(newsApi: newsApi);
}
