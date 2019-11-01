import 'dart:core';
import 'package:tvc_crawl/parser/parser.dart';
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:tvc_crawl/tvc_crawl.dart';

void main(List<String> args) async {
  TNewsParserEngine parserEngine = TNewsParserEngine.builder().buildVNExpressParser().build();
  String url = 'https://vnexpress.net/thoi-su/hang-nghin-ho-dan-hoang-mang-vi-nuoc-sach-co-mui-la-3995673.html';
  http.Response response = await http.get(url);

  try {
    Document document = parse(response.body);
    debugPrint(document.querySelectorAll('.title_news_detail').first.text);
    final NewsParserData data = NewsParserData(url: url, document: document);
    final News news = parserEngine.parse(data);
    debugPrint(news.toStringJson());
    // File file = File(news.id);
    // file.openWrite()
    //   ..write(news.toStringJson())
    //   ..flush()
    //   ..close();
  } catch (ex) {
    debugPrint(ex);
  }
}
