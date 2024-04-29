class ChatMessage {
  final int id;
  final int chatRoomId;
  final int senderId;
  final String message;
  final DateTime createdAt;

  ChatMessage({required this.id, required this.chatRoomId, required this.senderId, required this.message, required this.createdAt});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      chatRoomId: json['chat_room_id'],
      senderId: json['sender_id'],
      message: json['message'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chat_room_id': chatRoomId,
      'sender_id': senderId,
      'message': message,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
