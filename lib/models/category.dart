class Category {
  final int categoryId;
  final String categoryName;
  List<String> tips;
  List<String> scenarios;

Category({
  required this.categoryId,
  required this.categoryName,
  tips, scenarios
}): this.tips = tips, this.scenarios = scenarios;

}

class PracticeCategory {
  static List<Category> categories = [
    Category(
      categoryName: '거절 연습하기',
      tips: [
        '상황을 명확하게 이해하세요.',
        '단호하게 거절하되, 친절하게 표현하세요.',
        '대안을 제시해 주세요.',
      ],
      scenarios: [
        '돈 빌려달라는 부탁 거절하기',
        '약속 초대 거절하기',
        '회의 참석 요청 거절하기',
      ], categoryId: 1,
    ),
    Category(
      categoryName: '감정 표현 연습하기',
      tips: [
        '자신의 감정을 정확하게 파악하세요.',
        '감정을 표현할 때 명확하고 간결하게 말하세요.',
        '상대방의 감정에 공감하세요.',
      ],
      scenarios: [
        '기쁨을 표현하기',
        '슬픔을 표현하기',
        '화를 표현하기',
      ], categoryId: 2,
    ),
    Category(
      categoryName: '요구/부탁 연습하기',
      tips: [
        '명확하고 직접적으로 요구 또는 부탁하세요.',
        '상황에 따라 적절한 말투와 어투를 사용하세요.',
        '상대방의 의견을 존중하세요.',
      ],
      scenarios: [
        '도움 요청하기',
        '정보 요청하기',
        '의견을 묻기',
      ], categoryId: 3,
    ),
    Category(
      categoryName: '오해 해결 연습하기',
      tips: [
        '상대방의 말을 주의 깊게 들으세요.',
        '오해가 생기면 즉시 해명하세요.',
        '갈등을 피하지 마시고 문제를 해결하기 위해 대화하세요.',
      ],
      scenarios: [
        '잘못된 정보에 대한 오해 해결하기',
        '행동에 대한 오해 해결하기',
        '의도에 대한 오해 해결하기',
      ], categoryId: 4,
    ),
  ];
}
