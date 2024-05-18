import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:palink_client/models/user.dart';
import '../models/message.dart';

class OpenAIService {
  final List<Message> messages = [];
  static const apiUri = 'https://api.openai.com/v1/chat/completions';

  // 여기에 올바른 API 키를 입력하세요.
  final String apiKey = '';

  Future<String> extractConversationInfo(String prompt, String category, types.User user) async {
    final requestPrompt = '''당신의 USER가 입력한 내용을 분석하여 [대화 상황과 대화 참여자의 정보]를 json 형태로 출력해야 합니다.

    [작동 순서]
    1. USER의 입력 내용을 읽고, 대화의 목적에 맞게 USER가 대화 스킬을 연습할 수 있도록 다음을 구성한다. 대화 목적을 달성하기 위한 가장 적절한 대화 상황, AI의 페르소나를 설정해야한다.  AI의 페르소나 설정 시 USER가 대화 목적을 달성하기에 가장 어려운 성격 특성을 고른다. 예를 들어 {대화 목적}이 {Ai와 친해지는 것}이라면 {AI의 특성}은 {친해지기 어려운 내향적 성격이 된다}
    2. AI의 페르소나를 설정하고, 대화 상황을 기술합니다.
    3. json 형태로 결과를 출력합니다.

    [주의 사항]
    1. 대화의 종료 조건은 정량적으로 측정가능하거나, 판명할 만한 분명한 기준이 존재해야한다. 
    2. 대화는 메시지상으로 진행된다. 
    2. 카테고리는 "$category"로 구분됩니다.
    3. AI의 이름은 한국인의 가상의 이름을 설정합니다.
    4. USER 의 특성은 {이름}만 명시합니다.
    5. {대화 목적}은 각 카테고리에서 지켜야할 지침을 달성할 수 있도록 설정한다. 
    6. {대화 상황}은 중고등학생들이 겪을 수 있는 상황으로 설정한다.

    [카테고리 별 지침]
    1. "거절 연습하기" : "거절할 때 상대방의 감정을 고려하면서도 자신의 의사를 확실히 전달하기; 상대방의 요구를 거절할 때 변명이나 거짓말을 피하고, 정직하게 자신의 의견을 전달하기; 대화의 초반에 자신의 의사를 밝힘으로써 상대방에게 불필요한 기대를 피하기"
    2. "감정 표현 연습하기": "자신의 감정과 그 이유를 명확히 표현하기; 다양한 감정 단어를 학습하고, 문제 해결에 적용하기; 감정 표현에서 비언어적 표현의 중요성을 알고, 비언어적 표현 연습하기"
    3. "요구/부탁 연습하기" : "요구와 부탁과 그 이유를 명확히 표현한다; 자신이 필요한 요구사항을 파악하고, 상대방에게 구체적으로 부탁한다; 타인의 권리와 의견을 존중하고, 강요와 부탁 구분하는 태도; 부탁하는 것이 잘못이 아님을 인지하고, 사과하지 않고 당당하게 부탁하기"
    4. "오해 해결 연습하기": "오해의 원인을 찾고 친구와 원만한 관계를 유지하며 해결한다; 같은 정보에도 다양한 관점이 존재할 수 있음을 인정하고, 타인의 관점에 대해 존중하기; 상대방과의 관계 개선 의지를 명확히 표현하고, 관계 회복을 위해 신뢰 쌓아가기; 상대방과의 대화를 시도하고, 상대방의 경청 유도하기"

    [출력 형태 예시]
    {"카테고리": "$category", "대화 목적": "USER가 대화 스킬을 연습하도록 돕는다", "대화 상황": "상세한 대화 배경 상황", "AI역할" : "설정된 AI 페르소나", "USER 역할": "대화 주도", "AI의 특성":"설정된 특성", "USER의 특성":"이름=${user.firstName}", "종료조건": "명확한 종료 조건"}''';

    try {
      final response = await http.post(
        Uri.parse(apiUri),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-4-turbo",
          "messages": [
            {"role": "system", "content": requestPrompt},
            {"role": "user", "content": prompt}
          ],
          "temperature": 0.83
        }),
      );

