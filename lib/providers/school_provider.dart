import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/school_info.dart';

class SchoolNotifier extends StateNotifier<AsyncValue<SchoolInfo>> {
  SchoolNotifier() : super(const AsyncValue.loading()) {
    _loadSchoolInfo();
  }

  Future<void> _loadSchoolInfo() async {
    try {
      state = const AsyncValue.loading();

      final schoolInfo = SchoolInfo(
        name: 'SSLA School',
        philosophy:
            'We recognize and believe in ancient belief that the process of all education is "Intellectual preparation for spiritual progress."',
        vision:
            'The mission of the school is to effectively teach students of all ages to speak, read and write Gurmukhi. Along with teaching the language, the program strives to increase awareness of Sikh theology, Sikh history, appreciation of Gurmat Sangeet, and an understanding of how Shabad Guru helps us to achieve our daily and life long goals. We believe that the more nurtured and informed we are, the more positive and vital our contribution will be to our community, society, country, and the world at large.',
        description:
            'SSLA School is committed to academic excellence and holistic development of students.',
        address: '123 Education Street, City, Country',
        phone: '+1 234 567 8900',
        email: 'info@sslaschool.edu',
        website: 'www.sslaschool.edu',
      );

      state = AsyncValue.data(schoolInfo);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await _loadSchoolInfo();
  }
}

final schoolProvider =
    StateNotifierProvider<SchoolNotifier, AsyncValue<SchoolInfo>>(
      (ref) => SchoolNotifier(),
    );
