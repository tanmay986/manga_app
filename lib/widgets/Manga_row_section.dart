// lib/widgets/manga_row_section.dart
import 'package:flutter/material.dart';
import '../models/manga.dart';
import '../pages/manga_detail_page.dart';

class MangaRowSection extends StatelessWidget {
  final String title;
  final List<Manga> mangas;
  final int startIndex;
  final int count;

  const MangaRowSection({
    Key? key,
    required this.title,
    required this.mangas,
    this.startIndex = 0,
    this.count = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (mangas.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    }

    // Decide how many items to display
    final int itemsToShow = count.clamp(0, mangas.length);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title with "More" button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  // Later: open "More" page with full list
                },
                child: const Text("More"),
              ),
            ],
          ),
        ),

        // Horizontal scrollable list
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: itemsToShow,
            itemBuilder: (context, i) {
              final idx = (startIndex + i) % mangas.length;
              final manga = mangas[idx];

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MangaDetailPage(manga: manga),
                    ),
                  );
                },
                child: Container(
                  width: 160,
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Cover image
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            "assets/manga_images/${manga.image}",
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),

                      // Title
                      Text(
                        manga.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),

                      // Chapter
                      Text(
                        manga.chapter,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
