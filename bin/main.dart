import 'dart:core';
// import 'dart:html' as html;
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

import 'parser/base_parser.dart';

void main(List<String> args) async {
  http.Response response = await http.get(
    'https://vnexpress.net/thoi-su/hang-nghin-ho-dan-hoang-mang-vi-nuoc-sach-co-mui-la-3995673.html',
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
