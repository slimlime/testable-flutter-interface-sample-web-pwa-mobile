import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testable_web_app/login/models/user_model.dart';

void main() {
  const Faker faker = Faker();

  group('user', () {
    test('can construct', () {
      final User user = User(
        faker.person.name(),
        faker.internet.email(),
      );
    });

    test('can construct from json', () {
      final User user = User(
        faker.person.name(),
        faker.internet.email(),
      );

      final Map<String, dynamic> jsonA = user.toJson();

      final User parsedUserFromJson = User.fromJson(jsonA);
    });

    test('can encode to json', () {
      final User user = User(
        faker.person.name(),
        faker.internet.email(),
      );
      user.toJson();
      jsonEncode(user);

      final String jsonB = jsonEncode(user);
      final String jsonC = json.encode(user);
    });
  });
}
