import 'package:clubhouse/clubhouse.dart';
import 'package:test/test.dart';

import 'secrets.dart';

void main() {
  group('A group of tests', () {
    ClubhouseAPI api;
    setUp(() {
      api = ClubhouseAPI();
    });

    test('Test phone number auth', () async {
      var response = await api.phoneNumberAuth(phoneNumber);
      print(response);
    }, skip: true);
  });
}
