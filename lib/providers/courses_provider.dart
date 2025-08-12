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
          name: 'Punjabi Language',

          imageUrl: 'assets/courses/punjabi.png',
        ),
        Course(
          id: '2',
          name: 'Sikh Theology',

          imageUrl: 'assets/courses/sikh_theology.jpg',
        ),
        Course(
          id: '3',
          name: 'Sikh History',

          imageUrl: 'assets/courses/sikh_history.jpeg',
        ),
        Course(
          id: '4',
          name: 'Gurbani Santhya',

          imageUrl: 'assets/courses/gurbani_ santhiya.jpg',
        ),
        Course(
          id: '5',
          name: 'Gurmat Sangeet',

          imageUrl: 'assets/courses/gurmat_sangeet.png',
        ),
        Course(
          id: '6',
          name: 'Sewa Projectt',

          imageUrl: 'assets/courses/sewa_project.png',
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
