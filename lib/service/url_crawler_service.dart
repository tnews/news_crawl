part of tvc_crawler.service;

abstract class UrlCrawlerService {
  void save(UrlData data);
  String loadLastedUrl();
  String loadNextPage();
  void _handleError(dynamic ex) => debugPrint(ex);
}

class VnExpressNewsCrawlerService extends UrlCrawlerService {
  static const String baseFolder = 'vnexpess_news';
  static const String fileData = 'news.tvc';
  static const String baseUrl = 'https://vnexpress.net/thoi-su';

  String _nextPage;

  VnExpressNewsCrawlerService() {
    _initData();
  }

  void _initData() {
    final String path = '$baseFolder\\$fileData';
    try {
      _nextPage = File(path).readAsStringSync();
    } catch (ex) {
      debugPrint(ex);
    }
  }

  @override
  String loadLastedUrl() {
    return baseUrl;
  }

  @override
  String loadNextPage() {
    return _nextPage;
  }

  @override
  void save(UrlData urlData) {
    try {
      _saveNextPage(urlData);
      _saveData(urlData);
    } catch (ex) {
      _handleError(ex);
    }
  }

  void _saveNextPage(UrlData data) {
    _nextPage = data.nextPage;
    final String path = '$baseFolder\\$fileData';

    File(path).writeAsStringSync(data.nextPage, mode: FileMode.write);
  }

  void _saveData(UrlData data) {
    final String name = ThinId.randomId();
    final String path = 'vnexpess_news\\$name';
    File(path).writeAsStringSync(data.toStringJson(), flush: true);
  }
}
