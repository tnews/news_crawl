library tvc_crawl.parser;

import 'package:html/dom.dart';

import '../domain/news.dart';

part 'vnexpress_parser.dart';

abstract class CategoryParser {
  News parse(Document document);
}

abstract class NewsParser {
  News parse(Document document);
}

abstract class ParserEngine {
  News parse(Document document);
}

class TNewsParserEngine extends ParserEngine {
  static BuilderParserEngine builder() => BuilderParserEngine();

  final Map<dynamic, NewsParser> engine;

  TNewsParserEngine(this.engine);

  @override
  News parse(Document document) {
    return null;
  }
}

class BuilderParserEngine {
  final Map<dynamic, NewsParser> engine = <dynamic, NewsParser>{};

  BuilderParserEngine buildVNExpressParser() {
    engine[VNExpressParser] = VNExpressParser.builder().build();
    return this;
  }

  TNewsParserEngine build() => TNewsParserEngine(engine);
}
