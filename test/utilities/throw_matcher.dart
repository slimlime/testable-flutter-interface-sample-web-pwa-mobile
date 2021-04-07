import 'package:flutter_test/flutter_test.dart';
import 'package:json_annotation/json_annotation.dart';

/// Utility to make it easier to test expected error exception throws
/// that do not already have a convenience function
///
/// throwsA(isA<Error>()),
///
///
///
/// https: //github.com/dart-lang/sdk/issues/39305#issuecomment-580732718
Matcher throwsErrorOfType<T extends Error>() {
  // Throws something that matches the isA matcch.

  return throwsA(
    isA<T>(),
  );
}

Matcher throwsExceptionOfType<T extends Exception>() {
  // Throws something that matches the isA matcch.

  return throwsA(
    isA<T>(),
  );
}

Matcher throwsMissingRequiredKeyException() {
  // Throws something that matches the isA matcch.

  return throwsA(
    isA<MissingRequiredKeysException>(),
  );
}

/// Unsure due to `_CastError` found
/* Matcher throwsCastError() => throwsErrorOfType<CastError>(); */
Matcher throwsAnError() => throwsA(isA<Error>());
