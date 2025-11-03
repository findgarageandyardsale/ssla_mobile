import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// EmailJS Configuration
const emailjsServiceId = "service_kbf45wi";
const emailjsTemplateId = "template_fpm8v17";
const emailjsUserId = "mnvGGqOgwWFCuvQwA";
const emailjsPrivateKey =
    "KlpMA4NSyPIrBHqGM_pmn"; // Replace with your actual private key

class EmailService {
  Future<void> sendEmail({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "service_id": emailjsServiceId,
          "template_id": emailjsTemplateId,
          "user_id": emailjsUserId,
          "accessToken": emailjsPrivateKey,
          "template_params": {'name': name, 'email': email, 'message': message},
        }),
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to send email: ${response.statusCode} - ${response.body}',
        );
      }
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
      // final data = {
      //   "to_email": "su@gmail.com",
      //   "to_name": "susan QEQWE",
      //   "from_name": "SSLA School Registration System",
      //   "from_email": "noreply@sslaschool.com",
      //   "reply_to": "admin@sslaschool.com",
      //   "subject": "Registration Confirmation - SSLA School",
      //   "message":
      //       "Dear susan QEQWE,\n\nThank you for submitting your registration to SSLA School!\n\nYour registration has been received and is being processed.\n\nSelected Courses: Punjabi Language, Gurmat\nPreviously Completed Courses: QEQWE\nqweqwe\nqweqwe\n\n\nWe will contact you soon with further details.\n\nBest regards,\nSSLA School Team\n",
      //   "message_html":
      //       "      <html>\n        <body>\n          <h2>Registration Confirmation - SSLA School</h2>\n          <p>Dear <strong>susan QEQWE</strong>,</p>\n          <p>Thank you for submitting your registration to SSLA School!</p>\n          <p>Your registration has been received and is being processed.</p>\n          <h3>Selected Courses:</h3>\n          <ul>\n            <li>Punjabi Language</li><li>Gurmat</li>\n          </ul>\n          <h3>Previously Completed Courses:</h3><p>QEQWE\nqweqwe\nqweqwe\n</p>\n          <p>We will contact you soon with further details.</p>\n          <p>Best regards,<br>SSLA School Team</p>\n        </body>\n      </html>\n    ",
      //   "user_name": "susan QEQWE",
      //   "user_email": "su@gmail.com",
      //   "user_phone": "",
      //   "first_name": "susan",
      //   "middle_name": "",
      //   "last_name": "QEQWE",
      //   "age": "13",
      //   "gender": "Male",
      //   "date_of_birth": "16/8/2020",
      //   "father_name": "qweqwe",
      //   "mother_name": "qweqwe",
      //   "street_address": "qweqweqw",
      //   "apartment_no": "",
      //   "city": "qweqwe",
      //   "state": "qewqe",
      //   "zip_code": "1312",
      //   "home_phone": "123213",
      //   "cell_phone": "1321231",
      //   "email": "su@gmail.com",
      //   "emergency_contact_name": "123wds",
      //   "emergency_contact_phone": "123123",
      //   "emergency_contact_address": "dsasadasd\nadasd",
      //   "emergency_contact_apartment_no": "",
      //   "emergency_contact_city": "qdadsasd",
      //   "emergency_contact_zip_code": "123123",
      //   "language": "Punjabi Language, Gurmat",
      //   "speak_punjabi": "No",
      //   "read_write_punjabi": "No",
      //   "what_inspires": "qewqwe",
      //   "favorite_book": "qeqwe",
      //   "homework_time": "20 minutes",
      //   "student_signature_date": "15/08/2025",
      //   "parent_signature_date": "15/08/2025",
      //   "student_signature_url":
      //       "https://vjaemninbyasytikqdjy.supabase.co/storage/v1/object/public/signatures/student_susan_QEQWE_1755269433260.png",
      //   "parent_signature_url":
      //       "https://vjaemninbyasytikqdjy.supabase.co/storage/v1/object/public/signatures/parent_susan_QEQWE_1755269437601.png",
      //   "submission_date": "2025-08-15 20:35:51.069529",
      //   "form_type": "Student Registration",
      // };

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
          personalInfo: personalInfo,
          familyInfo: familyInfo,
          contactInfo: contactInfo,
          emergencyInfo: emergencyInfo,
          extraInfo: extraInfo,
          studentSignatureUrl: studentSignatureUrl,
          parentSignatureUrl: parentSignatureUrl,
        ),
        'message_html': _formatHtmlEmail(
          studentName: studentName,
          selectedCourses: selectedCourses,
          completedCourses: completedCourses,
          personalInfo: personalInfo,
          familyInfo: familyInfo,
          contactInfo: contactInfo,
          emergencyInfo: emergencyInfo,
          extraInfo: extraInfo,
          studentSignatureUrl: studentSignatureUrl,
          parentSignatureUrl: parentSignatureUrl,
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
      log(jsonEncode(emailData));

      final response = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "service_id": emailjsServiceId,
          "template_id": emailjsTemplateId,
          "user_id": emailjsUserId,
          "accessToken": emailjsPrivateKey,
          "template_params": emailData,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to send registration email: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (error) {
      throw Exception('Failed to send registration email: $error');
    }
  }

  String _formatPlainTextEmail({
    required String studentName,
    required List<String> selectedCourses,
    required String? completedCourses,
    required Map<String, String> personalInfo,
    required Map<String, String> familyInfo,
    required Map<String, String> contactInfo,
    required Map<String, String> emergencyInfo,
    required Map<String, String> extraInfo,
    required String? studentSignatureUrl,
    required String? parentSignatureUrl,
  }) {
    final buffer = StringBuffer();
    final firstName = personalInfo['firstName'] ?? '';
    final lastName = personalInfo['lastName'] ?? '';
    final middleName = personalInfo['middleName'] ?? '';
    final dateOfBirth = personalInfo['dateOfBirth'] ?? '';
    final age = personalInfo['age'] ?? '';
    final gender = personalInfo['gender'] ?? '';
    final isReturningStudent = personalInfo['isReturningStudent'] ?? '';
    final occupation = personalInfo['occupation'] ?? '';

    final fatherName = familyInfo['fatherName'] ?? '';
    final motherName = familyInfo['motherName'] ?? '';

    final email = contactInfo['email'] ?? '';
    final homePhone = contactInfo['homePhone'] ?? '';
    final cellPhone = contactInfo['cellPhone'] ?? '';
    final streetAddress = contactInfo['address'] ?? '';
    final apartmentNo = contactInfo['apartmentNo'] ?? '';
    final city = contactInfo['city'] ?? '';
    final state = contactInfo['state'] ?? '';
    final zipCode = contactInfo['zipCode'] ?? '';

    final emergencyName = emergencyInfo['name'] ?? '';
    final emergencyPhone = emergencyInfo['phone'] ?? '';
    final emergencyAddress = emergencyInfo['address'] ?? '';
    final emergencyApartmentNo = emergencyInfo['apartmentNo'] ?? '';
    final emergencyCity = emergencyInfo['city'] ?? '';
    final emergencyZipCode = emergencyInfo['zipCode'] ?? '';

    final speakPunjabi = extraInfo['speakPunjabi'] ?? '';
    final readWritePunjabi = extraInfo['readWritePunjabi'] ?? '';
    final whatInspires = extraInfo['whatInspires'] ?? '';
    final favoriteBook = extraInfo['favoriteBook'] ?? '';
    final homeworkTime = extraInfo['homeworkTime'] ?? '';

    final studentSignatureDate = personalInfo['studentSignatureDate'] ?? '';
    final parentSignatureDate = personalInfo['parentSignatureDate'] ?? '';

    buffer.writeln('Dear $firstName $lastName,');
    buffer.writeln('');
    buffer.writeln(
      'Thank you for your registration with SSLA School! We\'re excited to have you join our community.',
    );
    buffer.writeln('');
    buffer.writeln('=== PERSONAL INFORMATION ===');
    buffer.writeln(
      'Name: $firstName ${middleName.isNotEmpty ? '$middleName ' : ''}$lastName',
    );
    buffer.writeln('Date of Birth: $dateOfBirth');
    buffer.writeln('Age: $age years old');
    buffer.writeln('Gender: $gender');
    buffer.writeln(
      'Returning Student: ${isReturningStudent == 'yes' ? 'Yes' : 'No'}',
    );
    if (isReturningStudent == 'yes' &&
        completedCourses != null &&
        completedCourses.isNotEmpty) {
      buffer.writeln('Courses Completed at SSLA: $completedCourses');
    }
    buffer.writeln(
      'Occupation: ${occupation.isNotEmpty ? occupation : 'Not specified'}',
    );
    buffer.writeln('');
    buffer.writeln('=== FAMILY INFORMATION ===');
    buffer.writeln('Father\'s Name: $fatherName');
    buffer.writeln('Mother\'s Name: $motherName');
    buffer.writeln('');
    buffer.writeln('=== CONTACT INFORMATION ===');
    buffer.writeln('Email: ${email.isNotEmpty ? email : '-'}');
    buffer.writeln('Home Phone: ${homePhone.isNotEmpty ? homePhone : '-'}');
    buffer.writeln('Cell Phone: ${cellPhone.isNotEmpty ? cellPhone : '-'}');
    buffer.writeln(
      'Street Address: ${streetAddress.isNotEmpty ? streetAddress : '-'}',
    );
    buffer.writeln(
      'Apartment No: ${apartmentNo.isNotEmpty ? apartmentNo : '-'}',
    );
    buffer.writeln(
      'City: ${city.isNotEmpty ? city : '-'}, ${state.isNotEmpty ? state : '-'} ${zipCode.isNotEmpty ? zipCode : '-'}',
    );
    buffer.writeln('');
    buffer.writeln('=== EMERGENCY CONTACT ===');
    buffer.writeln(
      'Emergency Contact Name: ${emergencyName.isNotEmpty ? emergencyName : '-'}',
    );
    buffer.writeln(
      'Emergency Phone: ${emergencyPhone.isNotEmpty ? emergencyPhone : '-'}',
    );
    buffer.writeln(
      'Emergency Address: ${emergencyAddress.isNotEmpty ? emergencyAddress : '-'}',
    );
    buffer.writeln(
      'Emergency Apartment No: ${emergencyApartmentNo.isNotEmpty ? emergencyApartmentNo : '-'}',
    );
    buffer.writeln(
      'Emergency City: ${emergencyCity.isNotEmpty ? emergencyCity : '-'}, ${emergencyZipCode.isNotEmpty ? emergencyZipCode : '-'}',
    );
    buffer.writeln('');
    buffer.writeln('=== COURSES ===');
    buffer.writeln('Courses Selection: ${selectedCourses.join(', ')}');
    buffer.writeln(
      'Speak Punjabi: ${speakPunjabi.isNotEmpty ? speakPunjabi : '-'}',
    );
    buffer.writeln(
      'Read & Write Punjabi: ${readWritePunjabi.isNotEmpty ? readWritePunjabi : '-'}',
    );
    buffer.writeln('');
    buffer.writeln('=== ADDITIONAL INFORMATION ===');
    buffer.writeln(
      'What inspires you to learn Punjabi: ${whatInspires.isNotEmpty ? whatInspires : '-'}',
    );
    buffer.writeln(
      'Favorite Sikh Book: ${favoriteBook.isNotEmpty ? favoriteBook : '-'}',
    );
    buffer.writeln(
      'Daily Homework Time: ${homeworkTime.isNotEmpty ? homeworkTime : '-'}',
    );
    buffer.writeln('');
    buffer.writeln('=== SIGNATURE INFORMATION ===');
    buffer.writeln(
      'Student Signature Date: ${studentSignatureDate.isNotEmpty ? studentSignatureDate : '-'}',
    );
    buffer.writeln(
      'Student Signature: ${studentSignatureUrl != null && studentSignatureUrl.isNotEmpty && studentSignatureUrl != 'Not uploaded' ? studentSignatureUrl : 'Not uploaded'}',
    );
    buffer.writeln(
      'Parent/Guardian Signature Date: ${parentSignatureDate.isNotEmpty ? parentSignatureDate : 'Not provided'}',
    );
    buffer.writeln(
      'Parent/Guardian Signature: ${parentSignatureUrl != null && parentSignatureUrl.isNotEmpty && parentSignatureUrl != 'Not uploaded' ? parentSignatureUrl : 'Not uploaded'}',
    );
    buffer.writeln('');
    buffer.writeln('=== SUBMISSION DETAILS ===');
    buffer.writeln('Submitted on: ${DateTime.now().toLocal().toString()}');
    buffer.writeln('');
    buffer.writeln(
      'We will contact you soon at ${cellPhone.isNotEmpty
          ? cellPhone
          : homePhone.isNotEmpty
          ? homePhone
          : 'the provided contact information'} or ${email.isNotEmpty ? email : 'the provided email address'}.',
    );
    buffer.writeln('');
    buffer.writeln('Best regards,');
    buffer.writeln('SSLA School Registration Team');
    buffer.writeln('');
    buffer.writeln('---');
    buffer.writeln('This is an automated confirmation email.');

    return buffer.toString();
  }

  String _formatHtmlEmail({
    required String studentName,
    required List<String> selectedCourses,
    required String? completedCourses,
    required Map<String, String> personalInfo,
    required Map<String, String> familyInfo,
    required Map<String, String> contactInfo,
    required Map<String, String> emergencyInfo,
    required Map<String, String> extraInfo,
    required String? studentSignatureUrl,
    required String? parentSignatureUrl,
  }) {
    final firstName = personalInfo['firstName'] ?? '';
    final lastName = personalInfo['lastName'] ?? '';
    final middleName = personalInfo['middleName'] ?? '';
    final dateOfBirth = personalInfo['dateOfBirth'] ?? '';
    final age = personalInfo['age'] ?? '';
    final gender = personalInfo['gender'] ?? '';
    final isReturningStudent = personalInfo['isReturningStudent'] ?? '';
    final occupation = personalInfo['occupation'] ?? '';

    final fatherName = familyInfo['fatherName'] ?? '';
    final motherName = familyInfo['motherName'] ?? '';

    final email = contactInfo['email'] ?? '';
    final homePhone = contactInfo['homePhone'] ?? '';
    final cellPhone = contactInfo['cellPhone'] ?? '';
    final streetAddress = contactInfo['address'] ?? '';
    final apartmentNo = contactInfo['apartmentNo'] ?? '';
    final city = contactInfo['city'] ?? '';
    final state = contactInfo['state'] ?? '';
    final zipCode = contactInfo['zipCode'] ?? '';

    final emergencyName = emergencyInfo['name'] ?? '';
    final emergencyPhone = emergencyInfo['phone'] ?? '';
    final emergencyAddress = emergencyInfo['address'] ?? '';
    final emergencyApartmentNo = emergencyInfo['apartmentNo'] ?? '';
    final emergencyCity = emergencyInfo['city'] ?? '';
    final emergencyZipCode = emergencyInfo['zipCode'] ?? '';

    final speakPunjabi = extraInfo['speakPunjabi'] ?? '';
    final readWritePunjabi = extraInfo['readWritePunjabi'] ?? '';
    final whatInspires = extraInfo['whatInspires'] ?? '';
    final favoriteBook = extraInfo['favoriteBook'] ?? '';
    final homeworkTime = extraInfo['homeworkTime'] ?? '';

    final studentSignatureDate = personalInfo['studentSignatureDate'] ?? '';
    final parentSignatureDate = personalInfo['parentSignatureDate'] ?? '';

    return '''
      <html>
        <head>
          <style>
            body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
            .section { margin: 20px 0; }
            .section h3 { color: #2c5aa0; border-bottom: 2px solid #2c5aa0; padding-bottom: 5px; }
            .info-row { margin: 5px 0; }
            .label { font-weight: bold; color: #555; }
            .value { margin-left: 10px; }
            .signature-info { background-color: #f9f9f9; padding: 10px; border-left: 4px solid #2c5aa0; }
            .footer { margin-top: 30px; padding-top: 20px; border-top: 1px solid #ddd; font-size: 0.9em; color: #666; }
          </style>
        </head>
        <body>
          <h2>Registration Confirmation - SSLA School</h2>
          <p>Dear <strong>$firstName $lastName</strong>,</p>
          <p>Thank you for your registration with SSLA School! We're excited to have you join our community.</p>
          
          <div class="section">
            <h3>PERSONAL INFORMATION</h3>
            <div class="info-row"><span class="label">Name:</span><span class="value">$firstName ${middleName.isNotEmpty ? '$middleName ' : ''}$lastName</span></div>
            <div class="info-row"><span class="label">Date of Birth:</span><span class="value">$dateOfBirth</span></div>
            <div class="info-row"><span class="label">Age:</span><span class="value">$age years old</span></div>
            <div class="info-row"><span class="label">Gender:</span><span class="value">$gender</span></div>
            <div class="info-row"><span class="label">Returning Student:</span><span class="value">${isReturningStudent == 'yes' ? 'Yes' : 'No'}</span></div>
            ${isReturningStudent == 'yes' && completedCourses != null && completedCourses.isNotEmpty ? '<div class="info-row"><span class="label">Courses Completed at SSLA:</span><span class="value">$completedCourses</span></div>' : ''}
            <div class="info-row"><span class="label">Occupation:</span><span class="value">${occupation.isNotEmpty ? occupation : 'Not specified'}</span></div>
          </div>
          
          <div class="section">
            <h3>FAMILY INFORMATION</h3>
            <div class="info-row"><span class="label">Father's Name:</span><span class="value">$fatherName</span></div>
            <div class="info-row"><span class="label">Mother's Name:</span><span class="value">$motherName</span></div>
          </div>
          
          <div class="section">
            <h3>CONTACT INFORMATION</h3>
            <div class="info-row"><span class="label">Email:</span><span class="value">${email.isNotEmpty ? email : '-'}</span></div>
            <div class="info-row"><span class="label">Home Phone:</span><span class="value">${homePhone.isNotEmpty ? homePhone : '-'}</span></div>
            <div class="info-row"><span class="label">Cell Phone:</span><span class="value">${cellPhone.isNotEmpty ? cellPhone : '-'}</span></div>
            <div class="info-row"><span class="label">Street Address:</span><span class="value">${streetAddress.isNotEmpty ? streetAddress : '-'}</span></div>
            <div class="info-row"><span class="label">Apartment No:</span><span class="value">${apartmentNo.isNotEmpty ? apartmentNo : '-'}</span></div>
            <div class="info-row"><span class="label">City:</span><span class="value">${city.isNotEmpty ? city : '-'}, ${state.isNotEmpty ? state : '-'} ${zipCode.isNotEmpty ? zipCode : '-'}</span></div>
          </div>
          
          <div class="section">
            <h3>EMERGENCY CONTACT</h3>
            <div class="info-row"><span class="label">Emergency Contact Name:</span><span class="value">${emergencyName.isNotEmpty ? emergencyName : '-'}</span></div>
            <div class="info-row"><span class="label">Emergency Phone:</span><span class="value">${emergencyPhone.isNotEmpty ? emergencyPhone : '-'}</span></div>
            <div class="info-row"><span class="label">Emergency Address:</span><span class="value">${emergencyAddress.isNotEmpty ? emergencyAddress : '-'}</span></div>
            <div class="info-row"><span class="label">Emergency Apartment No:</span><span class="value">${emergencyApartmentNo.isNotEmpty ? emergencyApartmentNo : '-'}</span></div>
            <div class="info-row"><span class="label">Emergency City:</span><span class="value">${emergencyCity.isNotEmpty ? emergencyCity : '-'}, ${emergencyZipCode.isNotEmpty ? emergencyZipCode : '-'}</span></div>
          </div>
          
          <div class="section">
            <h3>COURSES</h3>
            <div class="info-row"><span class="label">Courses Selection:</span><span class="value">${selectedCourses.join(', ')}</span></div>
            <div class="info-row"><span class="label">Speak Punjabi:</span><span class="value">${speakPunjabi.isNotEmpty ? speakPunjabi : '-'}</span></div>
            <div class="info-row"><span class="label">Read & Write Punjabi:</span><span class="value">${readWritePunjabi.isNotEmpty ? readWritePunjabi : '-'}</span></div>
          </div>
          
          <div class="section">
            <h3>ADDITIONAL INFORMATION</h3>
            <div class="info-row"><span class="label">What inspires you to learn Punjabi:</span><span class="value">${whatInspires.isNotEmpty ? whatInspires : '-'}</span></div>
            <div class="info-row"><span class="label">Favorite Sikh Book:</span><span class="value">${favoriteBook.isNotEmpty ? favoriteBook : '-'}</span></div>
            <div class="info-row"><span class="label">Daily Homework Time:</span><span class="value">${homeworkTime.isNotEmpty ? homeworkTime : '-'}</span></div>
          </div>
          
          <div class="section">
            <h3>SIGNATURE INFORMATION</h3>
            <div class="signature-info">
              <div class="info-row"><span class="label">Student Signature Date:</span><span class="value">${studentSignatureDate.isNotEmpty ? studentSignatureDate : '-'}</span></div>
              <div class="info-row"><span class="label">Student Signature:</span><span class="value">${studentSignatureUrl != null && studentSignatureUrl.isNotEmpty && studentSignatureUrl != 'Not uploaded' ? '<a href="$studentSignatureUrl">View Signature</a>' : 'Not uploaded'}</span></div>
              <div class="info-row"><span class="label">Parent/Guardian Signature Date:</span><span class="value">${parentSignatureDate.isNotEmpty ? parentSignatureDate : 'Not provided'}</span></div>
              <div class="info-row"><span class="label">Parent/Guardian Signature:</span><span class="value">${parentSignatureUrl != null && parentSignatureUrl.isNotEmpty && parentSignatureUrl != 'Not uploaded' ? '<a href="$parentSignatureUrl">View Signature</a>' : 'Not uploaded'}</span></div>
            </div>
          </div>
          
          <div class="section">
            <h3>SUBMISSION DETAILS</h3>
            <div class="info-row"><span class="label">Submitted on:</span><span class="value">${DateTime.now().toLocal().toString()}</span></div>
          </div>
          
          <p>We will contact you soon at <strong>${cellPhone.isNotEmpty
        ? cellPhone
        : homePhone.isNotEmpty
        ? homePhone
        : 'the provided contact information'}</strong> or <strong>${email.isNotEmpty ? email : 'the provided email address'}</strong>.</p>
          
          <div class="footer">
            <p><strong>Best regards,</strong><br>
            SSLA School Registration Team</p>
            <hr>
            <p><em>This is an automated confirmation email.</em></p>
          </div>
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
