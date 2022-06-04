import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/core/filter/filter.dart';

main() {
  group('FilterTest group => ', () {
    test('should return a json from a [Filter]', () {
      final date = DateTime.now();

      final json = Filter(date: date, offset: 0).toJson();

      expect(json['offset'], '0');
      expect(json['ts'], date.toIso8601String());
    });
  });
}
