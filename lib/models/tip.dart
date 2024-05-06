
import 'dart:html';

class Tip {
  final int tipId;
  final int scenarioId;
  final int messageId;
  final Text tipContent;

  // 생성자
  Tip({required this.tipId, required this.scenarioId, required this.messageId, required this.tipContent});

  // JSON 데이터에서 TodayScenario 객체를 생성하는 팩토리 메소드
  factory Tip.fromJson(Map<String, dynamic> json) {
    return Tip(
        tipId: json['tip_id'],
        scenarioId: json['scenario_id'],
        messageId: json['message_id'],
        tipContent: json['tip_content'],
    );
  }

  // TodayScenario 객체를 JSON 형태로 변환하는 메소드
  Map<String, dynamic> toJson() {
    return {
      'tip_id': this.tipId,
      'scenario_id': this.scenarioId,
      'message_id': this.messageId,
      'tip_content': this.tipContent,
    };
  }
}
