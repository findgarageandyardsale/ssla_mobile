import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/course.dart';

class CoursesNotifier extends StateNotifier<AsyncValue<List<Course>>> {
  CoursesNotifier() : super(const AsyncValue.loading()) {
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    try {
      state = const AsyncValue.loading();

      // Simulate API call - replace with actual API call
      await Future.delayed(const Duration(seconds: 1));

      final courses = [
        Course(
          id: '1',
          name: 'Primary Education',
          description:
              'Foundation years focusing on basic literacy, numeracy, and social skills.',
          duration: '6 years',
          level: 'Primary',
          subjects: [
            'English',
            'Mathematics',
            'Science',
            'Social Studies',
            'Arts',
            'Physical Education',
          ],
          imageUrl:
              'https://via.placeholder.com/300x200/4CAF50/FFFFFF?text=Primary',
          fee: 5000.0,
        ),
        Course(
          id: '2',
          name: 'Secondary Education',
          description:
              'Comprehensive education preparing students for higher studies.',
          duration: '4 years',
          level: 'Secondary',
          subjects: [
            'English',
            'Mathematics',
            'Physics',
            'Chemistry',
            'Biology',
            'History',
            'Geography',
          ],
          imageUrl:
              'https://via.placeholder.com/300x200/2196F3/FFFFFF?text=Secondary',
          fee: 7000.0,
        ),
        Course(
          id: '3',
          name: 'Higher Secondary',
          description: 'Specialized streams preparing for university entrance.',
          duration: '2 years',
          level: 'Higher Secondary',
          subjects: ['Science Stream', 'Commerce Stream', 'Arts Stream'],
          imageUrl:
              'https://via.placeholder.com/300x200/FF9800/FFFFFF?text=Higher+Secondary',
          fee: 8000.0,
        ),
      ];

      state = AsyncValue.data(courses);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await _loadCourses();
  }
}

final coursesProvider =
    StateNotifierProvider<CoursesNotifier, AsyncValue<List<Course>>>(
      (ref) => CoursesNotifier(),
    );
