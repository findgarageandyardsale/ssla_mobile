import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseClient _client = Supabase.instance.client;

  // Storage bucket name for gallery images
  static const String _galleryBucket = 'Gallery Image';

  /// Get Supabase client instance
  static SupabaseClient get client => _client;

  /// Get storage bucket for gallery images
  static dynamic get galleryBucket => _client.storage.from(_galleryBucket);

  /// List all files in the gallery bucket
  static Future<List<FileObject>> listGalleryImages() async {
    try {
      final bucket = _client.storage.from(_galleryBucket);
      final List<FileObject> files = await bucket.list();
      return files;
    } catch (e) {
      throw Exception('Failed to list gallery images: $e');
    }
  }

  /// Get public URL for an image
  static String getImageUrl(String imagePath) {
    final bucket = _client.storage.from(_galleryBucket);
    return bucket.getPublicUrl(imagePath);
  }
}
