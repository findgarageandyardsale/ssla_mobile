import 'package:emailjs/emailjs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// EmailJS Configuration
const EMAILJS_SERVICE_ID = "service_kbf45wi";
const EMAILJS_TEMPLATE_ID = "template_fpm8v17";
const EMAILJS_PUBLIC_KEY = "mnvGGqOgwWFCuvQwA";

class EmailService {
  Future<void> sendEmail({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      await EmailJS.send(
        EMAILJS_SERVICE_ID,
        EMAILJS_TEMPLATE_ID,
        {'name': name, 'email': email, 'message': message},
        Options(publicKey: EMAILJS_PUBLIC_KEY),
      );
    } catch (error) {
      throw Exception('Failed to send email: $error');
    }
  }

  Future<void> sendRegistrationEmail({
    required String studentName,
    required String parentName,
    required String email,
    required String phone,
    required List<String> selectedCourses,
    required String? completedCourses,
    required String? studentSignatureUrl,
    required String? parentSignatureUrl,
    required Map<String, String> personalInfo,
    required Map<String, String> familyInfo,
    required Map<String, String> contactInfo,
    required Map<String, String> emergencyInfo,
    required Map<String, String> extraInfo,
  }) async {
    try {
      // Format the email content according to the template
      final emailData = {
        'to_email': email,
        'to_name': studentName,
        'from_name': 'SSLA School Registration System',
        'from_email': 'noreply@sslaschool.com',
        'reply_to': 'admin@sslaschool.com',
        'subject': 'Registration Confirmation - SSLA School',

        'message': _formatPlainTextEmail(
          studentName: studentName,
          selectedCourses: selectedCourses,
          completedCourses: completedCourses,
        ),
        'message_html': _formatHtmlEmail(
          studentName: studentName,
          selectedCourses: selectedCourses,
          completedCourses: completedCourses,
        ),

        'user_name': studentName,
        'user_email': email,
        'user_phone': phone,

        'first_name': personalInfo['firstName'] ?? '',
        'middle_name': personalInfo['middleName'] ?? '',
        'last_name': personalInfo['lastName'] ?? '',
        'age': personalInfo['age'] ?? '',
        'gender': personalInfo['gender'] ?? '',
        'date_of_birth': personalInfo['dateOfBirth'] ?? '',

        'father_name': familyInfo['fatherName'] ?? '',
        'mother_name': familyInfo['motherName'] ?? '',

        'street_address': contactInfo['address'] ?? '',
        'apartment_no': contactInfo['apartmentNo'] ?? '',
        'city': contactInfo['city'] ?? '',
        'state': contactInfo['state'] ?? '',
        'zip_code': contactInfo['zipCode'] ?? '',
        'home_phone': contactInfo['homePhone'] ?? '',
        'cell_phone': contactInfo['cellPhone'] ?? '',
        'email': email,

        'emergency_contact_name': emergencyInfo['name'] ?? '',
        'emergency_contact_phone': emergencyInfo['phone'] ?? '',
        'emergency_contact_address': emergencyInfo['address'] ?? '',
        'emergency_contact_apartment_no': emergencyInfo['apartmentNo'] ?? '',
        'emergency_contact_city': emergencyInfo['city'] ?? '',
        'emergency_contact_zip_code': emergencyInfo['zipCode'] ?? '',

        'language': selectedCourses.join(', '),
        'speak_punjabi': extraInfo['speakPunjabi'] ?? '',
        'read_write_punjabi': extraInfo['readWritePunjabi'] ?? '',

        'what_inspires': extraInfo['whatInspires'] ?? '',
        'favorite_book': extraInfo['favoriteBook'] ?? '',
        'homework_time': extraInfo['homeworkTime'] ?? '',

        'student_signature_date': personalInfo['studentSignatureDate'] ?? '',
        'parent_signature_date': personalInfo['parentSignatureDate'] ?? '',
        'student_signature_url': studentSignatureUrl ?? '',
        'parent_signature_url': parentSignatureUrl ?? '',

        'submission_date': DateTime.now().toString(),
        'form_type': 'Student Registration',
      };

      await EmailJS.send(
        EMAILJS_SERVICE_ID,
        EMAILJS_TEMPLATE_ID,
        emailData,
        Options(publicKey: EMAILJS_PUBLIC_KEY),
      );
    } catch (error) {
      throw Exception('Failed to send registration email: $error');
    }
  }

  String _formatPlainTextEmail({
    required String studentName,
    required List<String> selectedCourses,
    required String? completedCourses,
  }) {
    final buffer = StringBuffer();

    buffer.writeln('Dear $studentName,');
    buffer.writeln('');
    buffer.writeln(
      'Thank you for submitting your registration to SSLA School!',
    );
    buffer.writeln('');
    buffer.writeln(
      'Your registration has been received and is being processed.',
    );
    buffer.writeln('');
    buffer.writeln('Selected Courses: ${selectedCourses.join(', ')}');

    if (completedCourses != null && completedCourses.isNotEmpty) {
      buffer.writeln('Previously Completed Courses: $completedCourses');
    }

    buffer.writeln('');
    buffer.writeln('We will contact you soon with further details.');
    buffer.writeln('');
    buffer.writeln('Best regards,');
    buffer.writeln('SSLA School Team');

    return buffer.toString();
  }

  String _formatHtmlEmail({
    required String studentName,
    required List<String> selectedCourses,
    required String? completedCourses,
  }) {
    return '''
      <html>
        <body>
          <h2>Registration Confirmation - SSLA School</h2>
          <p>Dear <strong>$studentName</strong>,</p>
          <p>Thank you for submitting your registration to SSLA School!</p>
          <p>Your registration has been received and is being processed.</p>
          <h3>Selected Courses:</h3>
          <ul>
            ${selectedCourses.map((course) => '<li>$course</li>').join('')}
          </ul>
          ${completedCourses != null && completedCourses.isNotEmpty ? '<h3>Previously Completed Courses:</h3><p>$completedCourses</p>' : ''}
          <p>We will contact you soon with further details.</p>
          <p>Best regards,<br>SSLA School Team</p>
        </body>
      </html>
    ''';
  }
}

// Riverpod provider for email service
final emailServiceProvider = Provider<EmailService>((ref) {
  return EmailService();
});

// Provider for email sending state
final emailSendingProvider =
    StateNotifierProvider<EmailSendingNotifier, AsyncValue<void>>((ref) {
      return EmailSendingNotifier(ref.read(emailServiceProvider));
    });

class EmailSendingNotifier extends StateNotifier<AsyncValue<void>> {
  final EmailService _emailService;

  EmailSendingNotifier(this._emailService) : super(const AsyncValue.data(null));

  Future<void> sendEmail({
    required String name,
    required String email,
    required String message,
  }) async {
    state = const AsyncValue.loading();

    try {
      await _emailService.sendEmail(name: name, email: email, message: message);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}
