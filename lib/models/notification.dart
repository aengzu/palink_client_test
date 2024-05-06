
import 'dart:html';

class Notification {
  final int notificationId;
  final int userId;
  final Text notificationContent;
  final DateTime createdAt;

  Notification({required this.notificationId, required this.userId, required this.notificationContent, required this.createdAt});

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      notificationId: json['notification_id'],
      userId : json['user_id'],
      notificationContent: json['notification_content'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notification_id': notificationId,
      'user_id': userId,
      'notification_content': notificationContent,
      'created_at': createdAt,
    };
  }
}
