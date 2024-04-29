import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:palink_client/Data/Network/base_api_services.dart';
import 'package:palink_client/data/app_exception.dart';

// `ApiServices` 클래스는 `BaseApiServices` 추상 클래스를 구현합니다.
// 이 클래스는 네트워크를 통해 데이터를 가져오는 구체적인 메서드를 제공합니다.
class ApiServices extends BaseApiServices {
  // `jsonResponse` 메소드는 http 응답을 받아 상태 코드에 따라 처리합니다.
  dynamic jsonResponse(http.Response response){
    switch(response.statusCode){
      case 200:  // HTTP 200 OK 응답을 받았을 경우, 응답 본문을 JSON으로 디코딩합니다.
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:  // HTTP 400 Bad Request 응답을 받았을 경우, 응답 본문을 JSON으로 디코딩합니다.
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      default:   // 기타 모든 상황에 대해 예외를 발생시킵니다.
        throw FetchDataException(
            'Error while communication ${response.statusCode}'
        );
    }
  }

  // `getApi` 메소드는 주어진 URL에서 데이터를 비동기적으로 가져옵니다.
  @override
  Future getApi(String url) async{
    var jsonData;  // JSON 데이터를 저장할 변수
    try {
      // HTTP GET 요청을 보내고, 10초 후 타임아웃 처리합니다.
      var response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      jsonData = jsonResponse(response);  // 응답을 처리하여 JSON 데이터를 추출합니다.
    } on RequestTimeOut {
      // 요청 타임아웃 예외 처리
      throw RequestTimeOut('Request Timeout');
    } on SocketException {
      // 인터넷 연결 예외 처리
      throw InternetException('No internet');
    }
    return jsonData;  // 추출한 JSON 데이터를 반환합니다.
  }
}
