/**
 * @author tvc12
 * @email meomeocf98@gmail.com
 * @create date 2019-10-11 23:53:24
 * @modify date 2019-10-11 23:53:24
 * @desc [parser news]
 */
part of tvc_crawl.parser;

class HtmlData {
  final String url;
  final Document document;
  final String thumbnail;
  final Type newsParser;

  HtmlData({
    @required this.url,
    @required this.document,
    this.thumbnail,
    this.newsParser,
  }) : assert(url != null, 'url musn\'t null');

  @override
  String toString() => '$runtimeType url: $url';
}

abstract class CategoryParser {
  News parse(HtmlData htmlData);
}

abstract class NewsParser {
  News parse(HtmlData htmlData);
}

abstract class ParserEngine {
  News parse(HtmlData htmlData);
}

class TNewsParserEngine extends ParserEngine {
  static BuilderParserEngine builder() => BuilderParserEngine();

  final Map<Type, NewsParser> engine;

  TNewsParserEngine(this.engine);

  @override
  News parse(HtmlData htmlData) {
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
