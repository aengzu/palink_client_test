import 'dart:html';

class ChatMessage {
  final int messageId;
  final int userId;
  final int chatroomId;
  final Text messageContent;
  final DateTime creationDate;

  ChatMessage({required this.messageId, required this.userId, required this.chatroomId, required this.messageContent, required this.creationDate});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      messageId: json['message_id'],
      userId : json['user_id'],
      chatroomId: json['chatroom_id'],
      messageContent : json['message_contest'],
      creationDate : json['creation_date'],);
  }

  Map<String, dynamic> toJson() {
    return {
      'message_id': messageId,
      'user_id': userId,
      'chatroom_id': chatroomId,
      'message_contest': messageContent,
      'creation_date': creationDate,
    };
  }
}
