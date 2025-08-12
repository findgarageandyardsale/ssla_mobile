import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/notice.dart';

class NoticesNotifier extends StateNotifier<AsyncValue<List<Notice>>> {
  NoticesNotifier() : super(const AsyncValue.loading()) {
    _loadNotices();
  }

  Future<void> _loadNotices() async {
    try {
      state = const AsyncValue.loading();

      // Static notices data
      await Future.delayed(const Duration(milliseconds: 500));

      final notices = [
        Notice(
          id: '1',
          title: 'Annual Sports Day',
          content:
              'Annual Sports Day will be held on December 15th, 2024. All students are encouraged to participate.',
          category: 'Events',
          date: DateTime.now().subtract(const Duration(days: 2)),
          isImportant: true,
        ),
        Notice(
          id: '2',
          title: 'Parent-Teacher Meeting',
          content:
              'Parent-Teacher meeting scheduled for November 30th, 2024. Please make sure to attend.',
          category: 'Academic',
          date: DateTime.now().subtract(const Duration(days: 5)),
          isImportant: true,
        ),
        Notice(
          id: '3',
          title: 'Library Week',
          content:
              'Library Week celebration from November 20-26, 2024. Various activities planned for students.',
          category: 'Academic',
          date: DateTime.now().subtract(const Duration(days: 8)),
          isImportant: false,
        ),
        Notice(
          id: '4',
          title: 'Holiday Notice',
          content:
              'School will remain closed for Diwali from November 12-14, 2024.',
          category: 'Holiday',
          date: DateTime.now().subtract(const Duration(days: 10)),
          isImportant: false,
        ),
        Notice(
          id: '5',
          title: 'Science Fair',
          content:
              'Annual Science Fair will be held on December 5th, 2024. Project submissions due by November 25th.',
          category: 'Events',
          date: DateTime.now().subtract(const Duration(days: 12)),
          isImportant: true,
        ),
      ];

      state = AsyncValue.data(notices);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await _loadNotices();
  }
}

final noticesProvider =
    StateNotifierProvider<NoticesNotifier, AsyncValue<List<Notice>>>(
      (ref) => NoticesNotifier(),
    );
