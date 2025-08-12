import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/gallery_item.dart';

class GalleryNotifier extends StateNotifier<AsyncValue<List<GalleryItem>>> {
  GalleryNotifier() : super(const AsyncValue.loading()) {
    _loadGalleryItems();
  }

  Future<void> _loadGalleryItems() async {
    try {
      state = const AsyncValue.loading();

      // Static gallery data
      await Future.delayed(const Duration(milliseconds: 500));

      final galleryItems = [
        GalleryItem(
          id: '1',
          title: 'School Campus',
          description: 'Beautiful view of our school campus and surroundings',
          imageUrl: 'assets/gallery/1.jpeg',
          category: 'Campus',
          date: DateTime.now().subtract(const Duration(days: 30)),
        ),
        GalleryItem(
          id: '2',
          title: 'School Building',
          description: 'Main school building with modern architecture',
          imageUrl: 'assets/gallery/2.jpeg',
          category: 'Infrastructure',
          date: DateTime.now().subtract(const Duration(days: 25)),
        ),
        GalleryItem(
          id: '3',
          title: 'Classroom',
          description: 'Well-equipped classrooms for effective learning',
          imageUrl: 'assets/gallery/3.jpeg',
          category: 'Facilities',
          date: DateTime.now().subtract(const Duration(days: 20)),
        ),
        GalleryItem(
          id: '4',
          title: 'Library',
          description: 'Extensive collection of books and digital resources',
          imageUrl: 'assets/gallery/4.jpeg',
          category: 'Facilities',
          date: DateTime.now().subtract(const Duration(days: 15)),
        ),
        GalleryItem(
          id: '5',
          title: 'Science Lab',
          description:
              'Well-equipped science laboratory for practical learning',
          imageUrl: 'assets/gallery/5.jpeg',
          category: 'Facilities',
          date: DateTime.now().subtract(const Duration(days: 10)),
        ),
        GalleryItem(
          id: '6',
          title: 'Computer Lab',
          description: 'Modern computer lab with latest technology',
          imageUrl: 'assets/gallery/6.jpeg',
          category: 'Technology',
          date: DateTime.now().subtract(const Duration(days: 5)),
        ),
        GalleryItem(
          id: '7',
          title: 'Sports Ground',
          description: 'Large sports ground for various outdoor activities',
          imageUrl: 'assets/gallery/7.jpeg',
          category: 'Sports',
          date: DateTime.now().subtract(const Duration(days: 4)),
        ),
        GalleryItem(
          id: '8',
          title: 'Art Room',
          description: 'Creative space for artistic expression',
          imageUrl: 'assets/gallery/8.jpeg',
          category: 'Arts',
          date: DateTime.now().subtract(const Duration(days: 3)),
        ),
        GalleryItem(
          id: '9',
          title: 'School Events',
          description: 'Celebrating various school events and activities',
          imageUrl: 'assets/gallery/9.jpeg',
          category: 'Events',
          date: DateTime.now().subtract(const Duration(days: 2)),
        ),
        GalleryItem(
          id: '10',
          title: 'Student Activities',
          description: 'Students engaged in various learning activities',
          imageUrl: 'assets/gallery/10.jpeg',
          category: 'Activities',
          date: DateTime.now().subtract(const Duration(days: 1)),
        ),
        GalleryItem(
          id: '11',
          title: 'School Garden',
          description: 'Beautiful school garden and green spaces',
          imageUrl: 'assets/gallery/11.jpeg',
          category: 'Campus',
          date: DateTime.now().subtract(const Duration(days: 1)),
        ),
        GalleryItem(
          id: '12',
          title: 'Technology Center',
          description: 'Advanced technology center for digital learning',
          imageUrl: 'assets/gallery/12.jpeg',
          category: 'Technology',
          date: DateTime.now().subtract(const Duration(days: 1)),
        ),
        GalleryItem(
          id: '13',
          title: 'Cultural Events',
          description: 'Celebrating cultural diversity and traditions',
          imageUrl: 'assets/gallery/13.jpeg',
          category: 'Events',
          date: DateTime.now().subtract(const Duration(days: 1)),
        ),
        GalleryItem(
          id: '14',
          title: 'Sports Activities',
          description: 'Students participating in sports and games',
          imageUrl: 'assets/gallery/14.jpeg',
          category: 'Sports',
          date: DateTime.now().subtract(const Duration(days: 1)),
        ),
        GalleryItem(
          id: '15',
          title: 'Academic Excellence',
          description: 'Recognizing academic achievements and success',
          imageUrl: 'assets/gallery/15.jpeg',
          category: 'Achievements',
          date: DateTime.now().subtract(const Duration(days: 1)),
        ),
        GalleryItem(
          id: '16',
          title: 'School Community',
          description: 'Building a strong and supportive school community',
          imageUrl: 'assets/gallery/16.jpeg',
          category: 'Community',
          date: DateTime.now().subtract(const Duration(days: 1)),
        ),
        GalleryItem(
          id: '17',
          title: 'Learning Environment',
          description: 'Creating an inspiring learning environment',
          imageUrl: 'assets/gallery/17.jpeg',
          category: 'Facilities',
          date: DateTime.now().subtract(const Duration(days: 1)),
        ),
        GalleryItem(
          id: '18',
          title: 'School Pride',
          description: 'Students and staff showing school pride and spirit',
          imageUrl: 'assets/gallery/18.jpeg',
          category: 'Spirit',
          date: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ];

      state = AsyncValue.data(galleryItems);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await _loadGalleryItems();
  }
}

final galleryProvider =
    StateNotifierProvider<GalleryNotifier, AsyncValue<List<GalleryItem>>>(
      (ref) => GalleryNotifier(),
    );
