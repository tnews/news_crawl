/**
 * @author tvc12
 * @email meomeocf98@gmail.com
 * @create date 2019-10-11 23:53:24
 * @modify date 2019-10-11 23:53:24
 * @desc [parser news]
 */
part of tvc_crawl.parser;

abstract class CategoryParser {
  News parse(NewsParserData htmlData);
}

abstract class NewsParser {
  News parse(NewsParserData htmlData);
}

abstract class ParserEngine {
  News parse(NewsParserData htmlData);
}

class TNewsParserEngine extends ParserEngine {
  static BuilderParserEngine builder() => BuilderParserEngine();

  final Map<Type, NewsParser> engine;

  TNewsParserEngine(this.engine);

  @override
  News parse(NewsParserData htmlData) {
    News news;
    if (htmlData.document != null) {
      if (htmlData.newsParser != null) {
        news = engine[htmlData.newsParser]?.parse(htmlData);
      } else {
        for (NewsParser newsParser in engine.values) {
          news = newsParser.parse(htmlData);
          if (news?.isNews() == true) break;
        }
      }
    }

    return news;
  }
}

class BuilderParserEngine {
  final Map<Type, NewsParser> engine = <Type, NewsParser>{};

  BuilderParserEngine buildVNExpressParser() {
    engine[VNExpressParser] = VNExpressParser.builder().add(NewsCategoryVNExpressParser()).build();
    return this;
  }

  TNewsParserEngine build() => TNewsParserEngine(engine);
}
