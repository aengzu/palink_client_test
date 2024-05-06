import 'package:palink_client/data/network/api_services.dart';

import 'package:palink_client/contants/app_url.dart';

class HomeRepositry
{
  static Future<dynamic> hitApi() async
  {
    var response = await ApiServices().getApi(AppUrl.url);
    return response;
  }

}