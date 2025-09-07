// lib/pages/favorites_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

import '../models/manga.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Manga> allMangas = [];
  List<Manga> favoriteMangas = [];

  // 🔹 Fixed favorite indices (not random each time, permanent selection)
  final List<int> favoriteIndices = [2, 5, 8, 15, 23, 42, 60, 78, 95, 120];

  @override
  void initState() {
    super.initState();
    loadCSV();
  }

  Future<void> loadCSV() async {
    final rawData = await rootBundle.loadString("assets/data/manga.csv");
    final csvTable = const CsvToListConverter().convert(rawData, eol: "\n");

    final List<Manga> mangas = [];
    for (int i = 1; i < csvTable.length; i++) {
      mangas.add(
        Manga(
          chapter: csvTable[i][0].toString(),
          title: csvTable[i][1].toString(),
          image: csvTable[i][2].toString(),
        ),
      );
    }

    // Pick from fixed indices
    final List<Manga> selected = [];
    for (final idx in favoriteIndices) {
      if (idx >= 0 && idx < mangas.length) {
        selected.add(mangas[idx]);
      }
    }

    setState(() {
      allMangas = mangas;
      favoriteMangas = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (favoriteMangas.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: favoriteMangas.length,
        itemBuilder: (context, index) {
          final manga = favoriteMangas[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Manga image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: Image.asset(
                    "assets/manga_images/${manga.image}",
                    width: 100,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 12),

                // Manga details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          manga.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          manga.chapter,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "This is one of your saved favorite manga. Tap to continue reading.",
                          style: TextStyle(fontSize: 13, color: Colors.black54),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
