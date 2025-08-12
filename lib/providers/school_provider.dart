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
            'We recognize and believe in ancient belief that the process '
            'of all education is "Intellectual preparation for spiritual progress."',
        vision:
            'The mission of the school is to effectively teach students of '
            'all ages to speak, read and write Gurmukhi. Along with teaching '
            'the language, the program strives to increase awareness of Sikh '
            'theology, Sikh history, appreciation of Gurmat Sangeet, and an '
            'understanding of how Shabad Guru helps us to achieve our daily '
            'and life long goals. We believe that the more nurtured and '
            'informed we are, the more positive and vital our contribution '
            'will be to our community, society, country, and the world at large.',
        description:
            'SSLA School is committed to academic excellence and '
            'holistic development of students.',
        address: '9989 LAUREL CANYON BLVD, PACOIMA, CA, 91331',
        phone:
            'NATASHA KAUR (630) 267-3480\nJOGINDER SINGH SIDHU (818) 266-4757',
        email: 'cksssla1997@gmail.com',
        website: 'www.sslaschool.edu',
        aboutUsNurturing:
            'Established on August 9, 1997, our school has been '
            'a vibrant center of Sikh learning and community engagement for '
            'over two decades. With ten well-equipped classrooms, we serve '
            'students ranging in age from 4 to 18, and also offer dedicated '
            'classes for adults over 18.\n\n'
            'Students are thoughtfully grouped based on both their age and '
            'their proficiency in Gurmukhi, ensuring a supportive and '
            'personalized learning experience. For those over the age of 18, '
            'we offer structured courses in Sikh theology and history.\n\n'
            'Our curriculum goes beyond academics. We offer a wide range of '
            'activities that foster personal and spiritual development, '
            'allowing each student to grow in confidence, character, and '
            'community values. All instructional materials are thoughtfully '
            'designed to align with the learning styles of students raised '
            'in Western educational environments.',
        aboutUsWeeklySchedule:
            'Our classes are held every Sunday and are '
            'designed to enrich both the mind and spirit:\n\n'
            '• Academic and Gurmat Classes: Sunday, 9:30 a.m. – 12:50 p.m.\n'
            '• Dilruba and Tabla Classes: Sunday, 2:30 p.m. – 4:30 p.m.\n\n'
            'At the heart of our mission is a commitment to continuous '
            'improvement. We are always evolving—refining our programs and '
            'teaching approaches to provide the best possible learning '
            'experience for every student.',
        aboutUsDescription:
            'Sikh School of Los Angeles is a progressive '
            'school, where staff is dedicated to helping each and every '
            'student reach his/her maximum potential. The students are '
            'assisted in achieving their maximum potential through '
            'student-centered, group learning coupled with individualized '
            'instructions. Parent involvement is key to our success. '
            'Students, staff and parents work together as a team to create '
            'a friendly yet disciplined learning environment.',
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
