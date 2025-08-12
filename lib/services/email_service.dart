import 'package:emailjs/emailjs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// EmailJS Configuration
const EMAILJS_SERVICE_ID = "service_o78wdau";
const EMAILJS_TEMPLATE_ID = "template_mzgbzts";
const EMAILJS_PUBLIC_KEY = "1OyQZZKDBZCipeCP0";

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
        {
          'name': name,
          'email': email,
          'message': message,
        },
        Options(publicKey: EMAILJS_PUBLIC_KEY),
      );
    } catch (error) {
      throw Exception('Failed to send email: $error');
    }
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
      await _emailService.sendEmail(
        name: name,
        email: email,
        message: message,
      );
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}
