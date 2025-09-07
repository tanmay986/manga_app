// import 'package:flutter/services.dart' show rootBundle;
// import 'package:csv/csv.dart';
// import '../models/manga.dart';
//
// class MangaService {
//   static Future<List<Manga>> loadManga() async {
//     final rawData = await rootBundle.loadString('assets/data/manga.csv');
//     List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
//
//     // skip the first row (headers: chapter,title,image)
//     return listData.skip(1).map((row) => Manga.fromCsv(row)).toList();
//   }
// }
