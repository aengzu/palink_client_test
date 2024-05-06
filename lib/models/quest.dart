
import 'dart:html';

class Quest {
  final int questId;
  final int scenarioId;
  final String qeustName;
  final Text questContent;

  // 생성자
  Quest({required this.questId, required this.scenarioId, required this.qeustName, required this.questContent});

  // JSON 데이터에서 TodayScenario 객체를 생성하는 팩토리 메소드
  factory Quest.fromJson(Map<String, dynamic> json) {
    return Quest(
      questId: json['quest_id'],
      scenarioId: json['scenario_id'],
      qeustName: json['quest_name'],
      questContent: json['quest_content'],
    );
  }

  // TodayScenario 객체를 JSON 형태로 변환하는 메소드
  Map<String, dynamic> toJson() {
    return {
      'quest_id': this.questId,
      'scenario_id': this.scenarioId,
      'quest_name': this.qeustName,
      'quest_content': this.questContent,
    };
  }
}
