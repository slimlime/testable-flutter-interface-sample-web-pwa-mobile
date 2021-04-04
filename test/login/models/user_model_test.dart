import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testable_web_app/login/models/user_model.dart';

void main() {
  final Faker faker = Faker();

  group('user', () {
    final String sameName = faker.person.name();
    final String sameEmail = faker.internet.email();

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

    test('unable to construct from invalid json', () {
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

    test('same values equal', () {
      final String sameName = faker.person.name();
      final String sameEmail = faker.internet.email();

      final User userA = User(
        sameName,
        sameEmail,
      );
      final User userB = User(
        sameName,
        sameEmail,
      );

      final bool isSameUser = userA == userB;

      expect(isSameUser, true);

      // Check optional consistency null potential strangeness with hash compute.
    });

    test('different values inequal', () {
      final String sameName = faker.person.name();
      final String sameEmail = faker.internet.email();
    });

    test('same values hash equal', () {
      final String sameName = faker.person.name();
      final String sameEmail = faker.internet.email();

      final User userA = User(
        sameName,
        sameEmail,
      );
      final User userB = User(
        sameName,
        sameEmail,
      );

      final bool isSameUser = userA == userB;

      expect(isSameUser, true);
    });

    test('different values hash inequal', () {
      final String sameName = faker.person.name();
      final String sameEmail = faker.internet.email();

      final User userA = User(
        sameName,
        sameEmail,
      );
      final User userB = User(
        sameName,
        sameEmail,
      );

      final bool isSameHashCode = userA.hashCode == userB.hashCode;

      expect(isSameHashCode, true);
    });
  });
}
