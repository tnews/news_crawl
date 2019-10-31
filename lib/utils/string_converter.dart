part of tvc_crawler.utils;

abstract class StringConverter {
  static final RegExp _regExp = RegExp(r'\r|\n');
  static String removeNewsLine(String text) {
    return text.replaceAll(_regExp, '')?.trim();
  }
}
