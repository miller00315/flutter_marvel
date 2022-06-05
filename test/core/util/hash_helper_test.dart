import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/core/util/hash_helper.dart';

main() {
  final faker = Faker();
  group('Hash helper', () {
    test('should convert values to a hash md5', () {
      final testStringList = [
        faker.lorem.word(),
        faker.lorem.word(),
        faker.lorem.word(),
      ];

      final hash = md5.convert(utf8.encode(testStringList.join())).toString();

      expect(generateHash(testStringList), hash);
    });
  });
}
