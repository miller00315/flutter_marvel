import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/core/util/uri_helper.dart';

main() {
  group('UriHelper group =>', () {
    test('should return a uri https', () async {
      final uri = generateHttpsUri('test.com', '/test', {'id': '1234'});

      expect(uri.authority, 'test.com');
      expect(uri.path, '/test');
      expect(uri.queryParameters, {'id': '1234'});
      expect(uri.toString().contains('https://'), true);
    });
  });
}
