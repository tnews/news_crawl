import 'dart:core';
// import 'dart:html' as html;
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

void main(List<String> args) async {
  http.Response response = await http.get(
      'https://vnexpress.net/the-gioi/tham-phan-tu-ban-minh-sau-khi-tuyen-an-3992360.html');

  try {
    Document document = parse(response.body);
    debugPrint(document.querySelectorAll('.title_news_detail').first.text);
    // html.querySelectorAll('p');
  } catch (ex) {
    debugPrint(ex);
  }
}

void debugPrint(dynamic ex) {
  //ignore: avoid_print
  print(ex);
}
