import 'dart:core';
// import 'dart:html' as html;
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

import 'parser/base_parser.dart';

void main(List<String> args) async {
  http.Response response = await http.get(
    'https://vnexpress.net/the-gioi/tham-phan-tu-ban-minh-sau-khi-tuyen-an-3992360.html',
  );

  TNewsParserEngine parserEngine =
      TNewsParserEngine.builder().buildVNExpressParser().build();
  try {
    Document document = parse(response.body);
    // debugPrint(document.querySelectorAll('.title_news_detail').first.text);
    debugPrint(parserEngine.parse(document));
    // html.querySelectorAll('p');
  } catch (ex) {
    debugPrint(ex);
  }
}

void debugPrint(dynamic ex) {
  //ignore: avoid_print
  print(ex);
}
