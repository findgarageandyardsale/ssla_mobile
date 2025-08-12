import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event.dart';

class EventsNotifier extends StateNotifier<AsyncValue<List<Event>>> {
  EventsNotifier() : super(const AsyncValue.loading()) {
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    try {
      state = const AsyncValue.loading();

      // Static events data
      await Future.delayed(const Duration(milliseconds: 500));

      final events = [
        Event(
          id: '1',
          title: 'Annual Sports Day',
          description:
              'Annual Sports Day with various competitions and activities',
          startDate: DateTime(2024, 12, 15, 9, 0),
          endDate: DateTime(2024, 12, 15, 17, 0),
          location: 'School Ground',
          category: 'Sports',
          isAllDay: true,
          color: '#4CAF50',
        ),
        Event(
          id: '2',
          title: 'Parent-Teacher Meeting',
          description:
              'Quarterly parent-teacher meeting to discuss student progress',
          startDate: DateTime(2024, 11, 30, 14, 0),
          endDate: DateTime(2024, 11, 30, 17, 0),
          location: 'School Auditorium',
          category: 'Academic',
          isAllDay: false,
          color: '#2196F3',
        ),
        Event(
          id: '3',
          title: 'Science Fair',
          description: 'Annual Science Fair showcasing student projects',
          startDate: DateTime(2024, 12, 5, 10, 0),
          endDate: DateTime(2024, 12, 5, 16, 0),
          location: 'School Hall',
          category: 'Academic',
          isAllDay: false,
          color: '#FF9800',
        ),
        Event(
          id: '4',
          title: 'Library Week',
          description: 'Week-long celebration of reading and learning',
          startDate: DateTime(2024, 11, 20),
          endDate: DateTime(2024, 11, 26),
          location: 'School Library',
          category: 'Academic',
          isAllDay: true,
          color: '#9C27B0',
        ),
        Event(
          id: '5',
          title: 'Diwali Holiday',
          description: 'School closed for Diwali celebrations',
          startDate: DateTime(2024, 11, 12),
          endDate: DateTime(2024, 11, 14),
          location: 'School',
          category: 'Holiday',
          isAllDay: true,
          color: '#F44336',
        ),
        Event(
          id: '6',
          title: 'Annual Function',
          description: 'Annual cultural function with performances',
          startDate: DateTime(2024, 12, 20, 18, 0),
          endDate: DateTime(2024, 12, 20, 22, 0),
          location: 'School Auditorium',
          category: 'Cultural',
          isAllDay: false,
          color: '#E91E63',
        ),
      ];

      state = AsyncValue.data(events);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await _loadEvents();
  }
}

final eventsProvider =
    StateNotifierProvider<EventsNotifier, AsyncValue<List<Event>>>(
      (ref) => EventsNotifier(),
    );
