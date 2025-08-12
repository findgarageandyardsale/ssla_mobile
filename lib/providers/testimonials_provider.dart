import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/testimonial.dart';

class TestimonialsNotifier
    extends StateNotifier<AsyncValue<List<Testimonial>>> {
  TestimonialsNotifier() : super(const AsyncValue.loading()) {
    _loadTestimonials();
  }

  Future<void> _loadTestimonials() async {
    try {
      state = const AsyncValue.loading();

      final testimonials = [
        Testimonial(
          id: '1',
          name: 'Kristine Pommert',
          role: 'BBC World Service Religion British Broadcasting Corp., London',
          content:
              'One of a kind. Vision of the school is admirable. School is well organized and disciplined to achieve it\'s ultimate goal.',
        ),
        Testimonial(
          id: '2',
          name: 'Inderjit Singh J.P.',
          role: 'Editor: Sikh Messenger, London',
          content:
              'Excellent organization. Well organized program with a student centered approach. Good student, teacher and parent team work.',
        ),
        Testimonial(
          id: '3',
          name: 'Dr. Raghbir Singh',
          role:
              'Chairman of Punjabi Department, Punjabi University, Patiala Punjab',
          content:
              'Sikh School of Los Angeles offers a unique platform to celebrate Sikh culture in America. Philosophy of the school is great, curriculum is well thought and planned.',
        ),
        Testimonial(
          id: '4',
          name: 'Mohinder Singh',
          role: 'Alumni',
          content:
              'Sikh School of Los Angeles is brilliantly doing an excellent job of imparting Sikh religious knowledge to the young children who are the future of our community and nation.',
        ),
      ];

      state = AsyncValue.data(testimonials);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await _loadTestimonials();
  }
}

final testimonialsProvider =
    StateNotifierProvider<TestimonialsNotifier, AsyncValue<List<Testimonial>>>(
      (ref) => TestimonialsNotifier(),
    );
