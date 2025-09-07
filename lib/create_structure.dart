import 'dart:io';

void main() {
  final folders = [
    'lib/models',
    'lib/services',
    'lib/pages',
    'lib/widgets',
    'lib/utils',
  ];

  final files = {
    'lib/main.dart': '',
    'lib/models/manga.dart': '',
    'lib/services/manga_service.dart': '',
    'lib/pages/home_page.dart': '',
    'lib/pages/search_page.dart': '',
    'lib/pages/favorites_page.dart': '',
    'lib/pages/settings_page.dart': '',
    'lib/widgets/manga_card.dart': '',
    'lib/utils/app_theme.dart': '',
  };

  // Create folders
  for (var folder in folders) {
    Directory(folder).createSync(recursive: true);
    print('Created folder: $folder');
  }

  // Create files
  files.forEach((path, content) {
    File(path).writeAsStringSync(content);
    print('Created file: $path');
  });

  print("✅ Folder and file structure created!");
}
