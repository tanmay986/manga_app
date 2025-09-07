import 'dart:math';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> mangaResults = []; // replace with real data

  // Categories (wrapped instead of scroll)
  final List<String> categories = [
    "Action", "Romance", "Comedy", "Horror", "Fantasy",
    "Popular", "Drama", "Mystery", "Sci-Fi", "Adventure",
    "Thriller", "Slice of Life", "Historical", "Sports",
    "Supernatural", "Seinen", "Shoujo", "Josei"
  ];

  // Sample manga names for random hint text
  final List<String> sampleManga = [
    "Naruto", "One Piece", "Attack on Titan",
    "Demon Slayer", "Jujutsu Kaisen", "Death Note",
    "Bleach", "Tokyo Ghoul", "Hunter x Hunter",
    "My Hero Academia", "Dragon Ball", "Black Clover"
  ];

  String randomHint = "";

  @override
  void initState() {
    super.initState();
    // Pick a random manga title as placeholder
    randomHint = sampleManga[Random().nextInt(sampleManga.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // removes back button
        title: const Text(
          "Search Manga",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: TextField(
                controller: _searchController,
                textAlign: TextAlign.center, // center text
                decoration: InputDecoration(
                  hintText: "Search $randomHint...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        mangaResults.clear();
                      });
                    },
                  )
                      : null,
                ),
                onChanged: (query) {
                  // TODO: Add search logic
                },
              ),
            ),
          ),

          // 🌟 Category Chips (wrapped)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: categories.map((cat) {
                return Chip(
                  label: Text(
                    cat,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  backgroundColor: Colors.deepPurpleAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 10),

          // 📚 Results
          Expanded(
            child: mangaResults.isEmpty
                ? const Center(
              child: Text(
                "Start typing to search manga...",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: mangaResults.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Stack(
                      children: [
                        Image.network(
                          "https://placehold.co/300x400",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            width: double.infinity,
                            color: Colors.black54,
                            child: const Text(
                              "Manga Title",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
