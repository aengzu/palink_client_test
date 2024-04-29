import 'package:palink_client/data/network/api_services.dart';

import 'package:palink_client/contants/app_url.dart';

class HomeRepositry
{
  // you can call homereapositry with hitAPi
  static Future<dynamic> hitApi() async
  {
    // AppUrl.url : 날씨 정보를 위한 외부 api url
    // await : 해당 처리 끝나는 것 기다림
    // var : 타입 알아서 지정
    print("hitAPI home_repository");
    var response = await ApiServices().getApi(AppUrl.url);
    return response;
  }

}