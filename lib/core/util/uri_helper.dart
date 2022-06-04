Uri generateHttpsUri(
  String authority,
  String path,
  Map<String, String>? queryParams,
) =>
    Uri.https(
      authority,
      path,
      queryParams,
    );
