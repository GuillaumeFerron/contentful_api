import 'package:contentful_api/helpers/contentful_helper.dart';
import 'package:contentful_api/models/contentful_query_type.dart';

class ContentfulQuery {
  final String _key;
  final ContentfulQueryType _type;
  final dynamic _value;

  ContentfulQuery({
    required String key,
    ContentfulQueryType type = ContentfulQueryType.Equal,
    dynamic value
  }):
    _key = key,
    _type = type,
    _value = value;

  String get key => _key;
  dynamic get value => _value;
  ContentfulQueryType get type => _type;
  String get typeString => ContentfulHelper.queryTypeToString(type);
}
