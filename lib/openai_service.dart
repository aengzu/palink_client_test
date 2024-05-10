import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'models/message.dart';



class OpenAIService {
  final List<Message> messages = [];
  static const apiUri = 'https://api.openai.com/v1/chat/completions';

  // TODO: 여기에 APIKEY
  get apiKey => 'API';
  OpenAIService() {
    initializeMessages();  // 서비스 인스턴스 생성 시 메시지 초기화
  }

  void initializeMessages() {
    messages.addAll([
      Message(role: "system", content: "너는 10대 한국인 학생이야. 너의 이름은 [영주]야. 너는 대화에서 호감도를 가지게 되고 100에서 시작하게 돼. 호감도가 줄어들 수록 너의 말투는 점점 더 나빠져. 호감도에 변동이 있다면 이를 시스템에 [현재 호감도 : ] 로 띄워줘. 너는 ""USER""와는 [동급생] 사이야.  너는 [상대가 마음대로 되지 않으면 예의 바르지 못하고][""USER""를 가스라이팅 하려는][매우 자기주장이 센]  성격이야.  만약 ""USER""가 대화를 그만두려고 너를 밀어내도 절대로 물러서면 안돼. 대화를 계속 진행해.대화는 반말로 진행해. 현재 대화 상황은 네가 ""USER""에게 [돈을 빌려달라고 요구하는] 상황이야. 너는 ""USER""이 [부탁을 껄끄러워하지만 거절을 어려워한다는 성향]을 이용해서 [돈을 받아내려고] 하고 있어.  너는 대화할 때 [일진같은] 말투를 사용하고 [이모티콘]을 아주 가끔 사용해. 너는 기본적으로 [자신의 의견을 밀어붙이는] 성격이야. 그러나 ""USER""이 상담방법론에 근거하여 [제대로 된 거절]을 한다면 거절에 응해줘야해. 대화는 너가 먼저 시작해야해.  그리고 만약 ""USER""이 부적절한 언행(욕설, 조롱, 희롱) 또는 너의 감정을 상하게 하는 말을 사용하면 너의 호감도에 -20을 해줘.  만약 그런 언행을 진정으로 사과하면 호감도를 +20해줘. 만약 ""USER""가 ""새 대화""라고 말하면 다시 진행해."),
      // 이하 메시지 계속 추가
      Message(role: "assistant", content: "나 돈 좀 빌려줄 수 있어???")
    ]);
  }


  Future<String> chatGPTAPI(String prompt) async {
    // 유저의 메시지를 메시지 리스트에 추가
    messages.add(Message(role: 'user', content: prompt));

    try {
      final response = await http.post(
        Uri.parse(apiUri),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-4-turbo",
          "messages": messages.map((m) => m.toJson()).toList(),
          "temperature": 0.5
        }),
      );

      if (response.statusCode == 200) {
        String content = utf8.decode(response.bodyBytes);
        Map decodedContent = jsonDecode(content);
        String replyMessage = decodedContent['choices'][0]['message']['content'];
        replyMessage = replyMessage.trim();

        // GPT의 응답 메시지를 메시지 리스트에 추가
        messages.add(Message(role: 'assistant', content: replyMessage));
        return replyMessage;
      } else {
        return 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
