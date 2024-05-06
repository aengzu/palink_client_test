import 'dart:html';

class ChatRoom {
  final int chatroomId;
  final int scenarioId;
  final int userId;
  final String chatroomName;
  final String status;
  final DateTime creationDate;

  ChatRoom({required this.chatroomId, required this.scenarioId, required this.userId, required this.chatroomName, required this.status, required this.creationDate});

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      chatroomId: json['chatroom_id'],
      scenarioId : json['scenario_id'],
      userId: json['user_id'],
      chatroomName : json['chatroom_name'],
      status : json['status'],
      creationDate : json['creation_date'],);
  }

  Map<String, dynamic> toJson() {
    return {
      'chatroom_id': chatroomId,
      'scenario_id': scenarioId,
      'user_id': userId,
      'chatroom_name': chatroomName,
      'status': status,
      'creation_date': creationDate,
    };
  }
}