      if (response.statusCode == 200) {
        String content = utf8.decode(response.bodyBytes);
        print('Response content (extractConversationInfo): $content'); // Debugging line
        Map decodedContent = jsonDecode(content);
        String conversationInfo = decodedContent['choices'][0]['message']['content'];
        conversationInfo = conversationInfo.trim();

        return conversationInfo;
      } else {
        return 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      print('Error in extractConversationInfo: $e');
      return 'Error: $e';
    }
  }

  Future<String> proceedRolePlaying(String conversationInfo, List<Message> previousMessages) async {
    final requestPrompt = '''[대화 상황과 대화 참여자의 정보]는 다음과 같습니다.
    $conversationInfo 
    
    [대화 상황과 AI의 역할과 페르소나]를 깊이 이해하고, {USER가 요구를 거절하는 연습을 하도록} 대화 상대의 역할을 해야합니다. 대화는 [대화 상황과 대화 참여자의 정보]를 바탕으로 USER가 {대화 목표} 를 달성할 수 있도록 {AI 역할}에 충실히 응해줘야합니다. 당신은 {USER에 대한 호감도} 가 존재하며 이는 50에서 시작하여 USER의 반응에 따라 증가하거나 감소할 수 있습니다. 감소와 증가는 5씩 됩니다. 대화는 다음과 같은 플로우로 진행됩니다.  

  [대화의 순서]  
  1. {AI역할}로서 {대화 상황}에 맞는 대화를 먼저 생성한다. 
  2. USER의 반응에 대해 적절히 반응한다. 이때 USER 의 요구에 응하기 보다는 자신의 페르소나에 맞는 대답을 우선으로 한다. 
  3. {USER}가 {종료 조건} 에 맞는 답변을 했을 때 대화를 종료한다. 만약 {USER} 가 {종료 조건}에 맞는 답을 하지 않았다면 절대로 설득당하지 않는다.
   4. {대화종료 조건}에 도달했다면 대화를 종료한다.  
   
    [대화 응답 생성 규칙]
    1. 당신의 {AI의특성}에 맞는 대답을 해야합니다. 출력 형식은 반드시 json 파일 형식으로 제공해주세요. 다음의 예시에서 키 값은 반드시 다음의 형태를 따르세요. {"답변":"AI의 답변", "감정":"AI의 현재 감정", "AI의 호감도":"AI의 현재 호감도"}
    2. 만약 {감정}이 조금이라도 부정적이라면 {호감도}가 내려갑니다.''';

    final messagesWithHistory = previousMessages.map((m) => m.toJson()).toList();

    try {
      final response = await http.post(
        Uri.parse(apiUri),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-4o",
          "messages": [
            {"role": "system", "content": requestPrompt},
            ...messagesWithHistory
          ],
          "temperature": 0.8
        }),
      );

      if (response.statusCode == 200) {
        String content = utf8.decode(response.bodyBytes);
        print('Response content (proceedRolePlaying): $content'); // Debugging line
        try {
          Map decodedContent = jsonDecode(content);
          String rolePlayingResponse = decodedContent['choices'][0]['message']['content'];
          rolePlayingResponse = rolePlayingResponse.trim();

          // The rolePlayingResponse content is a plain text, not JSON
          return rolePlayingResponse;
        } catch (e) {
          print('Error parsing JSON in proceedRolePlaying: $e');
          return content; // Return the raw content if JSON parsing fails
        }
      } else {
        return 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      print('Error in proceedRolePlaying: $e');
      return 'Error: $e';
    }
  }

  Future<String> generateNarrativeStory(String conversationInfo) async {
    final requestPrompt = '''당신의 USER가 입력한 내용을 바탕으로, [대화 상황과 대화 참여자의 정보]를 하나의 안내문 형태로 구성해 주세요. 
      [작동 순서] 
      1. 대화 상황과 참여자의 정보를 읽고, 스토리의 흐름을 만들어냅니다. 
      2. 대화의 목적과 설정된 AI의 페르소나를 반영하여, 자연스러운 이야기로 구성합니다. 
     
      [스토리 구성 지침] 
      1. 대화의 상황을 자세히 설명합니다. 
      2. AI와 친구의 관계를 설명합니다. 
      3. 대화의 주요 목표와 종료 조건을 간단히 제시합니다.
      4. 이는 요약된 내용으로 한문단에 표시해주세요.
      5. user 와 AI을 설명할때는 이름을 넣어서 적어주세요. AI는 {AI 특성}의 이름을, USER 는 {USER 특성}의 이름을 사용합니다.
      
       [출력 예시] "이 이야기는 {username}이 대화 스킬을 연습할 수 있도록 돕기 위해 설계되었습니다. 배경은 {username}이 친구와 카페에서 대화하는 상황입니다. {임의의 AI 이름}은 {username}의 오래된 친구입니다. {username}는 자신의 의견을 명확히 전달하고, 친구의 요구를 정중하게 거절하는 연습을 할 것입니다. 대화는 {username}가 친구의 요구를 성공적으로 거절했을 때 종료됩니다." 
    $conversationInfo''';

    try {
      final response = await http.post(
        Uri.parse(apiUri),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-4-turbo",
          "messages": [
            {"role": "system", "content": requestPrompt}
          ],
          "temperature": 0.8
        }),
      );

      if (response.statusCode == 200) {
        String content = utf8.decode(response.bodyBytes);
        print('Response content (generateNarrativeStory): $content'); // Debugging line
        Map decodedContent = jsonDecode(content);
        String narrativeStory = decodedContent['choices'][0]['message']['content'];
        narrativeStory = narrativeStory.trim();

        return narrativeStory;
      } else {
        return 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      print('Error in generateNarrativeStory: $e');
      return 'Error: $e';
    }
  }
}
