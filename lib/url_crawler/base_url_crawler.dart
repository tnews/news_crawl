part of tvc_crawler.url_crawler;

@immutable
class UrlData {
  final List<String> urls;
  final String nextPage;
  final String prePage;

  UrlData({this.urls, this.nextPage, this.prePage});

  @override
  String toString() => 'Url data: $nextPage, $prePage';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    addValueToMap('urls', urls, map);
    addValueToMap('next_page', nextPage, map);
    addValueToMap('pre_page', prePage, map);

    return map;
  }

  String toStringJson() {
    return json.encode(toJson());
  }
}

abstract class NewsCrawler {
  NewsParserData crawl(String url);
}

abstract class UrlCrawler {
  Future<void> crawl();

  void _handleError(dynamic ex) => debugPrint(ex);
}

class TNewsUrlCrawler {
  final Map<Type, UrlCrawler> crawlers;

  TNewsUrlCrawler(this.crawlers);

  void run(Type typeCrawler, {int numberNews = 150}) {
    try {
      // final UrlCrawler crawler = crawlers[typeCrawler];
      // if (crawler != null) {
      //   final String latestUrl = crawler.loadLastedUrl();
      //   final Future<UrlData> data = crawler.crawl(latestUrl);
      //   crawler.save(data);
      //   final String nextPage = crawler.loadNextPage();
      //   final Future<UrlData> nextData = crawler.crawl(nextPage);
      //   crawler.save(nextData);
      // }
    } catch (ex) {
      debugPrint(ex);
    }
  }

  static TNewsUrlCrawlerBuilder builder() => TNewsUrlCrawlerBuilder();
}

class TNewsUrlCrawlerBuilder {
  final Map<Type, UrlCrawler> crawlers = <Type, UrlCrawler>{};

  TNewsUrlCrawlerBuilder add(UrlCrawler value) {
    crawlers[value.runtimeType] = value;
    return this;
  }

  TNewsUrlCrawler build() => TNewsUrlCrawler(crawlers);
}
