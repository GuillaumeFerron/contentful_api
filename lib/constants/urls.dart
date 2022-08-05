// ignore_for_file: non_constant_identifier_names

class Urls {
  static String CONTENTFUL_HOST = 'cdn.contentful.com';
  static String CONTENTFUL_REPO(space, env) => '/spaces/$space/environments/$env/entries';
}