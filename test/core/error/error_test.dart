import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/core/error/failures.dart';

void main() {
  group('Error group =>', () {
    test('[ServerFailure] should be [Failure]', () {
      final failure = ServerFailure();

      expect(failure, isInstanceOf<Failure>());
    });

    test('[UnexpectedFailure] should be [Failure]', () {
      final failure = UnexpectedFailure();

      expect(failure, isInstanceOf<Failure>());
    });
  });
}
