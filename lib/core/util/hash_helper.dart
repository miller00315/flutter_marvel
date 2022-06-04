import 'dart:convert';

import 'package:crypto/crypto.dart';

String generateHash(List<String> values) =>
    md5.convert(utf8.encode(values.join())).toString();
