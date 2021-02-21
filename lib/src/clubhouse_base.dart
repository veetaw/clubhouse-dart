import 'package:clubhouse/src/utils.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

Dio dio = Dio(); // TODO: move this

class ClubhouseAPI {
  static const String apiUrl = 'https://www.clubhouseapi.com/api';
  static const String appBuildId = '304';
  static const String appVersion = '0.1.28';

  static const String appUserAgent =
      'clubhouse/$appBuildId (iPhone; iOS 14.4; Scale/2.00)';
  static const String appUserAgentStatic =
      'Clubhouse/$appBuildId CFNetwork/1220.1 Darwin/20.3.0';

  static const String pubKey = 'pub-c-6878d382-5ae6-4494-9099-f930f938868b';
  static const String subKey = 'sub-c-a4abea84-9ca3-11ea-8e71-f2b83ac9263d';

  static const String twitterId = 'NyJhARWVYU1X3qJZtC2154xSI';
  static const String twitterSecret =
      'ylFImLBFaOE362uwr4jut8S8gXGWh93S1TUKbkfh7jDIPse02o';

  static const String agoraKey = '938de3e8055e42b281bb8c6f69c21f78';
  static const String sentryKey =
      '5374a416cd2d4009a781b49d1bd9ef44@o325556.ingest.sentry.io/5245095';
  static const String instabugKey = '4e53155da9b00728caa5249f2e35d6b3';
  static const String amplitudeKey = '9098a21a950e7cb0933fb5b30affe5be';

  Map<String, String> headers = {
    'CH-Languages': 'en-JP,ja-JP',
    'CH-Locale': 'en_JP',
    'Accept': 'application/json',
    'Accept-Language': 'en-JP;q=1, ja-JP;q=0.9',
    'Accept-Encoding': 'gzip, deflate',
    'CH-AppBuild': '$appBuildId',
    'CH-AppVersion': '$appVersion',
    'User-Agent': '$appUserAgent',
    'Connection': 'close',
    'Content-Type': 'application/json; charset=utf-8',
    'Cookie': '__cfduid=${Utils.generateToken(21)}${Utils.generateInt(1, 9)}'
  };

  ClubhouseAPI({
    String userId,
    String userToken,
    String userDevice,
  }) {
    headers['CH-UserID'] = userId ?? '(null)';
    if (userToken != null) headers['Authorization'] = 'Token $userToken';
    headers['CH-DeviceId'] =
        userDevice != null ? userDevice.toUpperCase() : Uuid().v4();
  }

  Future phoneNumberAuth(String phoneNumber) async {
    if (headers.containsKey('Authorization')) {
      throw Exception('Already Authenticated');
    }

    var response = await dio.post(
      '$apiUrl/start_phone_number_auth',
      data: {'phone_number': phoneNumber},
      options: Options(
        headers: headers,
      ),
    );

    return response.data;
  }

  Future callPhoneNumberAuth(String phoneNumber) async {
    if (headers.containsKey('Authorization')) {
      throw Exception('Already Authenticated');
    }

    var response = await dio.post(
      '$apiUrl/call_phone_number_auth',
      data: {'phone_number': phoneNumber},
      options: Options(
        headers: headers,
      ),
    );

    return response.data;
  }

  Future resendPhoneNumberAuth(String phoneNumber) async {
    if (headers.containsKey('Authorization')) {
      throw Exception('Already Authenticated');
    }

    var response = await dio.post(
      '$apiUrl/resend_phone_number_auth',
      data: {'phone_number': phoneNumber},
      options: Options(
        headers: headers,
      ),
    );

    return response.data;
  }

  Future completePhoneNumberAuth(
      String phoneNumber, String verificationCode) async {
    if (headers.containsKey('Authorization')) {
      throw Exception('Already Authenticated');
    }

    var response = await dio.post(
      '$apiUrl/complete_phone_number_auth',
      data: {
        'phone_number': phoneNumber,
        'verification_code': verificationCode,
      },
      options: Options(
        headers: headers,
      ),
    );

    return response.data;
  }

  Future checkForUpdate({bool isTestFlight = false}) async {
    var response = await dio.post(
      '$apiUrl/check_for_update',
      queryParameters: {
        'is_testflight': isTestFlight,
      },
      options: Options(
        headers: headers,
      ),
    );

    return response.data;
  }

  Future getReleaseNotes() async {
    if (!headers.containsKey('Authorization')) {
      throw Exception('Must Authenticate before');
    }

    var response = await dio.post(
      '$apiUrl/get_release_notes',
      options: Options(headers: headers),
    );

    return response.data;
  }

  Future checkWaitlistStatus() async {
    if (!headers.containsKey('Authorization')) {
      throw Exception('Must Authenticate before');
    }

    var response = await dio.post('$apiUrl/check_waitlist_status',
        options: Options(headers: headers));

    return response.data;
  }

  Future addEmail(String email) async {
    if (headers.containsKey('Authorization')) {
      throw Exception('Already Authenticated');
    }

    var response = await dio.post(
      '$apiUrl/add_email',
      data: {
        'email': email,
      },
      options: Options(
        headers: headers,
      ),
    );

    return response.data;
  }

  Future updatePhoto(String filePath) async {
    throw UnimplementedError();
  }

  Future follow(
    int userId, {
    List<int> userIds,
    int source = 4,
    int sourceTopicID,
  }) async {
    if (headers.containsKey('Authorization')) {
      throw Exception('Already Authenticated');
    }

    var response = await dio.post(
      '$apiUrl/follow',
      data: {
        'source_topic_id': sourceTopicID,
        'user_ids': userIds,
        'user_id': userId,
        'source': source,
      },
      options: Options(
        headers: headers,
      ),
    );

    return response.data;
  }

  Future unfollow(int userId) async {
    if (headers.containsKey('Authorization')) {
      throw Exception('Already Authenticated');
    }

    var response = await dio.post(
      '$apiUrl/unfollow',
      data: {
        'user_id': userId,
      },
      options: Options(
        headers: headers,
      ),
    );

    return response.data;
  }
}
