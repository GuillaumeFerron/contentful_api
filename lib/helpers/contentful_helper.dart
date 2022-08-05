import 'package:contentful_api/models/contentful_query_type.dart';

class ContentfulHelper {
  static String queryTypeToString(ContentfulQueryType type) {
    switch (type) {
      case ContentfulQueryType.All:
        return '[all]';
      case ContentfulQueryType.Equal:
        return '';
      case ContentfulQueryType.NotEqual:
        return '[ne]';
      case ContentfulQueryType.In:
        return '[in]';
      case ContentfulQueryType.NotIn:
        return '[nin]';
      case ContentfulQueryType.Exists:
        return '[exists]';
      case ContentfulQueryType.LessThan:
        return '[lt]';
      case ContentfulQueryType.LessThanOrEqualTo:
        return '[lte]';
      case ContentfulQueryType.GreaterThan:
        return '[gt]';
      case ContentfulQueryType.GreaterThanOrEqualTo:
        return '[gte]';
      case ContentfulQueryType.Match:
        return '[match]';
      case ContentfulQueryType.Near:
        return '[near]';
      case ContentfulQueryType.Within:
        return '[within]';
      default:
        return queryTypeToString(ContentfulQueryType.Equal);
    }
  }

  static String slugify({required String content, String replacement = '-'}) =>
      content.toLowerCase().replaceAll('/ /g', replacement);

  static List formatContentfulRichText(List<dynamic> content, List<dynamic> assets, List<dynamic> entries) {
    return content
        .fold([], (acc, _) {
          dynamic value;
          switch (_['nodeType']) {
            case 'text':
              value = _['value'];
              break;
            case 'hyperlink':
              value = '${_['data']['uri']}';
              break;
            case 'ordered-list':
            case 'unordered-list':
            case 'list-item':
            case 'paragraph':
              value = _['content'].isNotEmpty
                  ? formatContentfulRichText(_['content'], assets, entries).fold('', (acc, __) => '$acc$__')
                  : formatContentfulRichText(_['content'], assets, entries);
              break;
            case 'embedded-entry-block':
              value = {
                'image':
                    'https:${assets.where((__) => __['sys']['id'] == entries.where((__) => __['sys']['id'] == _['data']['target']['sys']['id']).first['fields']['image']['sys']['id']).first['fields']['file']['url']}',
                'link': '${entries.where((__) => __['sys']['id'] == _['data']['target']['sys']['id']).first['fields']['link']}'
              };
              break;
            case 'embedded-asset-block':
              value = {
                'image':
                    'https:${assets.where((__) => __['sys']['id'] == _['data']['target']['sys']['id']).first['fields']['file']['url']}'
              };
              break;
            default:
              break;
          }
          if (acc == null) {
            return [value];
          }
          return [...{acc}, value];
        })
        .where((_) => _ != null && _.length > 0)
        .toList();
  }

  static String replaceAmp(String value) => value.replaceAll('&amp;', '&');

  static String formatContent(String value) => value.replaceAll('{{requirements}}', '');
}