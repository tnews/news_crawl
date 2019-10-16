/**
 * @author tvc12
 * @email meomeocf98@gmail.com
 * @create date 2019-10-11 23:53:24
 * @modify date 2019-10-11 23:53:24
 * @desc [parser news]
 */
part of tvc_crawl.parser;

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

  final Map<Type, NewsParser> engine;

  TNewsParserEngine(this.engine);

  @override
  News parse(Document document) {
    News news;
    for (NewsParser newsParser in engine.values) {
      news = newsParser.parse(document);
      if (news is News) break;
    }
    return news;
  }
}

class BuilderParserEngine {
  final Map<Type, NewsParser> engine = <Type, NewsParser>{};

  BuilderParserEngine buildVNExpressParser() {
    engine[VNExpressParser] =
        VNExpressParser.builder().add(NewsCategoryVNExpressParser()).build();
    return this;
  }

  TNewsParserEngine build() => TNewsParserEngine(engine);
}
