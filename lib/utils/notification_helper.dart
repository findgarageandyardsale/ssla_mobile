import 'dart:convert';

/// Helper class for sending notifications
/// This file contains examples of notification payloads for different use cases
class NotificationHelper {
  /// Example notification payload for course updates
  static Map<String, dynamic> courseUpdateNotification({
    required String courseName,
    required String message,
    String? courseId,
  }) {
    return {
      'notification': {
        'title': 'Course Update: $courseName',
        'body': message,
        'sound': 'default',
      },
      'data': {
        'type': 'course_update',
        'courseId': courseId ?? '',
        'courseName': courseName,
        'message': message,
        'timestamp': DateTime.now().toIso8601String(),
      },
      'topic':
          'course_updates', // Send to all users subscribed to course updates
    };
  }

  /// Example notification payload for event reminders
  static Map<String, dynamic> eventReminderNotification({
    required String eventTitle,
    required DateTime eventTime,
    String? eventId,
    String? location,
  }) {
    return {
      'notification': {
        'title': 'Event Reminder: $eventTitle',
        'body':
            'Event starts in 1 hour at ${eventTime.hour}:${eventTime.minute.toString().padLeft(2, '0')}',
        'sound': 'default',
      },
      'data': {
        'type': 'event_reminder',
        'eventId': eventId ?? '',
        'eventTitle': eventTitle,
        'eventTime': eventTime.toIso8601String(),
        'location': location ?? '',
        'timestamp': DateTime.now().toIso8601String(),
      },
      'topic': 'event_reminders',
    };
  }

  /// Example notification payload for announcements
  static Map<String, dynamic> announcementNotification({
    required String title,
    required String message,
    String? announcementId,
    String? priority,
  }) {
    return {
      'notification': {'title': title, 'body': message, 'sound': 'default'},
      'data': {
        'type': 'announcement',
        'announcementId': announcementId ?? '',
        'title': title,
        'message': message,
        'priority': priority ?? 'normal',
        'timestamp': DateTime.now().toIso8601String(),
      },
      'topic': 'announcements',
    };
  }

  /// Example notification payload for general notifications
  static Map<String, dynamic> generalNotification({
    required String title,
    required String message,
    String? category,
  }) {
    return {
      'notification': {'title': title, 'body': message, 'sound': 'default'},
      'data': {
        'type': 'general',
        'category': category ?? 'info',
        'title': title,
        'message': message,
        'timestamp': DateTime.now().toIso8601String(),
      },
      'topic': 'general',
    };
  }

  /// Example notification payload for individual users
  static Map<String, dynamic> individualNotification({
    required String title,
    required String message,
    required String fcmToken,
    Map<String, dynamic>? additionalData,
  }) {
    return {
      'to': fcmToken, // Send to specific user
      'notification': {'title': title, 'body': message, 'sound': 'default'},
      'data': {
        'type': 'individual',
        'title': title,
        'message': message,
        'timestamp': DateTime.now().toIso8601String(),
        ...?additionalData,
      },
    };
  }

  /// Example of how to send notifications from your backend (Node.js/Express)
  static String getBackendExample() {
    return '''
// Example Node.js/Express backend code for sending notifications

const admin = require('firebase-admin');
const serviceAccount = require('./path/to/serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

// Send notification to topic
async function sendNotificationToTopic(topic, payload) {
  try {
    const response = await admin.messaging().send({
      topic: topic,
      notification: payload.notification,
      data: payload.data,
    });
    console.log('Successfully sent message:', response);
    return response;
  } catch (error) {
    console.log('Error sending message:', error);
    throw error;
  }
}

// Send notification to specific user
async function sendNotificationToUser(fcmToken, payload) {
  try {
    const response = await admin.messaging().send({
      token: fcmToken,
      notification: payload.notification,
      data: payload.data,
    });
    console.log('Successfully sent message:', response);
    return response;
  } catch (error) {
    console.log('Error sending message:', error);
    throw error;
  }
}

// Example usage:
const courseUpdate = NotificationHelper.courseUpdateNotification(
  'Punjabi Language',
  'New study materials have been uploaded for this week',
  'course_123'
);

await sendNotificationToTopic('course_updates', courseUpdate);
''';
  }

  /// Example of how to send notifications from your backend (Python/Django)
  static String getPythonBackendExample() {
    return '''
# Example Python/Django backend code for sending notifications

import firebase_admin
from firebase_admin import credentials, messaging
import json

# Initialize Firebase Admin SDK
cred = credentials.Certificate("path/to/serviceAccountKey.json")
firebase_admin.initialize_app(cred)

def send_notification_to_topic(topic, payload):
    """Send notification to a topic"""
    try:
        message = messaging.Message(
            notification=messaging.Notification(
                title=payload['notification']['title'],
                body=payload['notification']['body']
            ),
            data=payload['data'],
            topic=topic
        )
        
        response = messaging.send(message)
        print(f'Successfully sent message: {response}')
        return response
    except Exception as e:
        print(f'Error sending message: {e}')
        raise e

def send_notification_to_user(fcm_token, payload):
    """Send notification to specific user"""
    try:
        message = messaging.Message(
            notification=messaging.Notification(
                title=payload['notification']['title'],
                body=payload['notification']['body']
            ),
            data=payload['data'],
            token=fcm_token
        )
        
        response = messaging.send(message)
        print(f'Successfully sent message: {response}')
        return response
    except Exception as e:
        print(f'Error sending message: {e}')
        raise e

# Example usage:
course_update = NotificationHelper.courseUpdateNotification(
    'Punjabi Language',
    'New study materials have been uploaded for this week',
    'course_123'
)

send_notification_to_topic('course_updates', course_update)
''';
  }
}
