import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testable_web_app/login/models/user_model.dart';

import '../../utilities/throw_matcher.dart';

void main() {
  final Faker faker = Faker();
  group('user', () {
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

    final Map<String, dynamic> validJsonExtraKeyIgnored = <String, dynamic>{
      'email': sameEmail,
      'name': sameName,
      'randomkey': 'qweasdzxc',
    };

    final Map<String, dynamic> invalidJsonNoName = <String, dynamic>{
      'email': sameEmail,
    };
    final Map<String, dynamic> invalidJsonNoEmail = <String, dynamic>{
      'name': sameName,
    };
    final Map<String, dynamic> invalidJsonSingleRandomKey = <String, dynamic>{
      'randomkey': 'qweasdzxc',
    };

    test('can construct', () {
      User(
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

      // ignore: unused_local_variable
      final User parsedUserFromJson = User.fromJson(jsonA);
      // ignore: unused_local_variable
      final User parsedUserExtraDataIgnored = User.fromJson(
        validJsonExtraKeyIgnored,
      );

      // No errors!
    });

    test('should be unable to construct from invalid json deserialisation', () {
      final User user = User(
        faker.person.name(),
        faker.internet.email(),
      );
      final Map<String, dynamic> validUserJson = user.toJson();

      // ignore: unused_local_variable
      final User parsedUserFromJson = User.fromJson(validUserJson);

      /// Previous throw.
      ///  Exception has occurred.
      /// _CastError (type 'Null' is not a subtype of type 'String' in type cast)
      ///
      expect(
        () {
          User.fromJson(invalidJsonNoEmail);
        },
        // throwsCastError(),
        throwsMissingRequiredKeyException(),
      );
      expect(
        () {
          User.fromJson(invalidJsonNoName);
        },
        throwsMissingRequiredKeyException(),
      );

      /// https://github.com/dart-lang/sdk/issues/39305
      /// Random key, missing required keys
      expect(
        () {
          User.fromJson(invalidJsonSingleRandomKey);
        },
        anyOf(
          throwsMissingRequiredKeyException(),
        ),
      );
    });

    test('can encode to json', () {
      final User user = User(
        faker.person.name(),
        faker.internet.email(),
      );

      // ignore: unused_local_variable
      final Map<String, dynamic> userJson = user.toJson();

      final String reserialisedJsonEncode = jsonEncode(user);
      final String reserialisedJsonEncodeAlias = json.encode(user);

      // Not expecting any inconsistencies
      //
      expect(
        reserialisedJsonEncode == reserialisedJsonEncodeAlias,
        true,
      );
    });

    test('same values equal', () {
      final bool isSameUser = userA == userB;

      expect(isSameUser, true);

      // Check optional consistency null potential strangeness with hash compute.
    });

    test('different values inequal', () {
      
    });

    test('same values hash equal', () {
      final bool isSameUser = userA == userB;

      expect(isSameUser, true);
    });

    test('different values hash inequal', () {
      final bool isSameHashCode = userA.hashCode == userB.hashCode;

      expect(isSameHashCode, true);
    });
  });
}
