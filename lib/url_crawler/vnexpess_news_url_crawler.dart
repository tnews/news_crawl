part of tvc_crawler.url_crawler;

class VNExpressNewsUrlCrawler extends UrlCrawler {
  final VnExpressNewsCrawlerService service;
  VNExpressNewsUrlCrawler(this.service);

  @override
  Future<void> crawl() {
    final String url = service.loadLastedUrl();
    return http
        .get(url)
        .then((http.Response response) => parse(response.body))
        .then(_parse)
        .then(service.save)
        .catchError(_handleError);
  }

  UrlData _parse(Document document) {
    final List<String> urls = _getListNews(document);
    final String prePage = _getPrePage(document);
    final String nextPage = _getNextPage(document);
    if (urls?.isNotEmpty == true) {
      return UrlData(nextPage: nextPage, prePage: prePage, urls: urls);
    } else
      return null;
  }

  List<String> _getListNews(Document document) {
    final String query = '.container > .sidebar_1';
    try {
      final Element listingNews = document.querySelector(query);
      return listingNews.children.map(_getUrlFromNews).where((String item) => item?.isNotEmpty).toList();
    } catch (ex) {
      debugPrint(ex);
      return <String>[];
    }
  }

  String _getUrlFromNews(Element element) {
    if (element.className == 'list_news') {
      final String query = 'a';
      try {
        final Element node = element.querySelector(query);
        return node.attributes['href'];
      } catch (ex) {
        return null;
      }
    } else
      return null;
  }

  String _getPrePage(Document document) {
    final String query = '.pre';
    try {
      return VnExpressNewsCrawlerService.baseUrl + document.querySelector(query).attributes['href'];
    } catch (ex) {
      debugPrint(ex);
      return null;
    }
  }

  String _getNextPage(Document document) {
    final String query = '.next';
    try {
      return VnExpressNewsCrawlerService.baseUrl + document.querySelector(query).attributes['href'];
    } catch (ex) {
      debugPrint(ex);
      return null;
    }
  }
}
