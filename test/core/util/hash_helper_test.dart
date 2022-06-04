import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/core/util/hash_helper.dart';

main() {
  group('Hash helper', () {
    test('should convert values to a hash md5', () {
      const testStringList = ['abc', 'efg', 'hij'];

      final hash = md5.convert(utf8.encode(testStringList.join())).toString();

      expect(generateHash(testStringList), hash);
    });
  });
}
