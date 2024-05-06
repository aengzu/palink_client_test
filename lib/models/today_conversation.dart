
class TodayConversation {
  final int conversationId;
  final int userId;
  final int scenarioId;

  // 생성자
  TodayConversation({required this.conversationId, required this.userId, required this.scenarioId});

  // JSON 데이터에서 TodayScenario 객체를 생성하는 팩토리 메소드
  factory TodayConversation.fromJson(Map<String, dynamic> json) {
    return TodayConversation(
      conversationId: json['conversation_id'],
      userId: json['user_id'],
      scenarioId: json['scenario_id']
    );
  }

  // TodayScenario 객체를 JSON 형태로 변환하는 메소드
  Map<String, dynamic> toJson() {
    return {
      'conversation_id': this.conversationId,
      'user_id': this.userId,
      'scenario_id': this.scenarioId,
    };
  }
}
