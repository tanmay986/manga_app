// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

import '../models/manga.dart';
import '../widgets/manga_row_section.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Manga> mangas = [];   // all items from CSV
  List<Manga> posters = [];  // only selected rows for the PageView

  @override
  void initState() {
    super.initState();
    loadCSV();
  }

  Future<void> loadCSV() async {
    final rawData = await rootBundle.loadString("assets/data/manga.csv");
    final csvTable = const CsvToListConverter().convert(rawData, eol: "\n");

    final List<Manga> all = [];
    for (int i = 1; i < csvTable.length; i++) {
      all.add(Manga(
        chapter: csvTable[i][0].toString(),
        title:   csvTable[i][1].toString(),
        image:   csvTable[i][2].toString(),
      ));
    }

    // specific poster rows
    final posterRows = [0,9, 65, 100, 101];
    final List<Manga> selectedPosters = [];
    for (final r in posterRows) {
      final idx = r - 1;
      if (idx >= 0 && idx < all.length) selectedPosters.add(all[idx]);
    }

    setState(() {
      mangas  = all;
      posters = selectedPosters;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mangas.isEmpty) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom header bar like YouTube
              SizedBox(
                height: 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "Manga App",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        // Icon(Icons.search, size: 28),
                        // SizedBox(width: 16),
                        // Icon(Icons.notifications_none, size: 28),
                        // SizedBox(width: 16),
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey[400],
                          child: const Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 12),
                      ],
                    )
                  ],
                ),
              ),

              const Divider(height: 1),

              // Poster slider
              if (posters.isNotEmpty)
                SizedBox(
                  height: 550,
                  child: PageView.builder(
                    controller: PageController(initialPage: 1000),
                    itemBuilder: (context, index) {
                      final manga = posters[index % posters.length];
                      return Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Image.asset(
                            "assets/manga_images/${manga.image}",
                            width: double.infinity,
                            height: 550,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.7),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            child: Text(
                              manga.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

              const SizedBox(height: 16),

              MangaRowSection(
                title: "Latest Manga",
                mangas: mangas,
                startIndex: 0,
                count: 10,
              ),
              const SizedBox(height: 16),

              MangaRowSection(
                title: "Recommendation",
                mangas: mangas,
                startIndex: 10,
                count: 10,
              ),
              const SizedBox(height: 16),

              MangaRowSection(
                title: "Saved",
                mangas: mangas,
                startIndex: 20,
                count: 10,
              ),
              const SizedBox(height: 16),

              MangaRowSection(
                title: "Other",
                mangas: mangas,
                startIndex: 30,
                count: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
