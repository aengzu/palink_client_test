
import 'dart:html';

class Role {
  final int roleId;
  final int scenarioId;
  final int roleName;
  final Text roleDescription;

  // 생성자
  Role({required this.roleId, required this.scenarioId, required this.roleName, required this.roleDescription});

  // JSON 데이터에서 TodayScenario 객체를 생성하는 팩토리 메소드
  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      roleId: json['role_id'],
      scenarioId: json['scenario_id'],
      roleName: json['role_name'],
      roleDescription: json['role_description'],
    );
  }

  // TodayScenario 객체를 JSON 형태로 변환하는 메소드
  Map<String, dynamic> toJson() {
    return {
      'role_id': this.roleId,
      'scenario_id': this.scenarioId,
      'role_name': this.roleName,
      'role_description': this.roleDescription,
    };
  }
}
