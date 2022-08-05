library contentful_api;

import 'dart:convert';
import 'package:contentful_api/constants/urls.dart';
import 'package:contentful_api/models/contentful_query.dart';
import 'package:http/http.dart' as http;

/// A Calculator.
class Contentful {
  final String _space;
  final String _env;
  final String _accessToken;

  String get env => _env;
  String get space => _space;

  Contentful({
    required String accessToken,
    required String space,
    String env = 'master'
  }):
    _space = space,
    _env = env,
    _accessToken = accessToken;

  Map<String, dynamic> formatQuery(List<ContentfulQuery> params) => params.fold({}, (acc, _) => {...acc, '${_.key}${_.typeString}' : _.value});

  Future<Map<String, dynamic>> fetchDocuments(Map<String, dynamic> params) async {
    Uri uri = Uri.https(Urls.CONTENTFUL_HOST, Urls.CONTENTFUL_REPO(space, env), {
      'access_token': _accessToken,
      ...params
    });

    http.Response res = await http.Client().get(uri);
    dynamic data = jsonDecode(res.body);

    return data;
  }

  Future<Map<String, dynamic>> fetchDocumentsByType(String type, List<ContentfulQuery> query) async {
    return await fetchDocumentsWithQuery([ContentfulQuery(key: 'content_type', value: type), ...query]);
  }

  Future<Map<String, dynamic>> fetchDocumentsWithQuery(List<ContentfulQuery> query) async {
    List<ContentfulQuery> _query = [...query];
    return await fetchDocuments(formatQuery(_query));
  }
}
