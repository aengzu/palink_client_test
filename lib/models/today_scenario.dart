
class TodayScenario {
  String category; // 대화 시나리오의 카테고리
  int currentStep; // 사용자가 현재 진행 중인 스텝

  // 생성자
  TodayScenario({required this.category, required this.currentStep});

  // 데이터를 문자열로 변환해주는 메소드
  @override
  String toString() {
    return 'TodayScenario{category: $category, currentStep: $currentStep}';
  }

  // JSON 데이터에서 TodayScenario 객체를 생성하는 팩토리 메소드
  factory TodayScenario.fromJson(Map<String, dynamic> json) {
    return TodayScenario(
      category: json['category'],
      currentStep: json['currentStep'],
    );
  }

  // TodayScenario 객체를 JSON 형태로 변환하는 메소드
  Map<String, dynamic> toJson() {
    return {
      'category': this.category,
      'currentStep': this.currentStep,
    };
  }
}
