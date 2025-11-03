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
  /// Recursively lists all image files from root and subfolders
  static Future<List<FileObject>> listGalleryImages() async {
    try {
      final bucket = _client.storage.from(_galleryBucket);
      final List<FileObject> allFiles = [];

      // List root level files
      final rootFiles = await bucket.list();

      // Filter and collect image files from root
      for (final item in rootFiles) {
        if (_isImageFile(item.name)) {
          allFiles.add(item);
        } else {
          // If it's a folder (no extension), recursively list files from it
          try {
            final folderFiles = await bucket.list(path: item.name);
            for (final file in folderFiles) {
              if (_isImageFile(file.name)) {
                // Store the full path in a custom way by modifying the name
                // We'll create a wrapper that preserves the path
                allFiles.add(_createFileObjectWithPath(file, item.name));
              }
            }
          } catch (e) {
            // Skip if folder listing fails
            continue;
          }
        }
      }

      return allFiles;
    } catch (e) {
      throw Exception('Failed to list gallery images: $e');
    }
  }

  /// Create a FileObject with folder path prepended to name
  static FileObject _createFileObjectWithPath(
    FileObject file,
    String folderPath,
  ) {
    // Since FileObject doesn't have a copyWith, we'll work with the name
    // The name will include the full path: "folder/file.jpg"
    return FileObject(
      name: '$folderPath/${file.name}',
      id: file.id,
      updatedAt: file.updatedAt,
      createdAt: file.createdAt,
      lastAccessedAt: file.lastAccessedAt,
      metadata: file.metadata,
      bucketId: file.bucketId,
      owner: file.owner,
      buckets: file.buckets,
    );
  }

  /// Check if a file is an image file
  static bool _isImageFile(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'].contains(extension);
  }

  /// Get public URL for an image
  static String getImageUrl(String imagePath) {
    final bucket = _client.storage.from(_galleryBucket);
    return bucket.getPublicUrl(imagePath);
  }
}
