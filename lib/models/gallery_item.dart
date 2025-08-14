import 'package:supabase_flutter/supabase_flutter.dart';

class GalleryItem {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final DateTime date;

  GalleryItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.date,
  });

  /// Create a GalleryItem from a Supabase FileObject
  factory GalleryItem.fromFileObject(
    FileObject fileObject, {
    String? category,
  }) {
    final fileName = fileObject.name;
    final extension = fileName.split('.').last.toLowerCase();

    // Generate a title from the filename
    final title = fileName
        .replaceAll('_', ' ')
        .replaceAll('-', ' ')
        .split('.')
        .first
        .split(' ')
        .map(
          (word) =>
              word.isNotEmpty
                  ? '${word[0].toUpperCase()}${word.substring(1)}'
                  : '',
        )
        .where((word) => word.isNotEmpty)
        .join(' ');

    // Generate description based on the title
    final description = 'Image from $title';

    // Use provided category or generate from filename
    final finalCategory = category ?? _generateCategoryFromFilename(fileName);

    return GalleryItem(
      id: fileObject.id.toString(),
      title: title,
      description: description,
      imageUrl:
          fileName, // This will be used to get the public URL from Supabase
      category: finalCategory,
      date:
          DateTime.now(), // Use current time since updatedAt might not be available
    );
  }

  /// Generate category from filename
  static String _generateCategoryFromFilename(String fileName) {
    final lowerFileName = fileName.toLowerCase();

    if (lowerFileName.contains('event') ||
        lowerFileName.contains('celebration')) {
      return 'Events';
    } else if (lowerFileName.contains('class') ||
        lowerFileName.contains('room')) {
      return 'Classrooms';
    } else if (lowerFileName.contains('sport') ||
        lowerFileName.contains('game')) {
      return 'Sports';
    } else if (lowerFileName.contains('art') ||
        lowerFileName.contains('creative')) {
      return 'Arts';
    } else if (lowerFileName.contains('lab') ||
        lowerFileName.contains('science')) {
      return 'Labs';
    } else if (lowerFileName.contains('library') ||
        lowerFileName.contains('book')) {
      return 'Library';
    } else if (lowerFileName.contains('campus') ||
        lowerFileName.contains('building')) {
      return 'Campus';
    } else if (lowerFileName.contains('student') ||
        lowerFileName.contains('activity')) {
      return 'Activities';
    } else {
      return 'General';
    }
  }

  factory GalleryItem.fromJson(Map<String, dynamic> json) {
    return GalleryItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      category: json['category'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'category': category,
      'date': date.toIso8601String(),
    };
  }
}
