// 추상 클래스 `BaseApiServices` 정의
// 이 클래스는 모든 API 서비스들이 구현해야 할 기본적인 메소드를 정의한다.
abstract class BaseApiServices {
  // GET 요청을 처리하는 추상 메소드 `getApi`
  // - `url`: API 엔드포인트의 URL을 문자열로 전달받는다
  // - 반환값: 비동기적으로 데이터를 반환. 반환 데이터의 형식은 dynamic
  //   -> 호출하는 측에서 반환 데이터의 구체적인 타입을 알고 있어야 함을 의미
  Future<dynamic> getApi(String url);
}
