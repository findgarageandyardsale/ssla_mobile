import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/gallery_item.dart';
import '../services/supabase_service.dart';

class GalleryNotifier extends StateNotifier<AsyncValue<List<GalleryItem>>> {
  GalleryNotifier() : super(const AsyncValue.loading()) {
    _loadGalleryItems();
  }

  List<GalleryItem> _allItems = [];
  List<GalleryItem> _displayedItems = [];
  static const int _pageSize = 12; // Show 12 images initially
  bool _hasMoreData = true;

  Future<void> _loadGalleryItems() async {
    try {
      state = const AsyncValue.loading();

      // Fetch images from Supabase storage
      final files = await SupabaseService.listGalleryImages();

      if (files.isEmpty) {
        state = const AsyncValue.data([]);
        return;
      }

      // Convert FileObjects to GalleryItems
      final galleryItems =
          files.map((file) => GalleryItem.fromFileObject(file)).toList();

      state = AsyncValue.data(galleryItems);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    _allItems = [];
    _displayedItems = [];
    _hasMoreData = true;
    await _loadGalleryItems();
  }

  Future<void> loadMore() async {
    if (!_hasMoreData) return;

    final currentLength = _displayedItems.length;
    final nextItems = _allItems.skip(currentLength).take(_pageSize).toList();

    if (nextItems.isNotEmpty) {
      _displayedItems.addAll(nextItems);
      _hasMoreData = _displayedItems.length < _allItems.length;
      state = AsyncValue.data(_displayedItems);
    } else {
      _hasMoreData = false;
    }
  }

  bool get hasMoreData => _hasMoreData;
  int get totalCount => _allItems.length;
  int get displayedCount => _displayedItems.length;
}

final galleryProvider =
    StateNotifierProvider<GalleryNotifier, AsyncValue<List<GalleryItem>>>(
      (ref) => GalleryNotifier(),
    );
