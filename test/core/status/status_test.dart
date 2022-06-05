import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/core/status/status.dart';

void main() {
  group('Error group =>', () {
    test('[Idle] should be [Status]', () {
      final status = Idle();

      expect(status, isInstanceOf<Status>());
    });

    test('[InProgress] should be [Status]', () {
      final status = InProgress();

      expect(status, isInstanceOf<Status>());
    });

    test('[Done] should be [Status]', () {
      final status = Done();

      expect(status, isInstanceOf<Status>());
    });

    test('[Error] should be [Status]', () {
      final status = Error();

      expect(status, isInstanceOf<Status>());
    });
  });
}
