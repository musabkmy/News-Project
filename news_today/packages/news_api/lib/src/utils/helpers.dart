// ignore_for_file: avoid_print

import 'package:news_api/news_api.dart';

String getSources(List<SourceEntity> sources) {
  String result = '';
  void addId(String? id) {
    if (id != null) {
      result += result == '' ? id : ',$id';
    }
  }

  if (sources.isNotEmpty) {
    for (int i = 0; (i < sources.length && i <= 20); i++) {
      print('i was: $i');
      addId(sources[i].id);
    }
  }
  return result;
}
